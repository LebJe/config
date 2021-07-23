#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	cp CodeLLDB-Swift.json ~/.local/share/nvim/site/pack/packer/start/vimspector/gadgets/linux/.gadgets.d 
elif [[ "$OSTYPE" == "darwin"* ]]; then
	cp CodeLLDB-Swift.json ~/.local/share/nvim/site/pack/packer/start/vimspector/gadgets/macos/.gadgets.d 
fi
