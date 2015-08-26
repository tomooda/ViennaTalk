updating
update: aSymbol
	aSymbol = #specification
		ifTrue: [ 
			self changed: #code.
			self changed: #moduleList.
			self changed: #fieldList.
			self changed: #value ].
	aSymbol = #state
		ifTrue: [ self changed: #value ]