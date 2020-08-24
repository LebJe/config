VIMSPECTORPATH=~/.config/nvim/plugged/vimspector

# install gadgets.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then 
	mkdir -p $VIMSPECTORPATH/gadgets/linux/.gadgets.d/

	cat lldb-vscode.json > $VIMSPECTORPATH/gadgets/linux/.gadgets.d/lldb-vscode.json
elif [[ "$OSTYPE" == "darwin"* ]]; then    
	mkdir -p $VIMSPECTORPATH/gadgets/macos/.gadgets.d/

	cat lldb-vscode.json > $VIMSPECTORPATH/gadgets/macos/.gadgets.d/lldb-vscode.json
fi

python3 $VIMSPECTORPATH/install_gadget.py --enable-c --enable-python --enable-bash --force-enable-java --force-enable-rust

