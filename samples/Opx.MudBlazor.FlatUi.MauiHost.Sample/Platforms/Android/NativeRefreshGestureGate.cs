// Copyright (c) 2026 opx. All rights reserved.
using Android.Views;
using Android.Webkit;
using AndroidX.SwipeRefreshLayout.Widget;
using Opx.MudBlazor.FlatUi.Services;
using System.Globalization;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample;

// No JS interface is exposed to arbitrary navigation. Only a bounded boolean is read.
internal sealed class NativeRefreshGestureGate(FlatNativePullToRefreshState state)
    : Java.Lang.Object, SwipeRefreshLayout.IOnChildScrollUpCallback
{
    private int _generation;
    private bool _down, _eligible, _pending;
    private float _x, _y;

    public bool CanChildScrollUp(SwipeRefreshLayout parent, Android.Views.View? child) =>
        !state.IsEnabled || (!_down && !_eligible);

    public void BeforeDispatch(MotionEvent e, Android.Webkit.WebView webView)
    {
        if (e.ActionMasked == MotionEventActions.Down)
        {
            _generation++; _eligible = false; _pending = true; _down = true;
            _x = e.RawX; _y = e.RawY;
            if (!state.IsEnabled || webView.Width <= 0 || webView.Height <= 0) { _pending = false; return; }
            var location = new int[2]; webView.GetLocationOnScreen(location);
            var x = ((_x - location[0]) / webView.Width).ToString(CultureInfo.InvariantCulture);
            var y = ((_y - location[1]) / webView.Height).ToString(CultureInfo.InvariantCulture);
            var generation = _generation;
            webView.EvaluateJavascript($"window.opxFlatPullRefresh?.canStartNative({x}*innerWidth,{y}*innerHeight) === true",
                new BooleanResult(value =>
                {
                    if (generation != _generation) return;
                    _pending = false; _eligible = value && state.IsEnabled;
                }));
        }
        else if (e.ActionMasked == MotionEventActions.Move)
        {
            var dx = Math.Abs(e.RawX - _x); var dy = e.RawY - _y;
            var slop = webView.Context is { } context ? ViewConfiguration.Get(context)?.ScaledTouchSlop ?? 8 : 8;
            if (Math.Max(dx, Math.Abs(dy)) > slop && (_pending || dy < 0 || dx > dy))
            {
                _generation++; _pending = false; _eligible = false;
            }
        }
        else if (e.ActionMasked == MotionEventActions.PointerDown)
        {
            _generation++; _pending = false; _eligible = false;
        }
    }

    public void AfterDispatch(MotionEvent e)
    {
        _down = false;
        if (e.ActionMasked is MotionEventActions.Up or MotionEventActions.Cancel)
        {
            _generation++; _eligible = false; _pending = false;
        }
    }

    private sealed class BooleanResult(Action<bool> completed) : Java.Lang.Object, IValueCallback
    {
        public void OnReceiveValue(Java.Lang.Object? value) => completed(value?.ToString() == "true");
    }
}
