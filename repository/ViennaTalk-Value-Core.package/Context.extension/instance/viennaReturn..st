*ViennaTalk-Value-Core
viennaReturn: anObject
	| index |
	index := self tempNames indexOf: '_opContext'.
	(index > 0
		ifTrue: [ self tempAt: index ]
		ifFalse: [ self ]) return: anObject