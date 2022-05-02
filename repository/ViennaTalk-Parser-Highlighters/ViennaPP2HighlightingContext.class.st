Class {
	#name : #ViennaPP2HighlightingContext,
	#superclass : #PP2InMemoryContext,
	#instVars : [
		'furthestPosition'
	],
	#category : #'ViennaTalk-Parser-Highlighters'
}

{ #category : #accessing }
ViennaPP2HighlightingContext >> furthestPosition [

	^ furthestPosition max: position
]

{ #category : #accessing }
ViennaPP2HighlightingContext >> furthestPosition: anObject [

	furthestPosition := anObject
]

{ #category : #initialization }
ViennaPP2HighlightingContext >> initialize [

	super initialize.
	self reset
]

{ #category : #accessing }
ViennaPP2HighlightingContext >> next [

	furthestPosition := furthestPosition max: position + 1.
	^ super next
]

{ #category : #accessing }
ViennaPP2HighlightingContext >> next: number [

	furthestPosition := furthestPosition max: position + number.
	^ super next: number
]

{ #category : #initialization }
ViennaPP2HighlightingContext >> reset [

	super reset.
	furthestPosition := -1
]

{ #category : #memoization }
ViennaPP2HighlightingContext >> restore: whatever [

	furthestPosition := furthestPosition max: position.
	^ super restore: whatever
]

{ #category : #memoization }
ViennaPP2HighlightingContext >> restorePosition: newPosition [

	furthestPosition := furthestPosition max: position.
	^ super restorePosition: newPosition
]
