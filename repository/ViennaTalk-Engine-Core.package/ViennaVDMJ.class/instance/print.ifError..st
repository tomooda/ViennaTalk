commands
print: aString ifError: errorBlock 
	^ self
		send: 'print ' , aString
		responseDo: [:filename | filename]
		ifError: errorBlock