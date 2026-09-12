// Copyright (c) 2026 opx. All rights reserved.
#if WINDOWS
using Opx.MudBlazor.FlatUi.Services;
using Microsoft.Web.WebView2.Core;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

internal sealed class WindowsPdfPrintPage : ContentPage
{
    private readonly TaskCompletionSource<FlatPrintResult> _closed = new(TaskCreationOptions.RunContinuationsAsynchronously);
    private readonly WebView _view = new();
    private bool _submitted;
    private bool _failed;

    private WindowsPdfPrintPage(string path, string title)
    {
        Title = title;
        var print = new Button { Text = "Print PDF", IsEnabled = false };
        var close = new Button { Text = "Close" };
        _view.Navigated += (_, args) => print.IsEnabled = args.Result == WebNavigationResult.Success;
        print.Clicked += (_, _) =>
        {
            try
            {
                if (_view.Handler?.PlatformView is not Microsoft.UI.Xaml.Controls.WebView2 native || native.CoreWebView2 is null)
                { _failed = true; return; }
                native.CoreWebView2.ShowPrintUI(CoreWebView2PrintDialogKind.Browser);
                _submitted = true;
            }
            catch (Exception) { _failed = true; }
        };
        close.Clicked += async (_, _) => await Navigation.PopModalAsync();
        var grid = new Grid { RowDefinitions = { new RowDefinition(GridLength.Auto), new RowDefinition(GridLength.Star) } };
        grid.Add(new HorizontalStackLayout { Padding = 12, Spacing = 12, Children = { print, close } });
        grid.Add(_view, 0, 1);
        Content = grid;
        _view.Source = new Uri(path).AbsoluteUri;
    }

    protected override void OnDisappearing()
    {
        base.OnDisappearing();
        _view.Source = "about:blank";
        _closed.TrySetResult(new(_failed ? FlatPrintStatus.Failed : _submitted ? FlatPrintStatus.Submitted : FlatPrintStatus.Cancelled));
    }

    public static async Task<FlatPrintResult> ShowAsync(string path, string title)
    {
        var owner = Application.Current?.Windows.FirstOrDefault()?.Page;
        if (owner is null) return new(FlatPrintStatus.Unsupported);
        var page = new WindowsPdfPrintPage(path, title);
        await owner.Navigation.PushModalAsync(page);
        return await page._closed.Task;
    }
}
#endif
