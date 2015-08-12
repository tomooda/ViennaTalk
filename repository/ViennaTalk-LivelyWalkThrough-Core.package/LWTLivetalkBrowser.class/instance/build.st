user interface
build
	| actionList browserPane |
	actionList := self buildActionList.
	codePane := self buildCodePane.
	browserPane := BorderedMorph new
		color: Color transparent;
		changeProportionalLayout;
		yourself.
	browserPane addMorph: actionList fullFrame: ((0 @ 0 corner: 1 @ 0.4) asLayoutFrame bottomRightOffset: 0 @ -2).
	browserPane addMorph: codePane fullFrame: ((0 @ 0.4 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	browserPane addPaneSplitters.
	^ browserPane