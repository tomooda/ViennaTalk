utilities
operator: aStringOrCharacterOrParser
	^ (comment star , aStringOrCharacterOrParser asParser trim , comment star) ==> #second