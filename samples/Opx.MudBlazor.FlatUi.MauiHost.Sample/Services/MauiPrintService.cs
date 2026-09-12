// Copyright (c) 2026 opx. All rights reserved.
using Opx.MudBlazor.FlatUi.Services;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

public sealed class MauiPrintService : IFlatPrintService
{
    private int _active;

    public ValueTask<FlatPrintCapabilities> GetCapabilitiesAsync(CancellationToken cancellationToken = default) =>
        new(MainThread.InvokeOnMainThreadAsync(() =>
        {
#if ANDROID
            return new FlatPrintCapabilities(Platform.CurrentActivity?.GetSystemService(Android.Content.Context.PrintService)
                is Android.Print.PrintManager, true, "Android");
#elif WINDOWS
            return new FlatPrintCapabilities(Application.Current?.Windows.Count > 0, false, "Windows");
#else
            return new FlatPrintCapabilities(false, false, "Unsupported");
#endif
        }));

    public async Task<FlatPrintResult> PrintAsync(FlatPrintRequest request, CancellationToken cancellationToken = default)
    {
        ArgumentNullException.ThrowIfNull(request);
        if (cancellationToken.IsCancellationRequested) return new(FlatPrintStatus.Cancelled);
        if (!request.IsValid) return new(FlatPrintStatus.Failed, "Invalid or oversized PDF document.");
        if (Interlocked.CompareExchange(ref _active, 1, 0) != 0)
            return new(FlatPrintStatus.Failed, "Another print request is active.");
        var path = Path.Combine(FileSystem.CacheDirectory, $"opx-print-{Guid.NewGuid():N}.pdf");
        try
        {
            await File.WriteAllBytesAsync(path, request.PdfBytes.ToArray(), cancellationToken);
            return await MainThread.InvokeOnMainThreadAsync(async () =>
            {
                cancellationToken.ThrowIfCancellationRequested();
#if ANDROID
                var activity = Platform.CurrentActivity;
                if (activity?.GetSystemService(Android.Content.Context.PrintService) is not Android.Print.PrintManager manager)
                    return new FlatPrintResult(FlatPrintStatus.Unsupported);
                var completion = new TaskCompletionSource<FlatPrintResult>(TaskCreationOptions.RunContinuationsAsynchronously);
                using var adapter = new AndroidPdfPrintAdapter(path, request.Title, completion);
                adapter.Job = manager.Print(request.Title, adapter, null);
                // After dispatch use the native print dialog's cancellation. A token must
                // not delete the file while the system is still reading it.
                return await completion.Task;
#elif WINDOWS
                return await WindowsPdfPrintPage.ShowAsync(path, request.Title);
#else
                return new FlatPrintResult(FlatPrintStatus.Unsupported);
#endif
            });
        }
        catch (OperationCanceledException) { return new(FlatPrintStatus.Cancelled); }
        catch (Exception) { return new(FlatPrintStatus.Failed, "Native PDF printing could not be started."); }
        finally
        {
            try { File.Delete(path); } catch (IOException) { } catch (UnauthorizedAccessException) { }
            Volatile.Write(ref _active, 0);
        }
    }
}
