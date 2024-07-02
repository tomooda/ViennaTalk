Extension { #name : 'ViennaSequenceForLoopNode' }

{ #category : '*ViennaTalk-Refactoring-Core' }
ViennaSequenceForLoopNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	(self expression uniqueFreeIdentifiers includesAnyOf: anArrayOfString)
		ifTrue: [ ^ self ].
	(self patternOrBind uniqueFreeIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [ ^ self ].
	(self patternOrBind uniqueBoundIdentifiers includesAnyOf:
		 anArrayOfString) ifTrue: [
		^ (self statement uniqueFreeIdentifiers includesAnyOf:
			   anArrayOfString)
			  ifTrue: [ self ]
			  ifFalse: [ nil ] ].
	^ self statement narrowestStatementWithFreeIdentifiers:
		  anArrayOfString
]
