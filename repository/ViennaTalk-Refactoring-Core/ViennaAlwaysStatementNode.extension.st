Extension { #name : #ViennaAlwaysStatementNode }

{ #category : #'*ViennaTalk-Refactoring-Core' }
ViennaAlwaysStatementNode >> narrowestStatementWithFreeIdentifiers: anArrayOfString [

	| s1 s2 |
	s1 := self bodyStatement narrowestStatementWithFreeIdentifiers:
		      anArrayOfString.
	s2 := self entailingStatement narrowestStatementWithFreeIdentifiers:
		      anArrayOfString.
	^ s1 ifNotNil: [ s2 ifNotNil: [ self ] ifNil: [ s1 ] ] ifNil: [ s2 ]
]
