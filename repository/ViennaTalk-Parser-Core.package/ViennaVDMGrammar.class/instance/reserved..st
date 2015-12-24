utilities
reserved: aStringOrParser
	^ (comment star , (aStringOrParser asParser , followingLetter not) trim , comment star)
		==> [ :triple | triple second first ]