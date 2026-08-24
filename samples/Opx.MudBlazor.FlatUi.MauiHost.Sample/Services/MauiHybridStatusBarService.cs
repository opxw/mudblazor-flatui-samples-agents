// Copyright (c) 2026 opx. All rights reserved.

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

public sealed class MauiHybridStatusBarService(MainPage mainPage) : IHybridStatusBarService
{
    public async ValueTask<double> ApplyAsync(
        HybridStatusBarAppearance appearance,
        CancellationToken cancellationToken = default)
    {
        ArgumentNullException.ThrowIfNull(appearance);
        cancellationToken.ThrowIfCancellationRequested();

        await mainPage.ApplyStatusBarAsync(appearance.UseLightContent);
        return await mainPage.GetStatusBarInsetAsync();
    }
}
