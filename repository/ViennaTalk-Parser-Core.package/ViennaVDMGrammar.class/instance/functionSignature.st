parsers-interfaces
functionSignature
	^ (nameList , (self operator: ':') , self functionType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]