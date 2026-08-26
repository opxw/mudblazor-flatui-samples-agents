using Microsoft.JSInterop;

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

    public async Task<bool> TryHandleModalBackAsync()
    {
        Task<bool>? modalBackTask = null;

        try
        {
            var dispatched = await BlazorView.TryDispatchAsync(services =>
            {
                var js = services.GetRequiredService<IJSRuntime>();
                modalBackTask = js.InvokeAsync<bool>("opxFlatModalHistory.tryHandleBack").AsTask();
            });

            if (!dispatched || modalBackTask is null)
            {
                return false;
            }

            return await modalBackTask;
        }
        catch (JSDisconnectedException)
        {
            return false;
        }
        catch (InvalidOperationException)
        {
            return false;
        }
    }

    public Task<bool> TryHandleBlazorBackAsync()
    {
#if ANDROID
        return Dispatcher.DispatchAsync(() =>
        {
            if (BlazorView.Handler?.PlatformView is not Android.Webkit.WebView webView
                || !webView.CanGoBack())
            {
                return false;
            }

            webView.GoBack();
            return true;
        });
#else
        return Task.FromResult(false);
#endif
    }
}
