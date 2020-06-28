# Clone Vimspector
http --ignore-stdin -d https://github.com/puremourning/vimspector/releases/download/1565/macos-d1f2df36cc8e124e35b83c2ecb5fbf463fa3ceb0.tar.gz

# Untar it.
tar -C $HOME/.local/share/nvim/site/pack/ -zxf macos-d1f2df36cc8e124e35b83c2ecb5fbf463fa3ceb0.tar.gz

rm -rf macos-d1f2df36cc8e124e35b83c2ecb5fbf463fa3ceb0.tar.gz

# install gadgets.

if [[ "$OSTYPE" == "linux-gnu"* ]]; then    
	mkdir -p ~/.config/nvim/pack/vimspector/opt/vimspector/gadgets/linux/.gadgets.d/

	cat lldb-vscode.json > ~/.config/nvim/pack/vimspector/opt/vimspector/gadgets/linux/.gadgets.d/lldb-vscode.json
elif [[ "$OSTYPE" == "darwin"* ]]; then    
	mkdir -p ~/.config/nvim/pack/vimspector/opt/vimspector/gadgets/macos/.gadgets.d/

	cat lldb-vscode.json > ~/.config/nvim/pack/vimspector/opt/vimspector/gadgets/macos/.gadgets.d/lldb-vscode.json
fi

cd ~/.config/nvim/pack/vimspector/opt/vimspector/

python3 install_gadget.py

cd
cd config

