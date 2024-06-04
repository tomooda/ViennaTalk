Class {
	#name : 'ViennaMapTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaMapTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'map nat to int' asViennaTypeAst asMaximalViennaType
		equals: (ViennaType nat mapTo: ViennaType int)
]
