user interface
buildActionList
	^ PluggableListMorph
		on: self
		list: #actionList
		selected: #actionListIndex
		changeSelected: #actionListIndex:
		menu: #actionListMenu:shifted: