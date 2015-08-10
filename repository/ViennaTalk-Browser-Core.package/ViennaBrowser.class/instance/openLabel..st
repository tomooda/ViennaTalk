user interface
openLabel: aString
	| pane upper |
	moduleListPane := self buildModuleList.
	fieldListPane := self buildFieldList.
	valuePane := self buildValuePane.
	codePane := self buildCodePane.
	pane := BorderedMorph new.
	pane color: Color transparent.
	pane changeProportionalLayout.
	upper := BorderedMorph new.
	upper changeProportionalLayout.
	upper addMorph: moduleListPane fullFrame: (0 @ 0 corner: 0.3 @ 1) asLayoutFrame.
	upper addMorph: fieldListPane fullFrame: (0.3 @ 0 corner: 0.6 @ 1) asLayoutFrame.
	upper addMorph: valuePane fullFrame: (0.6 @ 0 corner: 1 @ 1) asLayoutFrame.
	pane addMorph: upper fullFrame: ((0 @ 0 corner: 1 @ 0.5) asLayoutFrame bottomRightOffset: 0 @ -2).
	pane addMorph: codePane fullFrame: ((0 @ 0.5 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	pane addPaneSplitters.
	pane openInWindowLabeled: aString