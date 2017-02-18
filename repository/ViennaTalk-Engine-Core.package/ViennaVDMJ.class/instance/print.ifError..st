commands
print: aString ifError: errorBlock 
	^ self
		send: 'print ' , (aString copyReplaceAll: String cr with: String space) 
		responseDo: [:filename | filename]
		ifError: errorBlock