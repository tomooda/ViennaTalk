user interface
buildTestPane
	^ (PluggableListMorph
		on: self
		list: #testList
		selected: #testSelectionIndex
		changeSelected: #testSelectionIndex:
		menu: nil)
		font: ViennaLauncher font;
		yourself