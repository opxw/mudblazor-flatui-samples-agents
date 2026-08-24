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

    protected override Window CreateWindow(IActivationState? activationState) =>
        new(_mainPage);
}
