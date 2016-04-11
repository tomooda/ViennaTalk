code generation-expressions
distributedMapMerge: aViennaNode env: aDictionary
	^ '(' , (self generate: aViennaNode first env: aDictionary)
		, ' in: [:s | | d | d := Dictionary new. s do: [:d1 | d addAll: d1]. d])'