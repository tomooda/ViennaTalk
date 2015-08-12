action list menu
doIt
	self selectedAction
		ifNotNilDo: [:action | action value]