Class {
	#name : 'ViennaBasicType',
	#superclass : 'ViennaType',
	#classInstVars : [
		'current'
	],
	#category : 'ViennaTalk-Type-Core',
	#package : 'ViennaTalk-Type-Core'
}

{ #category : 'accessing' }
ViennaBasicType class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : 'testing' }
ViennaBasicType class >> isAbstract [

	^ self = ViennaBasicType
]

{ #category : 'accessing' }
ViennaBasicType >> instantiate: aDictionary [

	^ self
]
