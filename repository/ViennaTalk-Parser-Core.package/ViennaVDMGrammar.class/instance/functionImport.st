parsers-interfaces
functionImport
	^ name
		,
			((self typeVariableList , (self operator: ':') , self functionType)
				==> [ :triple | 
					{(triple first).
					(triple third)} ]) optional , (((self reserved: 'renamed') , name) ==> #second) optional