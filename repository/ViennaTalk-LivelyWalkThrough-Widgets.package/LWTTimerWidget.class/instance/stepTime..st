accessing
stepTime: aNumber
	stepTime := aNumber.
	self stopStepping.
	stepping
		ifTrue: [ self startStepping ]