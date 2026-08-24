// Copyright (c) 2026 opx. All rights reserved.

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

public sealed record HybridDeviceSnapshot(
    string Platform,
    string Device,
    string FormFactor,
    string NetworkAccess)
{
    public static HybridDeviceSnapshot Unknown { get; } = new("Unknown", "Unknown", "Unknown", "Unknown");
}

public sealed record HybridCapabilityResult(bool Succeeded, string Message);

public sealed record HybridStatusBarAppearance(string BackgroundColor, bool UseLightContent);

public interface IHybridDeviceAdapter
{
    HybridDeviceSnapshot GetSnapshot();
    Task<HybridCapabilityResult> PickFileAsync();
    Task<HybridCapabilityResult> CapturePhotoAsync();
    Task<HybridCapabilityResult> ShareAsync(string text);
    Task<HybridCapabilityResult> ProbeSecureStorageAsync();
}

public interface IHybridSessionBootstrapper
{
    ValueTask RestoreAsync(CancellationToken cancellationToken = default);
}

public interface IHybridStatusBarService
{
    ValueTask<double> ApplyAsync(
        HybridStatusBarAppearance appearance,
        CancellationToken cancellationToken = default);
}
