Extension { #name : #Array }

{ #category : #'*ViennaTalk-Value-Core' }
Array >> applyTo: anArray [
	^ self error: 'Array can not be applied'
]

{ #category : #'*ViennaTalk-Value-Core' }
Array >> isSequence [
	^ false
]
