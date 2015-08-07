field list
fieldSelectionIndex: anInteger
	self selectFieldNamed: (self fieldList at: anInteger ifAbsent: [])