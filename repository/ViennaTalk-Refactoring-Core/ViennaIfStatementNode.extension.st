Extension { #name : 'ViennaIfStatementNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaIfStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self conditionalStatementList asArray anySatisfy: [ :conditional |
		 conditional condition uniqueFreeIdentifiers includesAnyOf:
			 anArrayOfString ]) ifTrue: [ ^ self ].
	^ (((self conditionalStatementList asArray collect: [ :conditional |
		     conditional statement narrowestStatementWithFreeIdentifiers:
			     anArrayOfString ]) copyWith:
		    (self statement narrowestStatementWithFreeIdentifiers:
			     anArrayOfString)) select: #notNil)
		  ifNotEmpty: [ :narrowests |
			  narrowests size = 1
				  ifTrue: [ narrowests first ]
				  ifFalse: [ self ] ]
		  ifEmpty: [ nil ]
]
