action list
selectActionNamed: aSymbol 
	selectedActionSelector := aSymbol
				ifNotNilDo: [:selector | selector asSymbol].
	self changed: #actionListIndex.
	self changed: #code