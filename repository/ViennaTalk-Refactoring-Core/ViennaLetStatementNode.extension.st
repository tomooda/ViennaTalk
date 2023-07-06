Extension { #name : #ViennaLetStatementNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaLetStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self localDefinitionList uniqueFreeIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [ ^ self ].
	^ self statement narrowestStatementWithFreeIdentifiers:
		  anArrayOfString
]
