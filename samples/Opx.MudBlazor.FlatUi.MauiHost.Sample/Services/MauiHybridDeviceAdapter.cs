// Copyright (c) 2026 opx. All rights reserved.

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

public sealed class MauiHybridDeviceAdapter : IHybridDeviceAdapter
{
    private const string ProbeKey = "opx.flat-ui.hybrid.sample.probe";

    public HybridDeviceSnapshot GetSnapshot() => new(
        DeviceInfo.Current.Platform.ToString(),
        $"{DeviceInfo.Current.Manufacturer} {DeviceInfo.Current.Model}".Trim(),
        DeviceInfo.Current.Idiom.ToString(),
        Connectivity.Current.NetworkAccess.ToString());

    public async Task<HybridCapabilityResult> PickFileAsync()
    {
        try
        {
            var file = await FilePicker.Default.PickAsync(new PickOptions
            {
                PickerTitle = "Choose a sample file"
            });
            return file is null
                ? new(false, "File selection was cancelled.")
                : new(true, $"Selected file: {file.FileName}");
        }
        catch (Exception exception) when (exception is FeatureNotSupportedException or PermissionException)
        {
            return Unsupported("File picker", exception);
        }
    }

    public async Task<HybridCapabilityResult> CapturePhotoAsync()
    {
        try
        {
            if (!MediaPicker.Default.IsCaptureSupported)
                return new(false, "Camera capture is not supported by this host.");

            var photo = await MediaPicker.Default.CapturePhotoAsync();
            return photo is null
                ? new(false, "Camera capture was cancelled.")
                : new(true, $"Captured photo: {photo.FileName}");
        }
        catch (Exception exception) when (exception is FeatureNotSupportedException or PermissionException)
        {
            return Unsupported("Camera", exception);
        }
    }

    public async Task<HybridCapabilityResult> ShareAsync(string text)
    {
        try
        {
            await Share.Default.RequestAsync(new ShareTextRequest
            {
                Title = "Share OPX Flat UI sample",
                Text = text
            });
            return new(true, "The native share sheet was opened.");
        }
        catch (FeatureNotSupportedException exception)
        {
            return Unsupported("Share", exception);
        }
    }

    public async Task<HybridCapabilityResult> ProbeSecureStorageAsync()
    {
        try
        {
            var value = Guid.NewGuid().ToString("N");
            await SecureStorage.Default.SetAsync(ProbeKey, value);
            var restored = await SecureStorage.Default.GetAsync(ProbeKey);
            SecureStorage.Default.Remove(ProbeKey);
            return restored == value
                ? new(true, "SecureStorage write/read/remove probe succeeded.")
                : new(false, "SecureStorage returned a different value.");
        }
        catch (Exception exception) when (exception is FeatureNotSupportedException or InvalidOperationException)
        {
            return Unsupported("SecureStorage", exception);
        }
    }

    private static HybridCapabilityResult Unsupported(string capability, Exception exception) =>
        new(false, $"{capability} is unavailable: {exception.Message}");
}
