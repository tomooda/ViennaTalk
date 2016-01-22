menu operations
showSettingBrowser
	SettingBrowser new
		changePackageSet:
				{(RPackageOrganizer default packageNamed: #'ViennaTalk-Launcher-Core').
					(RPackageOrganizer default packageNamed: #'ViennaTalk-Browser-Core').
					(RPackageOrganizer default packageNamed: #'ViennaTalk-Engine-Core').
					(RPackageOrganizer default packageNamed: #'ViennaTalk-Parser-Core').
					(RPackageOrganizer default packageNamed: #'ViennaTalk-VDMPad-Core').
					(RPackageOrganizer default packageNamed: #'Network-Kernel')};
		open