# install gadgets.

if [[ "$OSTYPE" == "linux-gnu"* ]]; then 
	# Clone Vimspector
	wget https://github.com/puremourning/vimspector/releases/download/1605/linux-df8389380a56ca6bc60d3bbadf266ab8009b825e.tar.gz

	# Untar it.
	tar -C $HOME/.local/share/nvim/site/pack/ -zxf linux-df8389380a56ca6bc60d3bbadf266ab8009b825e.tar.gz

	rm -rf linux-df8389380a56ca6bc60d3bbadf266ab8009b825e.tar.gz
	

	mkdir -p ~/.config/nvim/pack/vimspector/opt/vimspector/gadgets/linux/.gadgets.d/

	cat lldb-vscode.json > ~/.config/nvim/pack/vimspector/opt/vimspector/gadgets/linux/.gadgets.d/lldb-vscode.json
elif [[ "$OSTYPE" == "darwin"* ]]; then    
	# Clone Vimspector
	wget https://github.com/puremourning/vimspector/releases/download/1605/macos-df8389380a56ca6bc60d3bbadf266ab8009b825e.tar.gz

	# Untar it.
	tar -C $HOME/.local/share/nvim/site/pack/ -zxf macos-df8389380a56ca6bc60d3bbadf266ab8009b825e.tar.gz

	rm -rf macos-df8389380a56ca6bc60d3bbadf266ab8009b825e.tar.gz

	mkdir -p ~/.config/nvim/pack/vimspector/opt/vimspector/gadgets/macos/.gadgets.d/

	cat lldb-vscode.json > ~/.config/nvim/pack/vimspector/opt/vimspector/gadgets/macos/.gadgets.d/lldb-vscode.json
fi

cd ~/.config/nvim/pack/vimspector/opt/vimspector/

python3 install_gadget.py

cd
cd config

