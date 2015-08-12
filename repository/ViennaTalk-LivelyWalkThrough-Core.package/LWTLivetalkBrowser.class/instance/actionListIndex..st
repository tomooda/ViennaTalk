action list
actionListIndex: anInteger 
	self
		selectActionNamed: (self actionList
				at: anInteger
				ifAbsent: [])