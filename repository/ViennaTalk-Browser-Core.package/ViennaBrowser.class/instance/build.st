user interface
build
	| pane upper |
	moduleListPane := self buildModuleList.
	fieldListPane := self buildFieldList.
	valuePane := self buildValuePane.
	codePane := self buildCodePane.
	workspacePane := self buildWorkspacePane.
	testPane := self buildTestPane.
	pane := BorderedMorph new.
	pane extent: 600 @ 400.
	pane color: Color transparent.
	pane changeProportionalLayout.
	upper := BorderedMorph new.
	upper changeProportionalLayout.
	upper addMorph: moduleListPane fullFrame: (0 @ 0 corner: 0.3 @ 1) asLayoutFrame.
	upper addMorph: fieldListPane fullFrame: (0.3 @ 0 corner: 0.6 @ 1) asLayoutFrame.
	upper addMorph: valuePane fullFrame: (0.6 @ 0 corner: 1 @ 1) asLayoutFrame.
	upper addPaneSplitters.
	lowerTabPane := LazyTabGroupMorph new.
	lowerTabPane addLazyPage: codePane label: 'Specification'.
	lowerTabPane addLazyPage: workspacePane label: 'Workspace'.
	lowerTabPane addLazyPage: testPane label: 'UnitTests'.
	lowerTabPane selectedPageIndex: 1.
	pane addMorph: upper fullFrame: ((0 @ 0 corner: 1 @ 0.4) asLayoutFrame bottomRightOffset: 0 @ -2).
	pane addMorph: lowerTabPane fullFrame: ((0 @ 0.4 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	pane addPaneSplitters.
	^ pane