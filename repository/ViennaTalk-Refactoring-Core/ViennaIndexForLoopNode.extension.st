Extension { #name : 'ViennaIndexForLoopNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaIndexForLoopNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self startExpression uniqueBoundIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [ ^ self ].
	(self endExpression uniqueBoundIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [ ^ self ].
	(self stepExpression uniqueBoundIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [ ^ self ].
	(anArrayOfString includes: self identifier) ifTrue: [
		^ (self statement uniqueFreeIdentifiers includesAnyOf:
			   anArrayOfString)
			  ifTrue: [ self ]
			  ifFalse: [ nil ] ].
	^ self statement narrowestStatementWithFreeIdentifiers:
		  anArrayOfString
]
