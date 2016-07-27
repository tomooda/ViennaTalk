initialize-release
initialize
	super initialize.
	decoder := ViennaVDMValueDecoder new.
	runtimeAssertionCheck := true.
	runtimeTypeCheck := true