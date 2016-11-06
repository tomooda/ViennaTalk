initialize-release
initialize
	super initialize.
	decoder := ViennaVDMValueDecoder new.
	runtimeAssertionCheck := self class defaultRuntimeAssertionCheck.
	runtimeTypeCheck := self class defaultRuntimeAssertionCheck