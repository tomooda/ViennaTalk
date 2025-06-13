Extension { #name : 'ViennaDurationStatementNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaDurationStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	^ (self expression uniqueBoundIdentifiers includesAnyOf:
		   anArrayOfString)
		  ifTrue: [ self ]
		  ifFalse: [
			  self statement narrowestStatementWithFreeIdentifiers:
				  anArrayOfString ]
]
