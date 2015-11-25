parsers-patterns
seqEnumPattern
	^ super seqEnumPattern
		==> [ :elements | 
			| varGenerator vars valueVar |
			varGenerator := self varNameGenerator: 'seqEnum' uniqueIn: (elements collect: #second).
			vars := Array new: 10 streamContents: [ :stream | elements do: [ :pat | stream nextPutAll: pat first ] ].
			valueVar := varGenerator value.
			{vars.
			(String
				new: 1024
				streamContents: [ :stream | 
					stream
						nextPutAll: '[:';
						nextPutAll: valueVar;
						nextPutAll: '|';
						nextPutAll: valueVar;
						nextPutAll: ' isCollection and: [';
						nextPutAll: valueVar;
						nextPutAll: ' isSequenceable and: [';
						nextPutAll: valueVar;
						nextPutAll: ' isArray not and: [';
						nextPutAll: valueVar;
						nextPutAll: ' size = ';
						nextPutAll: elements size storeString.
					elements
						keysAndValuesDo: [ :index :pat | 
							| binder |
							binder := pat second.
							stream
								nextPutAll: ' and: [(';
								nextPutAll: binder;
								nextPutAll: ' value: (';
								nextPutAll: valueVar;
								nextPutAll: ' at: ';
								nextPutAll: index storeString;
								nextPutAll: ')) ' ].
					elements size + 4 timesRepeat: [ stream nextPut: $] ] ])} ]