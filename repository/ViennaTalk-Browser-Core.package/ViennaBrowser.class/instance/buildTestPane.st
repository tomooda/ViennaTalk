user interface
buildTestPane
	^ (PluggableIconListMorph
		on: self
		list: #testList
		selected: #testSelectionIndex
		changeSelected: #testSelectionIndex:
		menu: nil)
		getIconSelector: #testResultIconFor:;
		font: ViennaLauncher font;
		yourself