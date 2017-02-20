code generation-definitions
recordTypeDefinition: aViennaNode env: aDictionary
	| identifier fieldList type initializer theClass |
	identifier := aViennaNode first.
	fieldList := self generate: aViennaNode second env: aDictionary.
	type := 'ViennaCompositeType constructorName: ' , identifier storeString , ' withAll: {'
		, (' . ' join: fieldList) , '}'.
	(self generate: aViennaNode third env: aDictionary)
		ifNotNil: [ :inv | type := '(' , type , ') inv: ' , inv ].
	initializer := identifier , ' := ViennaTypeHolder new. ' , identifier , ' type: ('
		, type , ')'.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types'