# Config

My configuration for:

-   [iTerm](https://iterm2.com)
-   [NeoVim](https://neovim.io)
-   [ZSH](https://github.com/zsh-users/zsh)
-   [Starship](https://starship.rs)

## Table Of Contents

<!--ts-->

-   [Config](#config)
    -   [Table Of Contents](#table-of-contents)
    -   [Screenshots](#screenshots)
        -   [NeoVim](#neovim)
        -   [iTerm](#iterm)
    -   [Setup](#setup)
        -   [Install](#install)
    -   [Run](#run)
        -   [Basic Install](#basic-install)
        -   [Scripts](#scripts)
            -   [aptPackages.sh](#aptpackagessh)
                -   [Platforms](#platforms)
            -   [enableTouchID.zsh](#enabletouchidzsh)
                -   [Platforms](#platforms-1)
            -   [installFonts.zsh](#installfontszsh)
                -   [Platforms](#platforms-2)
            -   [installHomebrew.zsh](#installhomebrewzsh)
                -   [Platforms](#platforms-3)
            -   [installStarship.sh](#installstarshipsh)
                -   [Platforms](#platforms-4)
            -   [npmPackages.sh](#npmpackagessh)
                -   [Platforms](#platforms-5)
            -   [osx.sh](#osxsh)
                -   [Platforms](#platforms-6)
            -   [setupiTerm.sh](#setupitermsh)
                -   [Platforms](#platforms-7)
            -   [replaceIcons.zsh, replaceIcons.swift](#replaceiconszsh-replaceiconsswift)
                -   [Platforms](#platforms-8)
            -   [setup.sh](#setupsh)
                -   [Platforms](#platforms-9)
            -   [setupCodeLLDB-Swift.sh](#setupcodelldb-swiftsh)
                -   [Platforms](#platforms-10)
            -   [setupOMZ.sh](#setupomzsh)
                -   [Platforms](#platforms-11)
            -   [setupTemp.zsh](#setuptempzsh)
                -   [Platforms](#platforms-12)

<!-- Added by: lebje, at: Mon Jul 12 12:18:59 EDT 2021 -->

<!--te-->

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

## Screenshots

### NeoVim

![NeoVim Screenshot](NeoVimScreenshot.png)

### iTerm

![iTerm Screenshot](iTermScreenshot.png)

## Setup

### Install

-   [NodeJS](https://nodejs.org/en/download/current/)
-   [Nord](https://www.nordtheme.com/ports#search)
-   [Oh-My-ZSH](https://ohmyz.sh): `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
-   [zsh-syntax-highlighing](https://github.com/zsh-users/zsh-syntax-highlighting)
-   [Nerd Font](https://www.nerdfonts.com/font-downloads)
-   [NeoVim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
-   A Terminal Emulator That Lets You Choose A Custom Font

When Installing Oh-My-ZSH, Make sure to set your default shell to ZSH.
Set your terminal emulator's font to the Nerd Font you installed; this will ensure the ZSH prompt renders correctly.

## Run

### Basic Install

```sh
$ git clone https://github.com/LebJe/config.git --recursive && \
cd config && bash setup.sh && ./install
```

### Scripts

#### `aptPackages.sh`

##### Platforms

-   Linux

Installs the folowing list of packages using `apt`:

-   zsh
-   [exa](https://the.exa.website)
-   [gh](https://cli.github.com)
-   [NeoVim](https://neovim.io)
-   Python 3
-   [Node JS](https://nodejs.org/en/)
-   [NPM](https://www.npmjs.com)
-   [bat](https://github.com/sharkdp/bat)
-   [ripgrep](https://github.com/BurntSushi/ripgrep)
-   [fd](https://github.com/sharkdp/fd)

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

Installs packages available through the [NPM](https://www.npmjs.com) package manager:

-   [`yarn`](https://yarnpkg.com)
-   [`tree-sitter`](https://github.com/tree-sitter/tree-sitter)

#### `osx.sh`

##### Platforms

-   Mac

Customizes various parts of MacOS, including:

-   Spotlight
-   Activity Monitor
-   Address Book, Dashboard, iCal TextEdit, and Disk Utility
-   Mac App Store

#### `setupiTerm.sh`

##### Platforms

-   Mac

Tells [iTerm](https://iterm2.com) that the preferences file is stored in this repository.

#### `replaceIcons.zsh, replaceIcons.swift`

##### Platforms

-   Mac

Replaces application icons with Big Sur style icons.

#### `setup.sh`

##### Platforms

-   Mac
-   Linux

Runs [setupOMZ.sh](#setupomzsh), creates `$HOME/.config/nvim/`, and runs `install`.

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

## Contributing

Before committing, please install [pre-commit](https://pre-commit.com), [swift-format](https://github.com/nicklockwood/SwiftFormat), and [Prettier](https://prettier.io) then install the pre-commit hook:

```bash
$ brew bundle # install the packages specified in Brewfile
$ pre-commit install

# Commit your changes.
```

To install pre-commit on other platforms, refer to the [documentation](https://pre-commit.com/#install).
