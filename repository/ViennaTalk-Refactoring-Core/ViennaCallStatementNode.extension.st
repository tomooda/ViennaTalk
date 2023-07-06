Extension { #name : #ViennaCallStatementNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaCallStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	^ (self uniqueFreeIdentifiers includesAnyOf: anArrayOfString)
		  ifTrue: [ self ]
		  ifFalse: [ nil ]
]
