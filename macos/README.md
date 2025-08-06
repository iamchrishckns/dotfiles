# MacOS

## Scripts

### configure.sh

This script configures MacOS. It sets my preffered defaults and installs neccessary applications and configures them.

Running it: `./scripts/configure.sh`

This script will do the following:
- Set my default preferences
- Install Homebrew & important [applications](#homebrew-applications) (TODO)

The script is inspired by the following projects:
- [.macos](https://github.com/mathiasbynens/dotfiles/blob/master/.macos) from [mathiasbynens](https://github.com/mathiasbynens)

## Homebrew Applications

```bash
brew install font-monaspace-nerd-font

brew install jandedobbeleer/oh-my-posh/oh-my-posh
brew install tmux
brew install fzf
brew install neovim

brew install iina
brew install mpv
brew install orbstack
brew install displayplacer

brew install --cask librewolf
brew install --cask ungoogled-chromium

brew install --cask github-copilot-for-xcode
brew install --cask betterdisplay
```
