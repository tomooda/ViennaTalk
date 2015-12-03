parsers-definitions
recordTypeDefinition
	^ (identifier , (self operator: '::') , fieldList , invariant optional)
		==> [ :quatro | 
			| ident flist inv |
			ident := quatro first.
			flist := quatro third.
			inv := quatro fourth.
			{ident.
			flist.
			inv} ]