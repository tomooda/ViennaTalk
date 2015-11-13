utilities
reserved: aStringOrParser
	^ (aStringOrParser asParser , followingLetter not) trim ==> [ :pair | pair first ]