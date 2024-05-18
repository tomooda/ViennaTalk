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

{ #category : 'as yet unclassified' }
ViennaCallCombinatorialGenerator >> block [

	^ block
]

{ #category : 'as yet unclassified' }
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

{ #category : 'initialization' }
ViennaCallCombinatorialGenerator >> peek [

	^ isDone ifFalse: [ block ]
]

{ #category : 'initialization' }
ViennaCallCombinatorialGenerator >> reset [

	isDone := false
]

{ #category : 'initialization' }
ViennaCallCombinatorialGenerator >> step [

	isDone := true
]
