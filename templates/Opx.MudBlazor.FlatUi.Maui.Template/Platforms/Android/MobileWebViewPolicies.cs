using Microsoft.AspNetCore.Components.WebView.Maui;

namespace Opx.MudBlazor.FlatUi.Maui.Template;

internal static class MobileWebViewPolicies
{
    internal static void Configure() =>
        BlazorWebViewHandler.BlazorWebViewMapper.AppendToMapping("OpxNoBounce", static (handler, _) =>
            handler.PlatformView.OverScrollMode = Android.Views.OverScrollMode.Never);
}
