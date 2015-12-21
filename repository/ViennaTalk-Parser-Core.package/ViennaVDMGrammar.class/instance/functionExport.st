parsers-interfaces
functionExport
	^ (nameList , self typeVariableList , (self operator: ':') , self functionType)
		==> [ :quatro | 
			{(quatro first).
			(quatro second).
			(quatro fourth)} ]