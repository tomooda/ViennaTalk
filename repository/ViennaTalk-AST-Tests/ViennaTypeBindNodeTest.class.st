Class {
	#name : #ViennaTypeBindNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaTypeBindNodeTest >> testMaximalType [

	| bind |
	bind := ViennaVDMParser new bind end parse: 'x : nat1'.
	self assert: bind maximalType equals: ViennaType nat1.
	self assert: bind pattern typecheck equals: ViennaType nat1.
	bind := ViennaVDMParser new bind end parse: 'x : [real]'.
	self assert: bind maximalType equals: ViennaType real optional.
	self assert: bind pattern typecheck equals: ViennaType real optional.
	bind := ViennaVDMParser new bind end parse: 'mk_(x, y) : nat1'.
	self should: [ bind maximalType ] raise: ViennaTypeError
]
