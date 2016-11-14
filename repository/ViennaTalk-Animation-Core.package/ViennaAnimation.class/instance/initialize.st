initialize-release
initialize
	super initialize.
	lock := Semaphore forMutualExclusion.
	specification := String new.
	state := Dictionary new.
	reader := ViennaReader new.
	writer := ViennaWriter new