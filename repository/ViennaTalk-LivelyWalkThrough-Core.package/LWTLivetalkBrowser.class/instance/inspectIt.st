action list menu
inspectIt
	self selectedAction
		ifNotNilDo: [:action | action value inspect]