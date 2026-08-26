// Copyright (c) 2026 opx. All rights reserved.

using Microsoft.Extensions.DependencyInjection;
using Opx.MudBlazor.FlatUi.Sample.Services;
using Opx.MudBlazor.FlatUi.Services;

namespace Opx.MudBlazor.FlatUi.Showcase;

public static class ShowcaseServiceCollectionExtensions
{
    public static IServiceCollection AddOpxFlatUiShowcase(this IServiceCollection services)
    {
        services.AddSingleton<SampleCatalog>();
        services.AddSingleton<ErpSampleCatalog>();
        services.AddScoped<SampleStartupGateService>();
        services.AddScoped(typeof(FlatSessionCartService<>));
        services.AddScoped<FlatChatWebSocketClient>();
        return services;
    }
}
