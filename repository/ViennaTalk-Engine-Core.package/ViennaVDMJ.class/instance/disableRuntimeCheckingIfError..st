commands
disableRuntimeCheckingIfError: errorBlock 
	^ self
		send: '-rtc'
		responseDo: [:unit | unit]
		ifError: errorBlock