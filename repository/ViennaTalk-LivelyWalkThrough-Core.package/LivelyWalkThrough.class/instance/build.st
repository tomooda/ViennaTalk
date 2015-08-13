user interface
build
	| pane utilsPane |
	pane := BorderedMorph new
		extent: 800 @ 400;
		color: Color transparent;
		changeProportionalLayout;
		yourself.
	utilsPane := LazyTabGroupMorph new.
	utilsPane
		addLazyPage: self buildVDMBrowserPane label: 'VDM';
		addLazyPage: self buildLivetalkBrowserPane label: 'Livetalk'.
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