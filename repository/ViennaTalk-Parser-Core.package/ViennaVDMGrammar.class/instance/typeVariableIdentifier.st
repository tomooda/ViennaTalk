parsers-symbols
typeVariableIdentifier
	^ ((self operator: $@) , identifier)
		==> [ :pair | 
			String
				new: pair second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: pair first;
						nextPutAll: pair second ] ]