commands
default: aString ifError: errorBlock 
	^ self
		send: 'default ' , aString
		responseDo: [:module | module]
		ifError: errorBlock