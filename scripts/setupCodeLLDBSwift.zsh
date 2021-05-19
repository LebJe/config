#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	cp ../CodeLLDB-Swift.json ~/.config/nvim/plugged/vimspector/gadgets/linux/.gadgets.d/
elif [[ "$OSTYPE" == "darwin"* ]]; then
	cp ../CodeLLDB-Swift.json ~/.config/nvim/plugged/vimspector/gadgets/macos/.gadgets.d/
fi
