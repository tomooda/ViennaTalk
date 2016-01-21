servicing
isRunning: aBoolean
	aBoolean = true
		ifTrue: [ 
			self isRunning
				ifFalse: [ self startService ] ]
		ifFalse: [ 
			self isRunning
				ifTrue: [ self stopService ] ]