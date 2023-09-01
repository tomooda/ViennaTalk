Extension { #name : #ViennaAssignStatementNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaAssignStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	^ (self expression uniqueBoundIdentifiers includesAnyOf:
		   anArrayOfString)
		  ifTrue: [ self ]
		  ifFalse: [ nil ]
]
