Extension { #name : #ViennaMultipleAssignStatementNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaMultipleAssignStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	^ (self uniqueFreeIdentifiers includesAnyOf: anArrayOfString)
		  ifTrue: [ self ]
		  ifFalse: [ nil ]
]
