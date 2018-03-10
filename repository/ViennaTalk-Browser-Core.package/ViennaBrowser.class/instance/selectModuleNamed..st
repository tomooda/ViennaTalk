module list
selectModuleNamed: aString
	| oldSelection |
	oldSelection := selectedModule.
	selectedModule := (self moduleList includes: aString)
		ifTrue: [ aString ].
	selectedModule ~= oldSelection
		ifTrue: [ 
			self changed: #moduleSelectionIndex.
			self changed: #fieldList.
			self selectFieldNamed: nil.
			self changed: #code.
			self changed: #value ]