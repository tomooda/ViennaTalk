parsers-types
unionType
	^ (type2 , (self operator: $|) , (type2 separatedBy: (self operator: $|)) withoutSeparators)
		==> [ :triple | 
			Array
				new: triple third size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple third ] ]