namespace Opx.MudBlazor.FlatUi.Sample.Services;

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
        return ValueTask.FromResult(RootStartupGateResult.Ready);
    }
}
