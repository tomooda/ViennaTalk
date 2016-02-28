code generation-definitions
recordTypeDefinition: aViennaNode env: aDictionary
	| identifier fieldList type |
	identifier := aViennaNode first.
	fieldList := self generate: aViennaNode second env: aDictionary.
	type := 'ViennaCompositeType constructorName: ' , identifier storeString , ' withAll: {' , (' . ' join: fieldList)
		, '}'.
	(self generate: aViennaNode third env: aDictionary) ifNotNil: [ :inv | type := '(' , type , ') inv: ' , inv ].
	^ identifier , ' := ' , type