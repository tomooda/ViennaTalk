*ViennaTalk-Value-Core
viennaReturn: anObject
	| scope |
	scope := self sourceNode scope.
	(scope allTempNames includes: '_opContext')
		ifFalse: [ ^ self return: anObject ].
	"(self tempNamed: '_opContext') return: anObject"
	^ ((scope lookupVar: '_opContext') searchFromContext: self scope: scope) return: anObject