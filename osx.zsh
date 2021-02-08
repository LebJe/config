if [ "$(uname 2> /dev/null)" != "Linux" ]; then
	
	# From https://github.com/donnemartin/dev-setup/blob/master/osx.sh

	# Expand save panel by default
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
	defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

	# Expand print panel by default
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
	defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

	# Increase sound quality for Bluetooth headphones/headsets
	defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

	# Enable full keyboard access for all controls
	# (e.g. enable Tab in modal dialogs)
	defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

	# Require password immediately after sleep or screen saver begins
	defaults write com.apple.screensaver askForPassword -int 1
	defaults write com.apple.screensaver askForPasswordDelay -int 0

	# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
	defaults write com.apple.screencapture type -string "png"

	# Set ${HOME} as the default location for new Finder windows
	# For other paths, use `PfLo` and `file:///full/path/here/`
	defaults write com.apple.finder NewWindowTarget -string "PfLo"
	defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

	# Show icons for hard drives, servers, and removable media on the desktop
	defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
	defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
	defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

	# Finder: show hidden files by default
	defaults write com.apple.finder AppleShowAllFiles -bool true

	# Finder: show all filename extensions
	defaults write NSGlobalDomain AppleShowAllExtensions -bool true

	# Finder: show status bar
	#defaults write com.apple.finder ShowStatusBar -bool true

	# Finder: show path bar
	defaults write com.apple.finder ShowPathbar -bool true

	# Finder: allow text selection in Quick Look
	defaults write com.apple.finder QLEnableTextSelection -bool true

	# Disable the warning when changing a file extension
	defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

	# Use column view in all Finder windows by default
	# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
	defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

	# Empty Trash securely by default
	defaults write com.apple.finder EmptyTrashSecurely -bool true

	# Enable AirDrop over Ethernet and on unsupported Macs running Lion
	defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

	# Show the ~/Library folder
	chflags nohidden ~/Library

	# Automatically hide and show the Dock
	defaults write com.apple.dock autohide -bool true

	# Press Tab to highlight each item on a web page
	defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

	# Prevent Safari from opening ‘safe’ files automatically after downloading
	defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

	# Enable Safari’s debug menu
	defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

	# Enable the Develop menu and the Web Inspector in Safari
	defaults write com.apple.Safari IncludeDevelopMenu -bool true
	defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
	defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

	# Add a context menu item for showing the Web Inspector in web views
	defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

	###############################################################################
	# Spotlight                                                                   #
	###############################################################################

	defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 0;"name" = "DIRECTORIES";}' \
	'{"enabled" = 0;"name" = "PDF";}' \
	'{"enabled" = 0;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
	# Load new settings before rebuilding the index
	killall mds > /dev/null 2>&1
	# Make sure indexing is enabled for the main volume
	sudo mdutil -i on / > /dev/null
	# Rebuild the index from scratch
	sudo mdutil -E / > /dev/null

	###############################################################################
	# Activity Monitor                                                            #
	###############################################################################

	# Sort Activity Monitor results by CPU usage
	defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
	defaults write com.apple.ActivityMonitor SortDirection -int 0

# Show the main window when launching Activity Monitor
	defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

	# Visualize CPU usage in the Activity Monitor Dock icon
	defaults write com.apple.ActivityMonitor IconType -int 5

	# Show all processes in Activity Monitor
	defaults write com.apple.ActivityMonitor ShowCategory -int 0

	###############################################################################
	# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
	###############################################################################

	# Enable the debug menu in Address Book
	defaults write com.apple.addressbook ABShowDebugMenu -bool true

	# Enable the debug menu in iCal (pre-10.8)
	defaults write com.apple.iCal IncludeDebugMenu -bool true

	# Use plain text mode for new TextEdit documents
	defaults write com.apple.TextEdit RichText -int 0
	# Open and save files as UTF-8 in TextEdit
	defaults write com.apple.TextEdit PlainTextEncoding -int 4
	defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

	# Set tab width to 4 instead of the default 8
	defaults write com.apple.TextEdit "TabWidth" '4'

	# Enable the debug menu in Disk Utility
	defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
	defaults write com.apple.DiskUtility advanced-image-options -bool true

	###############################################################################
	# Mac App Store                                                               #
	###############################################################################

	# Enable the WebKit Developer Tools in the Mac App Store
	defaults write com.apple.appstore WebKitDeveloperExtras -bool true

	# Enable Debug Menu in the Mac App Store
	defaults write com.apple.appstore ShowDebugMenu -bool true


fi

