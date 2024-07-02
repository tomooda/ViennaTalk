Extension { #name : 'ViennaCasesStatementNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaCasesStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self expression uniqueFreeIdentifiers includesAnyOf: anArrayOfString)
		ifTrue: [ ^ self ].
	^ (((self casesStatementAlternatives collect: [ :alternative |
		     alternative statement narrowestStatementWithFreeIdentifiers:
			     anArrayOfString ]) copyWith: (self othersStatement statement
			     narrowestStatementWithFreeIdentifiers: anArrayOfString))
		   select: #notNil)
		  ifNotEmpty: [ :narrowests |
			  narrowests size = 1
				  ifTrue: [ narrowests first ]
				  ifFalse: [ self ] ]
		  ifEmpty: [ nil ]
]
