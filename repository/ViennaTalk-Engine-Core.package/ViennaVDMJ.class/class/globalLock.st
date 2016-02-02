locking
globalLock
	^ GlobalLock ifNil: [ GlobalLock := Semaphore forMutualExclusion ]