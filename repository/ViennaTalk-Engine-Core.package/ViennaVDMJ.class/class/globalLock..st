locking
globalLock: aBlock
	self globalLock critical: [ ^ aBlock value ]