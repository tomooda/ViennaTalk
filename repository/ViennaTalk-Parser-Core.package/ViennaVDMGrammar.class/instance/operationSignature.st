parsers-interfaces
operationSignature
	^ (nameList , (self operator: ':') , self operationType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]