field list
selectFieldNamed: aString
	| oldSelection |
	oldSelection := selectedField.
	selectedField := (self fieldList includes: aString)
		ifTrue: [ aString ].
	selectedField ~= oldSelection
		ifTrue: [ 
			self changed: #fieldSelectionIndex.
			self changed: #value ]