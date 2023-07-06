Extension { #name : #ViennaWhileLoopNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaWhileLoopNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self expression uniqueFreeIdentifiers includesAnyOf: anArrayOfString)
		ifTrue: [ ^ self ].
	^ self statement narrowestStatementWithFreeIdentifiers:
		  anArrayOfString
]
