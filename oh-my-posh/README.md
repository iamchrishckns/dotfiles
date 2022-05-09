<p>
  <h1 align="center"><b>Oh My Posh</h1>
</p>

I created my own theme which is a mix of [multiple themes from the offical docs](https://ohmyposh.dev/docs/themes).

You can find it [here](themes/iamchrishckns.omp.json).

## Installation

### Linux

The offical installation docs for linux are [here](https://ohmyposh.dev/docs/installation/linux).

With homebrew (already includes the default themes):

```bash
brew install jandedobbeleer/oh-my-posh/oh-my-posh
```

Manually (requires to clone the default themes separately)

```bash
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
```

```bash
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip
```

### macOS

The offical installation docs for macOS are [here](https://ohmyposh.dev/docs/installation/macos).

With homebrew (already includes the default themes):

```bash
brew install jandedobbeleer/oh-my-posh/oh-my-posh
```


---

It is recommended to have a [Nerd Font](https://www.nerdfonts.com/) installed, otherwise the prompt will not look good 😟.

My favorite [Nerd Font](https://www.nerdfonts.com/) which I use almost everywhere is "Caskaydia Cove Nerd Font" which is based on the open source monospaced font "[Cascadia Code](https://github.com/microsoft/cascadia-code)" from Microsoft.
