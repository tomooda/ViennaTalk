Class {
	#name : 'ViennaBlockCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'block',
		'isDone'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'as yet unclassified' }
ViennaBlockCombinatorialGenerator class >> on: aBlock [

	^ self new
		  block: aBlock;
		  yourself
]

{ #category : 'accessing' }
ViennaBlockCombinatorialGenerator >> block [

	^ block
]

{ #category : 'accessing' }
ViennaBlockCombinatorialGenerator >> block: aBlock [

	block := aBlock.
	isDone := false
]

{ #category : 'initialization' }
ViennaBlockCombinatorialGenerator >> initialize [

	super initialize.
	block := [ :env |  ].
	isDone := false
]

{ #category : 'operations' }
ViennaBlockCombinatorialGenerator >> reset [

	isDone := false
]

{ #category : 'operations' }
ViennaBlockCombinatorialGenerator >> step: aDictionary [

	isDone := true.
	^ false
]

{ #category : 'operations' }
ViennaBlockCombinatorialGenerator >> value: aDictionary [

	^ isDone ifFalse: [ block value: aDictionary copy ]
]
