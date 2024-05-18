Class {
	#name : 'ViennaLetBestCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'bindSubgenerators',
		'isDone',
		'guardBlock',
		'subgenerator'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaLetBestCombinatorialGenerator class >> on: aBlock [

	^ self new
		  block: aBlock;
		  yourself
]

{ #category : 'instance creation' }
ViennaLetBestCombinatorialGenerator class >> on: aBlock in: aViennaCombinatorialGenerator [

	^ self new
		  block: aBlock;
		  subgenerator: aViennaCombinatorialGenerator;
		  yourself
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> bindSubgenerators [

	^ bindSubgenerators
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> bindSubgenerators: anArrayOfViennaCombinatorialGenerator [

	bindSubgenerators := anArrayOfViennaCombinatorialGenerator.
	isDone := false
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> guardBlock [

	^ guardBlock
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> guardBlock: aBlock [

	guardBlock := aBlock
]

{ #category : 'initialization' }
ViennaLetBestCombinatorialGenerator >> initialize [

	super initialize.
	bindSubgenerators := Array new.
	isDone := true.
	guardBlock := [ :value | true ]
]

{ #category : 'initialization' }
ViennaLetBestCombinatorialGenerator >> peek [

	| binders body |
	isDone ifTrue: [ ^ nil ].
	[ binders := bindSubgenerators collect: #peek ] whileFalse: [
		self step ].
	body := subgenerator peek.
	^ [ :env |
	  binders do: [ :bind | bind value: env ].
	  (guardBlock value: env) ifTrue: [ body value: env ] ]
]

{ #category : 'initialization' }
ViennaLetBestCombinatorialGenerator >> reset [

	bindSubgenerators do: #reset.
	isDone := false.
	subgenerator reset
]

{ #category : 'initialization' }
ViennaLetBestCombinatorialGenerator >> step [

	isDone ifTrue: [ ^ self ].
	subgenerator step.
	subgenerator peek ifNotNil: [ ^ self ].
	subgenerator reset.
	bindSubgenerators do: [ :generator |
		generator step.
		generator peek ifNotNil: [ ^ self ].
		generator reset ].
	isDone := true
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> subgenerator [

	^ subgenerator
]

{ #category : 'accessing' }
ViennaLetBestCombinatorialGenerator >> subgenerator: aVIennaCombinatorialGenerator [

	subgenerator := aVIennaCombinatorialGenerator
]
