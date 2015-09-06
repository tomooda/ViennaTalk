user interface
build
	| pane utilsPane |
	pane := BorderedMorph new
		extent: 900 @ 600;
		color: Color transparent;
		changeProportionalLayout;
		yourself.
	utilsPane := LazyTabGroupMorph new.
	utilsPane
		addLazyPage: self buildWidgetDispenserPane label: 'Widgets';
		addLazyPage: self buildVDMBrowserPane label: 'VDM';
		addLazyPage: self buildLivetalkBrowserPane label: 'Livetalk';
		addLazyPage: self buildSettingsPane label: 'Settings';
		addLazyPage: self buildFilePane label: 'File'.
	utilsPane selectedPageIndex: 1.
	pane
		addMorph: self director
		fullFrame:
			((0 @ 0 corner: 0.6 @ 1) asLayoutFrame
				bottomRightOffset: -3 @ 0;
				yourself).
	pane
		addMorph: utilsPane
		fullFrame:
			((0.6 @ 0 corner: 1 @ 1) asLayoutFrame
				topLeftOffset: 3 @ 0;
				yourself).
	pane addPaneSplitters.
	^ pane