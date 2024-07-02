Extension { #name : 'ViennaReturnStatementNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaReturnStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	^ (self expression uniqueFreeIdentifiers includesAnyOf:
		   anArrayOfString)
		  ifTrue: [ self ]
		  ifFalse: [ nil ]
]
