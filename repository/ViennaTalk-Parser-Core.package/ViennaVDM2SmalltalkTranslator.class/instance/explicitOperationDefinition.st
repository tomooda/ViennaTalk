parsers-definitions
explicitOperationDefinition
	^ super explicitOperationDefinition
		==> [ :array | 
			| opname opType opname2 params opbody varGenerator vars |
			opname := array first.
			opType := array second.
			opname2 := array third.
			params := array fourth.
			opbody := array fifth.
			varGenerator := self
				varNameGenerator: 'op'
				uniqueIn:
					{opname.
					opbody}.
			vars := params collect: [ :p | varGenerator value ].
			{{opname}.
			(String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPutAll: opname;
						nextPutAll: ' := ['.
					vars
						do: [ :v | 
							stream
								nextPutAll: ' :';
								nextPutAll: v ].
					stream
						nextPutAll: ' ||';
						nextPutAll: (' ' join: (params inject: #() into: [ :vs :pat | vs , pat first ]));
						nextPutAll: ' | '.
					params
						with: vars
						do: [ :p :v | 
							stream
								nextPutAll: (self binder: p second with: v vars: p first);
								nextPutAll: ' ifFalse: [ViennaNoMatch signal].' ].
					stream
						nextPutAll: opbody;
						nextPutAll: ']' ])} ]