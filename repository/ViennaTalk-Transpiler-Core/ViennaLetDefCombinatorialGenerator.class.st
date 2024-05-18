Class {
	#name : 'ViennaLetDefCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'subgenerator',
		'block'
	],
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'instance creation' }
ViennaLetDefCombinatorialGenerator class >> on: aBlock [

	^ self new
		  block: aBlock;
		  yourself
]

{ #category : 'instance creation' }
ViennaLetDefCombinatorialGenerator class >> on: aBlock in: aViennaCombinatorialGenerator [

	^ self new
		  block: aBlock;
		  subgenerator: aViennaCombinatorialGenerator;
		  yourself
]

{ #category : 'as yet unclassified' }
ViennaLetDefCombinatorialGenerator >> block [

	^ block
]

{ #category : 'as yet unclassified' }
ViennaLetDefCombinatorialGenerator >> block: aBlock [

	block := aBlock
]

{ #category : 'initialization' }
ViennaLetDefCombinatorialGenerator >> initialize [

	super initialize.
	block := [ :env |  ]
]

{ #category : 'initialization' }
ViennaLetDefCombinatorialGenerator >> peek [

	^ subgenerator peek ifNotNil: [ :valuable |
		  [ :env |
		  block value: env.
		  valuable value: env ] ]
]

{ #category : 'initialization' }
ViennaLetDefCombinatorialGenerator >> reset [

	subgenerator reset
]

{ #category : 'initialization' }
ViennaLetDefCombinatorialGenerator >> step [

	subgenerator step
]

{ #category : 'accessing' }
ViennaLetDefCombinatorialGenerator >> subgenerator [

	^ subgenerator
]

{ #category : 'accessing' }
ViennaLetDefCombinatorialGenerator >> subgenerator: aVIennaCombinatorialGenerator [

	subgenerator := aVIennaCombinatorialGenerator
]
