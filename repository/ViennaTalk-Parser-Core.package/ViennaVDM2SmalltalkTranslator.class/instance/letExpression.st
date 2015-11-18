parsers-expressions-basics
letExpression
	^ super letExpression
		==> [ :pair | 
			| localDefinitions body vars |
			localDefinitions := pair first.
			body := pair second.
			vars := Array new: 10 streamContents: [ :stream | localDefinitions do: [ :def | stream nextPutAll: def first ] ].
			'[|' , (' ' join: vars) , '|' , ('.' join: (localDefinitions collect: #second)) , '.' , body , '] value' ]