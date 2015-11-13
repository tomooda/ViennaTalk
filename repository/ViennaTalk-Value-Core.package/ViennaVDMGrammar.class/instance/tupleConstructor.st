parsers-expressions
tupleConstructor
	^ ((self reserved: 'mk_') , (self operator: $() , expression , (self operator: $,)
		, (expression delimitedBy: (self operator: $,)) withoutSeparators , (self operator: $)))
		==> [ :array | 
			Array
				new: array fifth size + 1
				streamContents: [ :stream | 
					stream
						nextPut: array third;
						nextPutAll: array fifth ] ]