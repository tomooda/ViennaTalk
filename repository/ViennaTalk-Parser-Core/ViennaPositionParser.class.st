Class {
	#name : #ViennaPositionParser,
	#superclass : #PPActionParser,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #parsing }
ViennaPositionParser >> parseOn: aPPContext [
	| start element end |
	start := aPPContext position + 1.
	element := parser parseOn: aPPContext.
	element isPetitFailure
		ifTrue: [ ^ element ].
	end := aPPContext position.
	^ block value: start value: end value: element
]