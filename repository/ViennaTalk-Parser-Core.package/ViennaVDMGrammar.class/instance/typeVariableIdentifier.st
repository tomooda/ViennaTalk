parsers-symbols
typeVariableIdentifier
	^ ((self operator: $@) , self typeIdentifier) trim
		==> [ :pair | 
			String
				new: pair second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: pair first;
						nextPutAll: pair second ] ]