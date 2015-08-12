user interface
build
	| pane upper lower |
	moduleListPane := self buildModuleList.
	fieldListPane := self buildFieldList.
	valuePane := self buildValuePane.
	codePane := self buildCodePane.
	workspacePane := self buildWorkspacePane.
	pane := BorderedMorph new.
	pane extent: 400 @ 300.
	pane color: Color transparent.
	pane changeProportionalLayout.
	upper := BorderedMorph new.
	upper changeProportionalLayout.
	upper addMorph: moduleListPane fullFrame: (0 @ 0 corner: 0.3 @ 1) asLayoutFrame.
	upper addMorph: fieldListPane fullFrame: (0.3 @ 0 corner: 0.6 @ 1) asLayoutFrame.
	upper addMorph: valuePane fullFrame: (0.6 @ 0 corner: 1 @ 1) asLayoutFrame.
	upper addPaneSplitters.
	lower := LazyTabGroupMorph new.
	lower addLazyPage: codePane label: 'Specification'.
	lower addLazyPage: workspacePane label: 'Workspace'.
	lower selectedPageIndex: 1.
	pane addMorph: upper fullFrame: ((0 @ 0 corner: 1 @ 0.4) asLayoutFrame bottomRightOffset: 0 @ -2).
	pane addMorph: lower fullFrame: ((0 @ 0.4 corner: 1 @ 1) asLayoutFrame topLeftOffset: 0 @ 2).
	pane addPaneSplitters.
	^ pane