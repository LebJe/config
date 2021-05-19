# Config

My personal configuration (zshrc, vimrc, etc)

## Table Of Contents

<!--ts-->

-   [Config](#config)
    -   [Table Of Contents](#table-of-contents)
    -   [Setup](#setup)
        -   [Install](#install)
            -   [<a href="https://brew.sh" rel="nofollow">Homebrew</a>](#homebrew)
            -   [APT](#apt)
            -   [<a href="https://brew.sh" rel="nofollow">Homebrew</a>](#homebrew-1)
            -   [APT](#apt-1)
    -   [Run](#run)
        -   [Basic Install](#basic-install)
        -   [Scripts](#scripts)

<!-- Added by: lebje, at: Wed May 19 12:06:42 EDT 2021 -->

<!--te-->

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

## Setup

### Install

1. [NodeJS](https://nodejs.org/en/download/current/)
 <details>

#### [Homebrew](https://brew.sh)

`brew install node`

#### APT

`sudo apt install -y nodejs`

</details>

2. [Nord](https://www.nordtheme.com/ports#search)
3. [Oh-My-ZSH](https://ohmyz.sh): `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

4. [zsh-syntax-highlighing](https://github.com/zsh-users/zsh-syntax-highlighting)
 <details>

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

</details>

6. [Nerd Font](https://www.nerdfonts.com/font-downloads)

7. [NeoVim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
 <details>

#### [Homebrew](https://brew.sh)

`brew install neovim`

#### APT

```sh
sudo apt install -y neovim

# Python Support
sudo apt install -y python-neovim
sudo apt install -y python3-neovim
```

  </details>

8. A Terminal Emulator That Lets You Choose A Custom Font

When Installing Oh-My-ZSH, Make sure to set your default shell to ZSH.
Set your terminal emulator's font to the Nerd Font you installed; this will ensure the ZSH prompt renders correctly.

## Run

### Basic Install

```sh
$ git clone https://github.com/LebJe/config.git && cd config && bash setup.sh
```

### Scripts

#### `aptPackages.sh`

##### Platforms

-   Linux

Installs packages using `apt`.

#### `enableTouchID.zsh`

##### Platforms

-   Mac

Enables Touch ID authentication for `sudo`.

#### `installFonts.zsh`

##### Platforms

-   Mac

Installs custom fonts to `~/Library/Fonts`.

#### `installHomebrew.zsh`

##### Platforms

-   Mac

Installs [Homebrew](https://brew.sh).

#### `installStarship.sh`

##### Platforms

-   Mac
-   Linux

Installs [Starship](https://starship.rs).

#### `npmPackages.sh`

##### Platforms

-   Mac
-   Linux

Installs [NPM](https://www.npmjs.com) packages like [`yarn`](https://yarnpkg.com).

#### `osx.sh`

##### Platforms

-   Mac

Customizes various parts of MacOS, namely:

-   Spotlight
-   Activity Monitor
-   Address Book, Dashboard, iCal TextEdit, and Disk Utility
-   Mac App Store

#### `replaceIcons.zsh, replaceIcons.swift`

##### Platforms

-   Mac

Replaces application icons with Big Sur style icons.

#### `setup.sh`

##### Platforms

-   Mac
-   Linux

#### `setupCodeLLDB-Swift.sh`

##### Platforms

-   Mac
-   Linux

#### `setupOMZ.sh`

##### Platforms

-   Mac
-   Linux

Sets up [Oh My ZSH](https://ohmyz.sh) and [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).

#### `setupTemp.zsh`

##### Platforms

-   Mac
-   Linux

Compiles the temp executable and moves it to `~/config`.
