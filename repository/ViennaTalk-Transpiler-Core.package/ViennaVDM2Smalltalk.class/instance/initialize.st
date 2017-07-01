initialize-release
initialize
	super initialize.
	defaultEnv := Dictionary new.
	decoder := ViennaVDMValueDecoder new.
	runtimeAssertionCheck := self class defaultRuntimeAssertionCheck.
	runtimeTypeCheck := self class defaultRuntimeAssertionCheck