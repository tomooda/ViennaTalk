Class {
	#name : 'ViennaInmapTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaInmapTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'inmap nat to int' asViennaTypeAst asMaximalViennaType
		equals: (ViennaType nat inmapTo: ViennaType int)
]
