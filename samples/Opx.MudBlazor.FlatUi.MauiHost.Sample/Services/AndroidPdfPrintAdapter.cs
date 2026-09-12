// Copyright (c) 2026 opx. All rights reserved.
#if ANDROID
using Android.Graphics;
using Android.Graphics.Pdf;
using Android.OS;
using Android.Print;
using Opx.MudBlazor.FlatUi.Services;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

internal sealed class AndroidPdfPrintAdapter(string path, string title,
    TaskCompletionSource<FlatPrintResult> completion) : PrintDocumentAdapter
{
    public PrintJob? Job { get; set; }
    private bool _failed;

    public override void OnLayout(PrintAttributes? oldAttributes, PrintAttributes? newAttributes,
        CancellationSignal? cancellationSignal, LayoutResultCallback? callback, Bundle? extras)
    {
        if (cancellationSignal?.IsCanceled == true) { callback?.OnLayoutCancelled(); return; }
        try
        {
            using var file = ParcelFileDescriptor.Open(new Java.IO.File(path), ParcelFileMode.ReadOnly);
            using var renderer = new PdfRenderer(file!);
            if (renderer.PageCount > 50) throw new InvalidOperationException();
            var info = new PrintDocumentInfo.Builder(title).SetContentType(PrintContentType.Document)
                .SetPageCount(renderer.PageCount).Build();
            _failed = false;
            callback?.OnLayoutFinished(info, false);
        }
        catch (Exception) { _failed = true; callback?.OnLayoutFailed("PDF cannot be printed (maximum 50 pages)."); }
    }

    public override void OnWrite(PageRange[]? pages, ParcelFileDescriptor? destination,
        CancellationSignal? cancellationSignal, WriteResultCallback? callback)
    {
        try
        {
            using var file = ParcelFileDescriptor.Open(new Java.IO.File(path), ParcelFileMode.ReadOnly);
            using var renderer = new PdfRenderer(file!);
            using var document = new PdfDocument();
            var written = new List<PageRange>();
            for (var i = 0; i < renderer.PageCount; i++)
            {
                if (cancellationSignal?.IsCanceled == true) { callback?.OnWriteCancelled(); return; }
                if (pages is null || !pages.Any(range => i >= range.Start && i <= range.End)) continue;
                using var source = renderer.OpenPage(i);
                var width = source.Width; var height = source.Height;
                if (width <= 0 || height <= 0 || (long)width * height * 4 > 16 * 1024 * 1024)
                    throw new InvalidOperationException();
                // Render one bounded page at 144dpi; Android's print service owns the printer.
                using var bitmap = Bitmap.CreateBitmap(width * 2, height * 2, Bitmap.Config.Argb8888!)!;
                bitmap.EraseColor(Android.Graphics.Color.White);
                source.Render(bitmap, null, null, PdfRenderMode.ForPrint);
                var output = document.StartPage(new PdfDocument.PageInfo.Builder(width, height, i).Create()!);
                output!.Canvas!.DrawBitmap(bitmap, null, new Android.Graphics.Rect(0, 0, width, height), null);
                document.FinishPage(output);
                written.Add(new PageRange(i, i));
            }
            if (cancellationSignal?.IsCanceled == true) { callback?.OnWriteCancelled(); return; }
            using var stream = new ParcelFileDescriptor.AutoCloseOutputStream(destination!);
            using var managedStream = new Android.Runtime.OutputStreamInvoker(stream);
            document.WriteTo(managedStream);
            _failed = false;
            callback?.OnWriteFinished(written.ToArray());
        }
        catch (Exception) { _failed = true; callback?.OnWriteFailed("PDF pages could not be rendered."); }
    }

    public override void OnFinish()
    {
        completion.TrySetResult(new FlatPrintResult(Job?.IsCancelled == true ? FlatPrintStatus.Cancelled
            : Job?.IsCompleted == true ? FlatPrintStatus.Completed
            : _failed || Job?.IsFailed == true ? FlatPrintStatus.Failed : FlatPrintStatus.Submitted));
        base.OnFinish();
    }
}
#endif
