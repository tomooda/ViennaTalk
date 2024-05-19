Class {
	#name : 'ViennaCallCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'block',
		'isDone'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaCallCombinatorialGenerator class >> on: aBlock [

	^ self new
		  block: aBlock;
		  yourself
]

{ #category : 'accessing' }
ViennaCallCombinatorialGenerator >> block [

	^ block
]

{ #category : 'accessing' }
ViennaCallCombinatorialGenerator >> block: aBlock [

	block := aBlock.
	isDone := false
]

{ #category : 'initialization' }
ViennaCallCombinatorialGenerator >> initialize [

	super initialize.
	block := [ :env |  ].
	isDone := false
]

{ #category : 'operations' }
ViennaCallCombinatorialGenerator >> reset [

	isDone := false
]

{ #category : 'operations' }
ViennaCallCombinatorialGenerator >> step: aDictionary [

	isDone := true.
	^ false
]

{ #category : 'operations' }
ViennaCallCombinatorialGenerator >> value: aDictionary [

	^ isDone ifFalse: [ block value: aDictionary copy ]
]
