# Config
My personal configuration (zshrc, vimrc, etc)

## Setup

### Install
  1. <details>
	  <summary>[NodeJS](https://nodejs.org/en/download/current/)</summary>
    #### [Homebrew](https://brew.sh)
     `brew install node`
     
    #### APT
    
     ```sh
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt install -y nodejs

     ```	 
      
    </details>
  2. [Nord](https://www.nordtheme.com/ports#search)
  3. [Oh-My-ZSH](https://ohmyz.sh): `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
  4. <details>
	  <summary>[Powerlevel10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh)</summary>
	  
	  ```bash
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	  ```
     </details>
 
  5. <details>
	  <summary>[zsh-syntax-highlighing](https://github.com/zsh-users/zsh-syntax-highlighting)</summary>
	  
	  ```bash
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	  ```
     </details>
  6. [Nerd Font](https://www.nerdfonts.com/font-downloads)
  7. <details>
	  <summary>[NeoVim](https://github.com/neovim/neovim/wiki/Installing-Neovim)</summary>
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
```sh
$ git clone https://github.com/LebJe/config.git && cd config && bash setup.sh
```
