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

{ #category : #private }
ViennaComposition >> setArg1: f arg2: g [
	arg1 := f.
	arg2 := g
]

{ #category : #accessing }
ViennaComposition >> valueWithArguments: anArray [
	| t |
	t := arg2 isCollection
		ifTrue: [ arg2 at: anArray first ]
		ifFalse: [ arg2 valueWithArguments: anArray ].
	t isArray
		ifFalse: [ t := Array with: t ].
	^ arg1 isCollection
		ifTrue: [ arg1 at: t first ]
		ifFalse: [ arg1 valueWithArguments: t ]
]
