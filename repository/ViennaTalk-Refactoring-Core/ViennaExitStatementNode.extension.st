Extension { #name : 'ViennaExitStatementNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaExitStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	^ (self expression uniqueFreeIdentifiers includesAnyOf:
		   anArrayOfString)
		  ifTrue: [ self ]
		  ifFalse: [ nil ]
]
