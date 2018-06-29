Extension { #name : #Context }

{ #category : #'*ViennaTalk-Value-Core' }
Context >> viennaReturn: anObject [
	| index |
	index := self tempNames indexOf: '_opContext'.
	(index > 0
		ifTrue: [ self tempAt: index ]
		ifFalse: [ self ]) return: anObject
]
