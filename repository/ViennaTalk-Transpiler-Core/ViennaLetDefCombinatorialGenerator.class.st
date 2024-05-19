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

{ #category : 'accessing' }
ViennaLetDefCombinatorialGenerator >> block [

	^ block
]

{ #category : 'accessing' }
ViennaLetDefCombinatorialGenerator >> block: aBlock [

	block := aBlock
]

{ #category : 'initialization' }
ViennaLetDefCombinatorialGenerator >> initialize [

	super initialize.
	block := [ :env |  ]
]

{ #category : 'operations' }
ViennaLetDefCombinatorialGenerator >> reset [

	subgenerator reset
]

{ #category : 'operations' }
ViennaLetDefCombinatorialGenerator >> step: aDictionary [

	^ subgenerator step: aDictionary
]

{ #category : 'accessing' }
ViennaLetDefCombinatorialGenerator >> subgenerator [

	^ subgenerator
]

{ #category : 'accessing' }
ViennaLetDefCombinatorialGenerator >> subgenerator: aVIennaCombinatorialGenerator [

	subgenerator := aVIennaCombinatorialGenerator
]

{ #category : 'operations' }
ViennaLetDefCombinatorialGenerator >> value: aDictionary [

	| env |
	env := aDictionary copy.
	block value: env.
	^ subgenerator value: env
]
