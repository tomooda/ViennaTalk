code generation-expressions
symbolicLiteral: aViennaNode env: aDictionary
	^ (decoder symbolicLiteral parse: aViennaNode first trim) storeString