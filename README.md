# maxawad/homebrew-tap

A Homebrew tap, which is a small package repository that lets Mac users install Max Awad's software with one `brew` command instead of downloading and installing by hand.

## What it does

The tap publishes two packages:

| Package | Type | What it is |
| --- | --- | --- |
| `imake` | Cask (macOS app) | iMake, an agent that turns prompts into apps, sites, and workflows on your own machines. Homepage: https://imake.lol/ |
| `imessages-ai` | Formula (command line tool) | A ChatGPT-powered auto-responder for iMessage. Source: https://github.com/maxawad/imessages-ai |

## Tech stack

- Homebrew cask and formula definitions (Ruby)
- GitHub Actions workflow with a small inline Python script that keeps the iMake cask current

## Install

You need [Homebrew](https://brew.sh/) on a Mac.

```bash
brew tap maxawad/tap
```

### iMake

```bash
brew install maxawad/tap/imake
```

Apple Silicon, macOS 14 or newer. The cask installs the signed and notarized `iMake.app` published to `https://downloads.imake.lol`.

`brew uninstall --cask imake` removes the app and unloads the background `com.devcluster.*` agents. Add `--zap` to also delete `~/.devcluster` and the app's caches, logs, and preferences.

The app updates itself, so Homebrew will not fight it. The cask is marked `auto_updates true`, and `brew upgrade` only replaces the bundle when the published release is newer than the installed one.

### iMessages AI

```bash
brew install maxawad/tap/imessages-ai
imessages-ai setup
imessages-ai start
```

It needs macOS, Python 3, and an OpenAI API key that you supply during `imessages-ai setup`. Your terminal also needs Full Disk Access (System Settings, Privacy & Security) so it can read Messages. Configuration lives in `~/.config/imessages-ai/config` and logs in `~/Library/Logs/imessages-ai/`.

## How the iMake cask stays current

`.github/workflows/update-cask.yml` polls `https://downloads.imake.lol/releases/latest/macos.json` hourly. When a new release ships, it checks that the published DMG matches the manifest checksum, then commits the new version and `sha256` to `Casks/imake.rb`. Run it by hand with:

```bash
gh workflow run update-cask.yml -R maxawad/homebrew-tap
```

## Repository layout

- `Casks/imake.rb`: the iMake cask
- `Formula/imessages-ai.rb`: the iMessages AI formula
- `.github/workflows/update-cask.yml`: the hourly release bump

## Status

Working and maintained. The iMake cask is updated automatically on each release. This repository is macOS only, so there is nothing to build or run on other systems.

## Credits

Written by Max Awad. The packages install software published by Max Awad.
