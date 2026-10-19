# maxawad/homebrew-tap

Homebrew tap for Max Awad's software.

## iMake for macOS

```bash
brew install maxawad/tap/imake
```

Apple Silicon, macOS 14 or newer. The cask installs the signed and notarized
`iMake.app` published to `https://downloads.imake.lol`.

`brew uninstall --cask imake` removes the app and unloads the background
`com.devcluster.*` agents. Add `--zap` to also delete `~/.devcluster` and the
app's caches, logs, and preferences.

The app updates itself, so Homebrew will not fight it: the cask is marked
`auto_updates true` and `brew upgrade` only replaces the bundle when the
published release is newer than the installed one.

### How the cask stays current

`.github/workflows/update-cask.yml` polls
`https://downloads.imake.lol/releases/latest/macos.json` hourly and commits a
new version and `sha256` when a release ships. Run it by hand with
`gh workflow run update-cask.yml -R maxawad/homebrew-tap`.

## iMessages AI

```bash
brew install maxawad/tap/imessages-ai
```
