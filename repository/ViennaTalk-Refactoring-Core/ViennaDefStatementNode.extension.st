Extension { #name : #ViennaDefStatementNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaDefStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self equalDefinitionList uniqueFreeIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [ ^ self ].
	^ self statement narrowestStatementWithFreeIdentifiers:
		  anArrayOfString
]
