script list
scriptListIndex: anInteger 
	self
		selectScriptNamed: (self scriptList
				at: anInteger
				ifAbsent: [])