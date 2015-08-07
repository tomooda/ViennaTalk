field list
selectFieldNamed: aString 
	selectedField := (self fieldList includes: aString)
				ifTrue: [aString].
	self updateContents.
	self changed: #fieldSelectionIndex.
	self changed: #contents