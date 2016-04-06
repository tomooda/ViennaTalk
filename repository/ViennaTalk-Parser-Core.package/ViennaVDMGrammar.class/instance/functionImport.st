parsers-interfaces
functionImport
	^ (name
		,
			((self typeVariableList , (self operator: ':') , self functionType)
				==> [ :triple | 
					{(triple first).
					(triple third)} ]) optional , ((self renamed , (self decl: name)) ==> #second) optional)
		==> [ :triple | 
			{(triple first).
			(triple second ifNotNil: [ :paramAndType | paramAndType first ]).
			(triple second ifNotNil: [ :paramAndType | paramAndType second ]).
			(triple third)} ]