servicing
localOnly: aBoolean
	aBoolean ~= false
		ifTrue: [ 
			LocalOnly ~= false
				ifTrue: [ ^ self ].
			LocalOnly := true ]
		ifFalse: [ 
			LocalOnly = false
				ifTrue: [ ^ self ].
			LocalOnly := false ].
	self isRunning
		ifTrue: [ 
			self stopService.
			self startService ]