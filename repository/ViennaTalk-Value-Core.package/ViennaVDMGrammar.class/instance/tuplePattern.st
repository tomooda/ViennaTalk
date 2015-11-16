parsers-patterns
tuplePattern
	^ ((self reserved: 'mk_') , lparen , pattern , comma , (pattern separatedBy: comma) withoutSeparators , rparen)
		==> [ :array | 
			Array
				new: array fifth size + 1
				streamContents: [ :stream | 
					stream
						nextPut: array third;
						nextPutAll: array fifth ] ]