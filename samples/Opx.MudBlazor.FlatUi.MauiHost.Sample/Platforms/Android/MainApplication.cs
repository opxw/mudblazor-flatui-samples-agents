// Copyright (c) 2026 opx. All rights reserved.

using Android.App;
using Android.Runtime;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

[Application]
public class MainApplication(nint handle, JniHandleOwnership ownership) : MauiApplication(handle, ownership)
{
    protected override MauiApp CreateMauiApp() => MauiProgram.CreateMauiApp();
}
