Class {
	#name : #ViennaTypeBindNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaTypeBindNodeTest >> testMaximalType [

	| bind |
	bind := ViennaVDMParser new bind end parse: 'x : nat1'.
	self assert: bind typecheck equals: ViennaType nat1.
	self assert: bind pattern typecheck equals: ViennaType nat1.
	bind maximalType: ViennaType real.
	self assert: bind pattern typecheck equals: ViennaType nat1.
	bind := ViennaVDMParser new bind end parse: 'x : [real]'.
	self assert: bind typecheck equals: ViennaType real optional.
	self assert: bind pattern typecheck equals: ViennaType real optional.
	bind maximalType: (ViennaType real | ViennaType char) optional.
	self assert: bind pattern typecheck equals: ViennaType real optional
]
