user interface
buildTestPane
	^ (PluggableIconListMorph
		on: self
		list: #testList
		selected: #testSelectionIndex
		changeSelected: #testSelectionIndex:
		menu: #testPaneMenu:)
		getIconSelector: #testResultIconFor:;
		font: ViennaLauncher font;
		yourself