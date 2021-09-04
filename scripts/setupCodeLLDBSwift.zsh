#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	cp CodeLLDB-Swift.json ~/.local/share/nvim/site/pack/packer/opt/vimspector/gadgets/linux/.gadgets.d 
elif [[ "$OSTYPE" == "darwin"* ]]; then
	cp CodeLLDB-Swift.json ~/.local/share/nvim/site/pack/packer/opt/vimspector/gadgets/macos/.gadgets.d 
fi
