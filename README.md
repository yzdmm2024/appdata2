# AppData2

Fork of [FouadRaheb/AppData](https://github.com/FouadRaheb/AppData) for **rootless** jailbreaks
(iOS 14+, tested on iPhone 12 Pro / iOS 16.6 / Relaxin+RootHide).

The upstream tweak can view and manage an app's data from the Home Screen. This fork adds one
thing: a **Safe Clean** action that frees storage **without logging you out**.

## Safe Clean

Added as the 6th button in the Manage action bar (shield icon).

**Deleted**

- `Library/Caches`
- `tmp`
- `Library/Logs`
- every other disposable file in the data container (crash reports, splash board, `SystemData`, …)

**Kept (login / session state)**

| Path | Holds |
| --- | --- |
| `Library/Preferences` | NSUserDefaults — tokens, account ids |
| `Library/Cookies` | web sessions |
| `Library/HTTPStorages` | cookies + URL session storage |
| `Library/Application Support` | app databases (Realm / CoreData / Firebase) |
| `Library/WebKit` | localStorage / IndexedDB of web views |
| `Library/Accounts` | account credentials |
| `Library/Saved Application State` | restore state |
| `Library/Keychain` | legacy in-container keychain |

`Documents` (user files / game saves) is kept by default. Turn off
**Settings → AppData2 → Safe Clean → "Safe Clean keeps Documents"** to clear it too — the login
state is still preserved either way.

Permissions are **not** reset, so you won't get re-prompted for Contacts / Photos / etc.

## Build

Built in CI (macOS + theos + ld64). Push to `main` or run the `Build AppData2 (deb)` workflow
manually; the deb lands in the `appdata2` artifact.

## Layout

- `AppData2` — SpringBoard tweak (upstream code + Safe Clean).
- `AppDataPrefs` — Settings bundle (`Settings → AppData2`).
- `layout/Library/Application Support/AppData2/Resources.bundle` — action bar icons.

## Credits

Original AppData by Fouad Raheb. Safe Clean fork by yzdmm2024.