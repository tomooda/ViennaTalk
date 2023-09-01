Extension { #name : #ViennaSetForLoopNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaSetForLoopNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self expression uniqueFreeIdentifiers includesAnyOf: anArrayOfString)
		ifTrue: [ ^ self ].
	(self pattern uniqueBoundIdentifiers includesAnyOf: anArrayOfString)
		ifTrue: [
			^ (self statement uniqueFreeIdentifiers includesAnyOf:
				   anArrayOfString)
				  ifTrue: [ self ]
				  ifFalse: [ nil ] ].
	^ self statement narrowestStatementWithFreeIdentifiers:
		  anArrayOfString
]
