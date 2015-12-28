parsers
vdmSeq
	^ ($[ asParser trim , vdmPattern , $] asParser trim)
		==> [ :triple | WWTTranslationOrderedCollectionMatcher with: triple second ]