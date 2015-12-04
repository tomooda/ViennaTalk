parsers-statements
blockStatement
	^ super blockStatement
		==> [ :array | 
			| decls statements vars |
			decls := array first.
			statements := array second.
			vars := decls inject: #() into: [ :vs :decl | vs , decl first ].
			'[|' , (' ' join: vars) , '|' , ('.' join: (decls collect: #second) , statements) , '] value.' ]