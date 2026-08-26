// Copyright (c) 2026 opx. All rights reserved.

namespace Opx.MudBlazor.FlatUi.Sample.Services;

public sealed class SampleStartupGateService
{
    public ValueTask CheckAsync(CancellationToken cancellationToken = default)
    {
        cancellationToken.ThrowIfCancellationRequested();

        // UI-only sample: a consumer performs saved-session/token validation,
        // updates its authentication state, and resolves anonymous navigation here.
        return ValueTask.CompletedTask;
    }
}
