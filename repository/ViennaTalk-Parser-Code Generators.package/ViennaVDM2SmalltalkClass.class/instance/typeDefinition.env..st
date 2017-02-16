code generation-definitions
typeDefinition: aViennaNode env: aDictionary
	| identifier type inv initializer theClass |
	identifier := aViennaNode first.
	type := self generate: aViennaNode second env: aDictionary.
	inv := (self generate: aViennaNode third env: aDictionary)
		ifNil: [ '' ]
		ifNotNil: [ :str | ' inv: ' , str ].
	initializer := identifier , ' := ViennaTypeHolder new. ' , identifier , ' type: (' , type
		, inv , ')'.
	theClass := classes at: (aViennaNode module ifNotNil: #first).
	self
		defineLazyMethodNamed: identifier
		initializer: initializer
		in: theClass
		protocol: 'types'