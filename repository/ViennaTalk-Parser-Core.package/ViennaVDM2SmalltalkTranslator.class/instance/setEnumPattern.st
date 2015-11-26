parsers-patterns
setEnumPattern
	^ super setEnumPattern
		==> [ :elementPatterns | 
			| vars elements |
			vars := (Array new: 10 streamContents: [ :stream | elementPatterns do: [ :pat | stream nextPutAll: pat first ] ])
				asSet asArray.
			elements := elementPatterns collect: #second.
			{vars.
			('(ViennaRuntimeUtil matchSetEnumeration: {' , (' . ' join: elements) , '})')} ]