updating
update: aSymbol
	aSymbol = #specification
		ifTrue: [ 
			self changed: #code.
			self changed: #moduleList.
			self changed: #fieldList ].
	aSymbol = #state
		ifTrue: [ self changed: #value ]