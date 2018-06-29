Class {
	#name : #ViennaIteration,
	#superclass : #Object,
	#type : #variable,
	#instVars : [
		'fun',
		'n'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'instance creation' }
ViennaIteration class >> with: aDictionaryOrBlock with: anInteger [
	^ self new
		setFun: aDictionaryOrBlock n: anInteger;
		yourself
]

{ #category : #private }
ViennaIteration >> setFun: aDictionaryOrBlock n: anInteger [
	fun := aDictionaryOrBlock.
	n := anInteger
]

{ #category : #accessing }
ViennaIteration >> valueWithArguments: anArray [
	| result |
	result := anArray.
	n
		timesRepeat: [ 
			result isArray
				ifFalse: [ result := Array with: result ].
			result := fun isCollection
				ifTrue: [ fun at: result first ]
				ifFalse: [ fun valueWithArguments: result ] ].
	^ result
]
