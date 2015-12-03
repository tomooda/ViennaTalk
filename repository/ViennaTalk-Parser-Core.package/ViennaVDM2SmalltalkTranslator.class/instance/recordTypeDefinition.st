parsers-definitions
recordTypeDefinition
	^ super recordTypeDefinition
		==> [ :array | 
			| ident flist inv record |
			ident := array first.
			flist := array second.
			inv := array third.
			record := 'ViennaCompositeType constructorName: ' , ident storeString , ' withAll: {' , (' . ' join: flist) , '}'.
			inv ifNotNil: [ record := '(' , record , ') inv: ' , inv ].
			ident , ' := ' , record , '.' ]