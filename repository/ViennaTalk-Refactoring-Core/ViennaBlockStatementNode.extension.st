Extension { #name : 'ViennaBlockStatementNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaBlockStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	self dclStatement ifNotNil: [ :dcl |
		(dcl uniqueFreeIdentifiers includesAnyOf: anArrayOfString) ifTrue: [
			^ self ] ].
	^ (self asArray
		   collect: [ :statement |
			   (statement narrowestStatementWithFreeIdentifiers:
				    anArrayOfString) notNil ]
		   thenSelect: #notNil)
		  ifNotEmpty: [ :narrowests |
			  narrowests size = 1
				  ifTrue: [ narrowests first ]
				  ifFalse: [ self ] ]
		  ifEmpty: [ nil ]
]
