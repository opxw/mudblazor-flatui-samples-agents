// Copyright (c) 2026 opx. All rights reserved.
using Android.Content;
using Microsoft.Maui.Handlers;
using Microsoft.Maui.Platform;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

public sealed class NativeRefreshViewHandler : RefreshViewHandler
{
    protected override MauiSwipeRefreshLayout CreatePlatformView() => new GatedMauiSwipeRefreshLayout(Context);
}

internal sealed class GatedMauiSwipeRefreshLayout(Context context) : MauiSwipeRefreshLayout(context)
{
    internal NativeRefreshGestureGate? GestureGate { get; set; }

    // MAUI 10.0.20 overrides CanChildScrollUp without consulting AndroidX's callback.
    public override bool CanChildScrollUp() => !RefreshEnabled ||
        (GestureGate?.CanChildScrollUp(this, null) ?? true);
}
