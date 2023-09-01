Extension { #name : #ViennaLetBeStatementNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaLetBeStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self multipleBind uniqueFreeIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [ ^ self ].
	(self conditionExpression uniqueFreeIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [ ^ self ].
	^ self statement narrowestStatementWithFreeIdentifiers:
		  anArrayOfString
]
