Class {
	#name : #ViennaPartialFunctionTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaPartialFunctionTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'nat*int->bool' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat * ViennaType int -> ViennaType bool.
	self
		assert: 'nat->bool' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat -> ViennaType bool
]
