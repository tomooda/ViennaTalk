initialize-release
initialize
	super initialize.
	lock := Semaphore forMutualExclusion.
	http := ZnClient new.
	self url: self defaultUrl.
	specification := String new.
	state := Dictionary new.
	reader := ViennaReader new.
	writer := ViennaWriter new