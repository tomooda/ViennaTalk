parsers-types
unionType
	^ (type2 , bar , (type2 separatedBy: bar) withoutSeparators)
		==> [ :triple | 
			Array
				new: triple third size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple third ] ]