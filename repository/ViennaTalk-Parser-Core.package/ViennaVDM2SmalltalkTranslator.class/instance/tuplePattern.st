parsers-patterns
tuplePattern
	^ super tuplePattern
		==> [ :args | 
			| vars varGenerator |
			vars := OrderedCollection new.
			args do: [ :arg | vars addAll: arg first ].
			varGenerator := self varNameGenerator: 'var' uniqueIn: (args collect: #second).
			{vars.
			(String
				new: 1024
				streamContents: [ :stream | 
					| var |
					var := varGenerator value.
					stream
						nextPutAll: '[:';
						nextPutAll: var;
						nextPut: $|.
					stream
						nextPutAll:
							((args size - 1 to: 1 by: -1)
								inject: args last second , ' value: (' , var , ' at: ' , args size storeString , ')'
								into: [ :expr :i | '(' , (args at: i) second , ' value: (' , var , ' at: ' , i storeString , ')) and: [' , expr , ']' ]).
					stream nextPut: $] ])} ]