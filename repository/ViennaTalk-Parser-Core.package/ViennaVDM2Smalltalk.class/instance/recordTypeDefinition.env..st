code generation-types
recordTypeDefinition: aViennaNode env: aDictionary
	| constructorName fields |
	constructorName := self generate: aViennaNode first env: aDictionary.
	fields := aViennaNode second
		collect: [ :field | 
			'{' , field first storeString , ' . ' , field second storeString , ' . ' , (self generate: field third env: aDictionary)
				, '}' ].
	^ '(ViennaType compose: ' , constructorName storeString , ' of: {' , (' . ' join: fields) , '})'