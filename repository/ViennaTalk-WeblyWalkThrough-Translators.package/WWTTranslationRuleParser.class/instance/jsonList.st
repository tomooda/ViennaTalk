parsers
jsonList
	^ ($[ asParser trim , jsonPattern , $] asParser trim)
		==> [ :triple | WWTTranslationOrderedCollectionMatcher with: triple second ]