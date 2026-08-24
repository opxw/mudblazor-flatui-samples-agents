namespace Opx.MudBlazor.FlatUi.Maui.Template;

public partial class MainPage : ContentPage
{
    private readonly MobileThemeBridge _themeBridge;

    public MainPage(MobileThemeBridge themeBridge)
    {
        InitializeComponent();
        _themeBridge = themeBridge;
        BindingContext = themeBridge;
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();
        _themeBridge.ReapplyNativeChrome();
    }
}
