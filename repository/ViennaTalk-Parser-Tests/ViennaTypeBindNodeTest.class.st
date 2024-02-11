Class {
	#name : #ViennaTypeBindNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaTypeBindNodeTest >> testMaximalType [

	| bind |
	bind := ViennaVDMParser new bind end parse: 'x : nat1'.
	self
		shouldnt: [ bind typecheck: ViennaType unit ]
		raise: ViennaTypeError.
	self assert: bind pattern typecheck equals: ViennaType nat1.
	bind := ViennaVDMParser new bind end parse: 'x : [real]'.
	self
		shouldnt: [ bind typecheck: ViennaType unit ]
		raise: ViennaTypeError.
	self assert: bind pattern typecheck equals: ViennaType real optional.
	bind := ViennaVDMParser new bind end parse: 'mk_(x, y) : nat1'.
	self
		should: [ bind typecheck: ViennaType unit ]
		raise: ViennaTypeError
]
