# Personal self-contained tmux config

This is my personal self-contained tmux configuration.

The theme is based on powerline symbols, so you need a powerline compatible font in order to properly enjoy it.

I can recommend to take a look at [Nerd Fonts](https://www.nerdfonts.com/).
I typically use `Caskaydia Cove` which is a patched version of Microsoft's monospaced font [Cascadia Code](https://github.com/microsoft/cascadia-code).

I do not have **a** specific theme, it is more like an always changing combination of themes found over at [r/unixporn](https://www.reddit.com/r/unixporn/).

Tested with tmux version `3.2a`.
## Features

- Pane sync indicator
- Nested sessions possible ([oliverwiegers/.tmuxist](https://github.com/oliverwiegers/.tmuxist))
  - Toggle keymap betweenn local and remote
  - Indicator when remote keymap is active
- SSH aware

## Custom Keybinds

My `prefix` is `C` `Space`

- `<prefix>` `\` or `|` split vertically
- `<prefix>` `-` pr `_` split horizontally
- `<prefix>` `R` reload config
- `<prefix>` `S` sync panes
- `<prefix>` `x` kill pane
- `<prefix>` `Tab` previous window
- `F12` toggle keymap between local and remote

## If you need some resources

Github:

- [tmux/tmux/wiki](https://github.com/tmux/tmux/wiki)
- [rothgar/awesome-tmux](https://github.com/rothgar/awesome-tmux)
- [gpakosz/.tmux](https://github.com/gpakosz/.tmux)
- [oliverwiegers/.tmuxist](https://github.com/oliverwiegers/.tmuxist)

Reddit / YouTube: 

- [r/tmux](https://www.reddit.com/r/tmux)
- [r/unixporn](https://www.reddit.com/r/unixporn)
- [YouTube Video by Tech Craft: Inside my iPad Pro SSH Setup - TMUX](https://www.youtube.com/watch?v=B-1wGwvUwm8)
- [YouTube Playlist by LearnLinuxTV: Getting Started with tmux](https://www.youtube.com/playlist?list=PLT98CRl2KxKGiyV1u6wHDV8VwcQdzfuKe)
- [YouTube Video by Nick Janetakis: A Productive Linux Development Environment on Windows with WSL, Docker, tmux, VSCode and More](https://www.youtube.com/watch?v=5gu8wWX3Ob4)

Other:

- [Tmux Cheat Sheet & Quick Reference](https://tmuxcheatsheet.com/)
- [TMUX man page](https://man7.org/linux/man-pages/man1/tmux.1.html)

## Credit where credit is due

I was heavily inspired by the self-contained configs from [gpakosz/.tmux](https://github.com/gpakosz/.tmux) and [oliverwiegers/.tmuxist](https://github.com/oliverwiegers/.tmuxist).
