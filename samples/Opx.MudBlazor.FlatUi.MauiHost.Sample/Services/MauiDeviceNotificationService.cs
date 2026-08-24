// Copyright (c) 2026 opx. All rights reserved.

using Opx.MudBlazor.FlatUi.Models;
using Opx.MudBlazor.FlatUi.Services;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

public sealed class MauiDeviceNotificationService : IDeviceNotificationService
{
    public ValueTask<FlatDeviceNotificationStatus> ShowAsync(
        FlatDeviceNotificationRequest notification,
        CancellationToken cancellationToken = default)
    {
        cancellationToken.ThrowIfCancellationRequested();

        // Register a platform implementation here. Permission requests must start
        // from a user gesture; channel/category, scheduling and tap routing remain
        // responsibilities of the Android, Windows or iOS host.
        return ValueTask.FromResult(FlatDeviceNotificationStatus.Unsupported);
    }
}
