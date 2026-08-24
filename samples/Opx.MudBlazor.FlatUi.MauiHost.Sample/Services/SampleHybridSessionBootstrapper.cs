// Copyright (c) 2026 opx. All rights reserved.

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

public sealed class SampleHybridSessionBootstrapper : IHybridSessionBootstrapper
{
    public ValueTask RestoreAsync(CancellationToken cancellationToken = default)
    {
        cancellationToken.ThrowIfCancellationRequested();

        // Consumer responsibility: read the saved token from SecureStorage,
        // validate or refresh it through the backend, then update auth state.
        return ValueTask.CompletedTask;
    }
}
