parsers-expressions-basics
tupleConstructor
	^ ((self reserved: 'mk_') , lparen , expression , comma , (expression delimitedBy: comma) withoutSeparators , rparen)
		==> [ :array | 
			Array
				new: array fifth size + 1
				streamContents: [ :stream | 
					stream
						nextPut: array third;
						nextPutAll: array fifth ] ]