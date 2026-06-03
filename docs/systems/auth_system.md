# Auth System

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update if auth-system responsibilities, source-of-truth routing, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — review if auth work changes Developer Hat, QA Hat, Release Manager Hat, Git / Integration Operator Hat, or sprint workflow expectations.
> - `docs/sprints/current_sprint.md` — update when auth tasks, completed work, blockers, deferred ideas, documentation TODOs, or validation notes change.
> - `docs/release_tracker/pre_alpha_0_1.md` — update if guest login, session persistence, refresh recovery, or account readiness affects Pre-Alpha 0.1 scope.
> - `docs/game_flow/boot_flow.md` — update when startup authentication, session restore, guest login, or boot-to-menu flow changes.
> - `docs/game_flow/main_menu.md` — update when auth state affects main menu, guest account state, login prompts, or account recovery flow.
> - `docs/systems/ui_system.md` — update when auth status, login UI, error UI, account UI, or debug auth display changes.
>
> Do not update this document in isolation when auth behavior changes affect boot flow, main menu flow, UI, persistence, release scope, or sprint tasks.

---

## Purpose

The Auth System manages the player's current authentication session for the AltarSky prototype.

It currently supports:

- Guest login
- Device fingerprint authentication
- JWT storage
- Refresh token storage
- Session persistence
- JWT expiry tracking
- Server time synchronization
- Automatic token refresh
- Session recovery on startup

---

## Primary Files

```text
scripts/auth/AuthManager.gd
scripts/auth/AuthService.gd
scripts/_core/Global.gd
```

---

## API Base URL

The API base URL is stored in:

```text
scripts/_core/Global.gd
```

Current API base:

```text
https://game-server.gamerpal.com
```

`Global.gd` also attempts to load a saved auth session during startup.

---

## AuthManager

`AuthManager.gd` stores and manages auth session state.

It tracks:

- `jwt`
- `refresh_token`
- `user_id`
- `username`
- `email`
- `device_fingerprint`
- `is_guest`
- `is_logged_in`
- `jwt_exp_unix`
- `server_time_unix`
- `server_client_offset`
- `last_server_sync_unix`

The session is saved locally to:

```text
user://auth_session.json
```

---

## Session Persistence

The AuthManager can:

- Save the current session to disk.
- Load a previous session from disk.
- Clear the current session.
- Convert session data to and from Dictionary form.

This allows the game to restore a player session after restarting the app.

---

## JWT Expiry Tracking

The AuthManager decodes the JWT payload and reads the `exp` field.

This is used to determine how many seconds remain before the token expires.

If the token is missing, invalid, or expired, the system treats it as needing refresh.

---

## Server Time Sync

The backend may send `serverTime`.

When received, AuthManager calculates the offset between server time and local device time.

This helps prevent bad expiry checks caused by incorrect local device clocks.

If the device clock appears to drift too far, the stored server offset is reset.

---

## AuthService

`AuthService.gd` handles HTTP communication with the backend.

It uses:

- `AuthHTTPRequest`
- `RefreshHTTPRequest`
- `RefreshTimer`

It emits:

- `session_ready`
- `session_cleared`

---

## Guest Login Flow

If no saved session exists, the game performs a guest login.

Flow:

```text
Game starts
↓
Global.gd attempts AuthManager.load_session()
↓
No valid session found
↓
AuthService performs guest login
↓
Device fingerprint is generated from OS.get_unique_id()
↓
POST /v1/auth/guest
↓
Backend returns jwt, refreshToken, user data, and optional serverTime
↓
AuthManager stores response
↓
Session is saved to user://auth_session.json
↓
Refresh timer is scheduled
```

Guest login endpoint:

```text
POST /v1/auth/guest
```

Request body:

```json
{
  "deviceFingerprint": "device-id",
  "client": "game"
}
```

Expected success response code:

```text
201
```

---

## Token Refresh Flow

If a JWT is near expiry, AuthService refreshes it using the stored refresh token.

Refresh endpoint:

```text
POST /v1/auth/refresh
```

Request body:

```json
{
  "refreshToken": "stored-refresh-token",
  "client": "game"
}
```

Expected success response code:

```text
200
```

On success:

- New auth data is applied.
- Session is saved again.
- Refresh timer is rescheduled.
- `session_ready` is emitted.

---

## Refresh Timer Logic

The refresh timer is scheduled based on the remaining JWT lifetime.

The system avoids refreshing too early or too often.

Current safeguards include:

- `MIN_FORCE_REFRESH_THRESHOLD`
- `MIN_REFRESH_INTERVAL`
- `DESIRED_REFRESH_BUFFER`
- `refresh_in_progress`
- `last_refresh_time_unix`

This prevents duplicate refresh calls and avoids token expiry gaps.

`RefreshTimer` should remain one-shot so refresh scheduling is controlled intentionally by auth logic instead of repeatedly firing during debug or runtime.

---

## Invalid Refresh Handling

If the refresh endpoint returns:

```text
401
```

The system assumes the refresh token is invalid.

Then it:

- Clears the saved session.
- Emits `session_cleared`.
- Starts a new guest login.

---

## Current Responsibilities

The Auth System currently owns:

- Guest session creation
- Session restoration
- Session saving
- JWT expiry tracking
- Refresh token flow
- Backend auth requests
- Server time offset handling
- Auth-related debug logging

---

## Pre-Alpha 0.1 Scope

Pre-Alpha 0.1 auth goals:

- Guest account creation works.
- Device fingerprinting works.
- Refresh token architecture exists.
- Session persistence is verified.
- Guest account recovery is verified.
- Refresh recovery is verified.

See:

- `docs/release_tracker/pre_alpha_0_1.md`

---

## Future Expansion

Future auth work may include:

- Full account registration
- Email login
- Username/password login
- Account linking
- Guest-to-account conversion
- Logout UI
- Profile loading

---

# Final Rule

Auth should make early play sessions persistent and recoverable without blocking the first playable prototype.

Guest auth should stay reliable before full account systems are expanded.
