module list
selectModuleNamed: aString 
	selectedModule := (self moduleList includes: aString)
				ifTrue: [aString].
	self updateState.
	selectedField := nil.
	self changed: #moduleSelectionIndex.
	self changed: #fieldList.
	self changed: #fieldSelectionIndex.
	self changed: #code.
	self changed: #value