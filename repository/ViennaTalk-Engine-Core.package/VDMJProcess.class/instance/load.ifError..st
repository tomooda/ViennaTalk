commands
load: aString ifError: errorBlock 
	^ self
		send: 'load ' , aString
		responseDo: [:filename | filename]
		ifError: errorBlock