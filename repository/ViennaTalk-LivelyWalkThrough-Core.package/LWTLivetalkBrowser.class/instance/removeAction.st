action list menu
removeAction
	self director
		removeActionAt: self selectedActionSelector
		ifAbsent: [].
	self changed: #actionList.
	self actionListIndex < 1
		ifTrue: [self changed: #contents]