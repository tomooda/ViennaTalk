accessing
stepping: aBoolean
	stepping := aBoolean.
	self stopStepping.
	stepping
		ifTrue: [ self startStepping ]