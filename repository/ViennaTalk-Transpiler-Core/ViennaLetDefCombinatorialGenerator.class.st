Class {
	#name : 'ViennaLetDefCombinatorialGenerator',
	#superclass : 'ViennaCombinatorialGenerator',
	#instVars : [
		'subgenerator',
		'block'
	],
	#category : 'ViennaTalk-Transpiler-Core-CombinatorialTesting',
	#package : 'ViennaTalk-Transpiler-Core',
	#tag : 'CombinatorialTesting'
}

{ #category : 'instance creation' }
ViennaLetDefCombinatorialGenerator class >> bindBlock: aBlock in: aViennaCombinatorialGenerator [

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

{ #category : 'copying' }
ViennaLetDefCombinatorialGenerator >> postCopy [

	super postCopy.
	subgenerator := subgenerator ifNotNil: #copy
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
