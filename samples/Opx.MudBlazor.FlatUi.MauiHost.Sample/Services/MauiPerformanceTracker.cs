// Copyright (c) 2026 opx. All rights reserved.

using System.Diagnostics;

namespace Opx.MudBlazor.FlatUi.MauiHost.Sample.Services;

public sealed record MauiStartupPerformanceSample(string Stage, double ElapsedMilliseconds);

public sealed record MauiRoutePerformanceSample(
    string Route,
    int Count,
    double LastMilliseconds,
    double MinimumMilliseconds,
    double MaximumMilliseconds,
    double AverageMilliseconds);

public sealed class MauiPerformanceTracker
{
    private readonly object _sync = new();
    private readonly long _startedAt = Stopwatch.GetTimestamp();
    private readonly Dictionary<string, long> _pendingRoutes = new(StringComparer.OrdinalIgnoreCase);
    private readonly Dictionary<string, List<double>> _routeSamples = new(StringComparer.OrdinalIgnoreCase);
    private readonly List<MauiStartupPerformanceSample> _startupSamples = [];

    public event Action? Changed;

    public double StartupElapsedMilliseconds => Stopwatch.GetElapsedTime(_startedAt).TotalMilliseconds;

    public IReadOnlyList<MauiStartupPerformanceSample> StartupSamples
    {
        get
        {
            lock (_sync)
                return _startupSamples.ToArray();
        }
    }

    public IReadOnlyList<MauiRoutePerformanceSample> RouteSamples
    {
        get
        {
            lock (_sync)
            {
                return _routeSamples
                    .OrderBy(item => item.Key, StringComparer.OrdinalIgnoreCase)
                    .Select(item => new MauiRoutePerformanceSample(
                        item.Key,
                        item.Value.Count,
                        item.Value[^1],
                        item.Value.Min(),
                        item.Value.Max(),
                        item.Value.Average()))
                    .ToArray();
            }
        }
    }

    public void MarkStartup(string stage)
    {
        if (string.IsNullOrWhiteSpace(stage))
            return;

        lock (_sync)
        {
            if (_startupSamples.Any(item => string.Equals(item.Stage, stage, StringComparison.Ordinal)))
                return;

            _startupSamples.Add(new MauiStartupPerformanceSample(
                stage.Trim(),
                Stopwatch.GetElapsedTime(_startedAt).TotalMilliseconds));
        }

        Changed?.Invoke();
    }

    public void BeginRoute(string route)
    {
        var key = NormalizeRoute(route);
        lock (_sync)
            _pendingRoutes[key] = Stopwatch.GetTimestamp();
    }

    public void CompleteRoute(string route)
    {
        var key = NormalizeRoute(route);
        double elapsed;
        lock (_sync)
        {
            if (!_pendingRoutes.Remove(key, out var startedAt))
                return;

            elapsed = Stopwatch.GetElapsedTime(startedAt).TotalMilliseconds;
            if (!_routeSamples.TryGetValue(key, out var samples))
            {
                samples = [];
                _routeSamples.Add(key, samples);
            }

            samples.Add(elapsed);
            if (samples.Count > 100)
                samples.RemoveAt(0);
        }

        Changed?.Invoke();
    }

    public void ClearRouteSamples()
    {
        lock (_sync)
        {
            _pendingRoutes.Clear();
            _routeSamples.Clear();
        }

        Changed?.Invoke();
    }

    private static string NormalizeRoute(string route)
    {
        if (Uri.TryCreate(route, UriKind.Absolute, out var absolute))
            return string.IsNullOrWhiteSpace(absolute.AbsolutePath) ? "/" : absolute.AbsolutePath;

        var value = route.Split('?', '#')[0].Trim();
        return string.IsNullOrWhiteSpace(value) ? "/" : "/" + value.TrimStart('/');
    }
}
