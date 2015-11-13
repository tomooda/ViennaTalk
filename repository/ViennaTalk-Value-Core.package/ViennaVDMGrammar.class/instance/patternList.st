parsers-patterns
patternList
	^ (pattern , ((self operator: ',') , pattern) star)
		==> [ :pair | 
			Array
				new: pair second size + 1
				streamContents: [ :stream | 
					stream nextPut: pair first.
					pair second do: [ :p | stream nextPut: p second ] ] ]