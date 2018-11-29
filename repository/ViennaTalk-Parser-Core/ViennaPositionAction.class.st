Class {
	#name : #ViennaPositionAction,
	#superclass : #PP2Strategy,
	#category : #'ViennaTalk-Parser-Core'
}

{ #category : #parsing }
ViennaPositionAction >> parseOn: aPP2Context [
	| start element end |
	start := aPP2Context position + 1.
	element := node child parseOn: aPP2Context.
	^ element isPetit2Success
		ifTrue: [ end := aPP2Context position.
			node block value: start value: end value: element ]
		ifFalse: [ ^ element ]
]
