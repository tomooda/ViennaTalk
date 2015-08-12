action list
selectedAction
	^ self director
		actionAt: self selectedActionSelector
		ifAbsent: []