namespace Opx.MudBlazor.FlatUi.Maui.Template;

public partial class App : Application
{
    private readonly MainPage _mainPage;
    private readonly MobileThemeBridge _themeBridge;

    public App(MainPage mainPage, MobileThemeBridge themeBridge)
    {
        InitializeComponent();
        _mainPage = mainPage;
        _themeBridge = themeBridge;
    }

    protected override Window CreateWindow(IActivationState? activationState) =>
        new(_mainPage) { Title = "OPX Flat UI Mobile" };

    protected override void OnResume()
    {
        base.OnResume();
        _themeBridge.ReapplyNativeChrome();
    }
}
