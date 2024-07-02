Extension { #name : 'ViennaNondeterministicStatementNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaNondeterministicStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	^ ((self asArray collect: [ :statement |
		    statement narrowestStatementWithFreeIdentifiers: anArrayOfString ])
		   select: #notNil)
		  ifNotEmpty: [ :narrowests |
			  narrowests size = 1
				  ifTrue: [ narrowests first ]
				  ifFalse: [ self ] ]
		  ifEmpty: [ nil ]
]
