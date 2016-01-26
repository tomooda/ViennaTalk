code generation-expressions
symbolicLiteral: aViennaNode
	^ (decoder symbolicLiteral parse: aViennaNode first trim) storeString