user interface
build
	| scriptList browserPane |
	scriptList := self buildScriptList.
	codePane := self buildCodePane.
	browserPane := BorderedMorph new
		color: Color transparent;
		changeProportionalLayout;
		yourself.
	browserPane addMorph: scriptList fullFrame: ((0 @ 0 corner: 1 @ 0.4) asLayoutFrame bottomRightOffset: 0 @ -2).
	browserPane addMorph: codePane fullFrame: ((0 @ 0.4 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	browserPane addPaneSplitters.
	^ browserPane