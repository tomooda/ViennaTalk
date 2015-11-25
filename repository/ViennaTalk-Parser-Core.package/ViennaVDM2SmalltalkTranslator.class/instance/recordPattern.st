parsers-patterns
recordPattern
	^ super recordPattern
		==> [ :tuple | 
			| typeName args vars varGenerator |
			typeName := tuple first.
			args := tuple second.
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
						nextPutAll: var;
						nextPutAll: ' isViennaComposite and: [';
						nextPutAll: var;
						nextPutAll: ' typeName = ';
						nextPutAll: typeName storeString;
						nextPutAll: ' and: [';
						nextPutAll: var;
						nextPutAll: ' size = ';
						nextPutAll: args size storeString;
						nextPutAll: ' and: [';
						nextPutAll:
								((args size - 1 to: 1 by: -1)
										inject: args last second , ' value: (' , var , ' at: ' , args size storeString , ')'
										into: [ :expr :i | '(' , (args at: i) second , ' value: (' , var , ' at: ' , i storeString , ')) and: [' , expr , ']' ]).
					stream nextPutAll: ']]]]' ])} ]