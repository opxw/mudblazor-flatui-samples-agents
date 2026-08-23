# Session authorization bootstrap

Copyright (c) 2026 opx. All rights reserved.

Read this reference when a Web or MAUI Hybrid host restores a saved session before showing protected application UI.

## Required state flow

1. Start in `Checking`. Render only full-page `FlatSessionRestore`; do not create, prerender, or briefly reveal `MainLayout` or protected route content. In MAUI use `Title="Memuat"` and keep its package-owned `.flat-system-loading-spinner` visually continuous with the preceding static `BlazorWebView` bootstrap placeholder and with `FlatReconnectModal` Reconnecting. Text-only, blank, or duplicate loading states are invalid.
2. Read the saved-session hint from the host's local-storage abstraction once interactivity is available. Treat missing data as invalid.
3. Treat every local-storage field as attacker-controlled. Never grant access from a stored Boolean, role, permission list, expiry string, or decoded token payload alone.
4. Validate the opaque session/token with the host's authentication authority or secured backend, including expiry/revocation and the permissions required for the requested route. Keep every protected API endpoint independently authorized.
5. For `Valid`, update the host `AuthenticationStateProvider`/claims state first, then render protected routes with `MainLayout`.
6. For `Invalid`, expired, missing, or validation error, clear stale saved state and render or navigate to Login without a protected-content flash. Keep failure copy generic; allow an explicit retry only when the host can distinguish a transient validation failure safely.

Keep initialization single-flight and cancellation/disposal aware. Prevent redirect loops, validate any return URL as local/allowed, and do not log stored session material, credentials, tokens, roles, or personal data. Logout clears the host session and saved hint before returning to Login.

## Ownership boundary

`FlatSessionRestore` owns only the OPX full-page loading presentation. The MAUI host owns the pre-interactive static placeholder, but it must reuse the package `.flat-system-loading-spinner` visual and hand off without a blank or duplicate frame. The host also owns local-storage access, token/session format, validation endpoint, authentication-state updates, route policies, authorization, timeout, refresh, logout, Login behavior, error handling, and navigation. Local storage improves session restoration UX; it is never the security boundary.

## Verification

Verify at least missing, valid, expired, revoked, tampered, network/error, and logout states. Assert that protected DOM/layout is absent while checking and for every invalid result; valid state must update identity before `MainLayout` appears. Browser tests prove Web behavior only; MAUI local-storage lifecycle, resume, offline, and secure-token handling require emulator/device evidence.

Authoritative references:

- [ASP.NET Core Blazor authentication and authorization](https://learn.microsoft.com/aspnet/core/blazor/security/?view=aspnetcore-10.0)
- [ASP.NET Core Blazor authentication state](https://learn.microsoft.com/aspnet/core/blazor/security/authentication-state?view=aspnetcore-10.0)
