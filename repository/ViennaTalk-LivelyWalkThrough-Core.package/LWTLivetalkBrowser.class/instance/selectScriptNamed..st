script list
selectScriptNamed: aSymbol 
	selectedScriptSelector := aSymbol
				ifNotNil: [:selector | selector asSymbol].
	self changed: #scriptListIndex.
	self changed: #code