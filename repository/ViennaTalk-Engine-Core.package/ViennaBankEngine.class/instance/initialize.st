initialize-release
initialize
	super initialize.
	lock := Semaphore forMutualExclusion.
	engines := OrderedCollection new.
	ringBufferIndex := 0