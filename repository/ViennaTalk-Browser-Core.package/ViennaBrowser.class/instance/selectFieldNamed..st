field list
selectFieldNamed: aString 
	selectedField := (self fieldList includes: aString)
				ifTrue: [aString].
	self changed: #fieldSelectionIndex.
	self changed: #value