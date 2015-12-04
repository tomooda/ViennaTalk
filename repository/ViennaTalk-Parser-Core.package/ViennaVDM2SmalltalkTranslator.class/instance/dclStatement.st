parsers-statements
dclStatement
	^ super dclStatement
		==> [ :defs | 
			{(defs inject: #() into: [ :vars :def | vars , def first ]).
			('.' join: (defs collect: #second))} ]