Class {
	#name : #ViennaIteration,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'block',
		'n'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'instance creation' }
ViennaIteration class >> with: aBlock with: anInteger [
	^ self new
		setBlock: aBlock n: anInteger;
		yourself
]

{ #category : #accessing }
ViennaIteration >> ** anInteger [
	^ ViennaIteration with: block with: anInteger * n
]

{ #category : #accessing }
ViennaIteration >> applyTo: anArray [
	| result |
	result := anArray.
	n
		timesRepeat: [ 
			result := result isArray
				ifTrue: [ block applyTo: result ]
				ifFalse: [ block value: result ] ].
	^ result
]

{ #category : #accessing }
ViennaIteration >> comp: applicative [
	^ ViennaComposition with: self with: applicative
]

{ #category : #testing }
ViennaIteration >> isFunction [
	^ true
]

{ #category : #accessing }
ViennaIteration >> numArgs [
	^ block numArgs
]

{ #category : #private }
ViennaIteration >> setBlock: aBlock n: anInteger [
	block := aBlock.
	n := anInteger
]

{ #category : #accessing }
ViennaIteration >> value: anObject [
	^ self applyTo: (Array with: anObject)
]

{ #category : #accessing }
ViennaIteration >> value: anObject1 value: anObject2 [
	^ self applyTo: (Array with: anObject1 with: anObject2)
]

{ #category : #accessing }
ViennaIteration >> value: anObject1 value: anObject2 value: anObject3 [
	^ self applyTo: (Array with: anObject1 with: anObject2 with: anObject3)
]

{ #category : #accessing }
ViennaIteration >> value: anObject1 value: anObject2 value: anObject3 value: anObject4 [
	^ self
		applyTo:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4)
]

{ #category : #accessing }
ViennaIteration >> valueWithArguments: anArray [
	^ self applyTo: anArray
]
