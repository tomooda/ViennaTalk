user interface
buildScriptList
	^ PluggableListMorph
		on: self
		list: #scriptList
		selected: #scriptListIndex
		changeSelected: #scriptListIndex:
		menu: #scriptListMenu:shifted: