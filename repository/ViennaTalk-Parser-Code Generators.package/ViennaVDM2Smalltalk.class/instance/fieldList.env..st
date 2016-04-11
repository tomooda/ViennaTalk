code generation-types
fieldList: aViennaNode env: aDictionary
	^ aViennaNode
		collect: [ :field | 
			'{' , field first storeString , ' . ' , field second storeString , ' . ' , (self generate: field third env: aDictionary)
				, '}' ]