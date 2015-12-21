parsers-interfaces
valueSignature
	^ (nameList , (self operator: ':') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]