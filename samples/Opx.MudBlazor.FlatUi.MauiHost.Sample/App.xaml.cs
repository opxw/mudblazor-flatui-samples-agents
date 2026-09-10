// Copyright (c) 2026 opx. All rights reserved.

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

public partial class App : Application
{
    private readonly MainPage _mainPage;

    public App(MainPage mainPage)
    {
        InitializeComponent();
        _mainPage = mainPage;
    }

    protected override Window CreateWindow(IActivationState? activationState)
    {
        var window = new Window(_mainPage);
        window.Stopped += (_, _) => _mainPage.SuspendRefreshForBackground();
        window.Resumed += (_, _) => _mainPage.ResumeRefreshFromBackground();
        window.Destroying += (_, _) => _mainPage.SuspendRefreshForBackground();
        return window;
    }
}
