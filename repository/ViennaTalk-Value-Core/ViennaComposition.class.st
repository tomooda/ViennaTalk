Class {
	#name : #ViennaComposition,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'arg1',
		'arg2'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'instance creation' }
ViennaComposition class >> with: aDictionaryOrBlock1 with: aDictionaryOrBlock2 [
	^ self new
		setArg1: aDictionaryOrBlock1 arg2: aDictionaryOrBlock2;
		yourself
]

{ #category : #accessing }
ViennaComposition >> applyTo: anArray [
	| t |
	t := arg2 applyTo: anArray.
	t isArray
		ifFalse: [ t := Array with: t ].
	^ arg1 applyTo: t
]

{ #category : #private }
ViennaComposition >> setArg1: f arg2: g [
	arg1 := f.
	arg2 := g
]

{ #category : #accessing }
ViennaComposition >> value: anObject [
	^ self applyTo: (Array with: anObject)
]

{ #category : #accessing }
ViennaComposition >> value: anObject1 value: anObject2 [
	^ self applyTo: (Array with: anObject1 with: anObject2)
]

{ #category : #accessing }
ViennaComposition >> value: anObject1 value: anObject2 value: anObject3 [
	^ self applyTo: (Array with: anObject1 with: anObject2 with: anObject3)
]

{ #category : #accessing }
ViennaComposition >> value: anObject1 value: anObject2 value: anObject3 value: anObject4 [
	^ self
		applyTo:
			(Array
				with: anObject1
				with: anObject2
				with: anObject3
				with: anObject4)
]

{ #category : #accessing }
ViennaComposition >> valueWithArguments: anArray [
	^ self applyTo: anArray
]
