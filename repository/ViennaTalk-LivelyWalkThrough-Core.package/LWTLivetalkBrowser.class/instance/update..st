updating
update: aSymbol
	aSymbol = #scriptSelectors ifTrue: [ self changed: #scriptList ].
	^ super update: aSymbol