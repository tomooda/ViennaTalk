instance creation
default
	^ self new
		engine: ViennaClient default;
		yourself