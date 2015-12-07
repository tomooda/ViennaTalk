*ViennaTalk-Value-Core
viennaReturn: anObject
	(self tempNames includes: '_opContext')
	ifFalse: [ ^ self return: anObject ].
	(self tempNamed: '_opContext') return: anObject