namespace Opx.MudBlazor.FlatUi.Maui.Template.Services;

public interface IRootStartupGateValidator
{
    ValueTask<RootStartupGateResult> ValidateAsync(CancellationToken cancellationToken);
}

public enum RootStartupGateResult
{
    Ready,
    Login
}

internal sealed class SampleRootStartupGateValidator : IRootStartupGateValidator
{
    public ValueTask<RootStartupGateResult> ValidateAsync(CancellationToken cancellationToken)
    {
        cancellationToken.ThrowIfCancellationRequested();
        // Replace with host-owned secure session/authorization validation.
        return ValueTask.FromResult(RootStartupGateResult.Ready);
    }
}
