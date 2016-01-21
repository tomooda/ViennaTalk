menu operations
showSettingBrowser
	SettingBrowser new
		changePackageSet:
				{(RPackageOrganizer default packageNamed: #'ViennaTalk-Launcher-Core').
					(RPackageOrganizer default packageNamed: #'Network-Kernel')};
		open