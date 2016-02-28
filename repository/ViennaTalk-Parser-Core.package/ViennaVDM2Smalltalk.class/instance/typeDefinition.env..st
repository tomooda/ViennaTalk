code generation-definitions
typeDefinition: aViennaNode env: aDictionary
	| identifier type inv |
	identifier := aViennaNode first.
	type := self generate: aViennaNode second env: aDictionary.
	inv := (self generate: aViennaNode third env: aDictionary) ifNil: [ '' ] ifNotNil: [ :str | ' inv: ' , str ].
	^ identifier , ' := ' , type , inv