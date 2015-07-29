commands
classicIfError: errorBlock 
	^ self
		send: 'classic'
		responseDo: [:unit | unit]
		ifError: errorBlock