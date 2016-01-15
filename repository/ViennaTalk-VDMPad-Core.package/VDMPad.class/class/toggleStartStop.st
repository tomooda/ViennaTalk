servicing
toggleStartStop
	self isRunning
		ifTrue: [ self stopService ]
		ifFalse: [ self startService ]