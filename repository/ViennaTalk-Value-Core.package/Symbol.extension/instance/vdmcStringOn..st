*ViennaTalk-Value-Core
vdmcStringOn: aStream
	(self allSatisfy: #isLetter)
		ifFalse: [ ^ self error: 'Invalid character in a VDM quote ' ].
	aStream nextPut: $<.
	aStream nextPutAll: self.
	aStream nextPut: $>