Extension { #name : #Context }

{ #category : #'*ViennaTalk-Value-Core' }
Context >> viennaReturn: anObject [
	(self tempNames includes: '_opContext')
	ifFalse: [ ^ self return: anObject ].
	(self tempNamed: '_opContext') return: anObject
]
