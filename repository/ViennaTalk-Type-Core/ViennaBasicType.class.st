Class {
	#name : #ViennaBasicType,
	#superclass : #ViennaType,
	#classInstVars : [
		'current'
	],
	#category : #'ViennaTalk-Type-Core'
}

{ #category : #accessing }
ViennaBasicType class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : #testing }
ViennaBasicType class >> isAbstract [

	^ self = ViennaBasicType
]
