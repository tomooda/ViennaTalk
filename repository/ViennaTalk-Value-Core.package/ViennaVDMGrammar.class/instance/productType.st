parsers-types
productType
	^ (type3 , (self operator: $*) , (type3 separatedBy: (self operator: $*)) withoutSeparators)
		==> [ :triple | 
			Array
				new: triple third size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple third ] ]