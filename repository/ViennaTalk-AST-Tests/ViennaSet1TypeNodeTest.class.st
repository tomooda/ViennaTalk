Class {
	#name : 'ViennaSet1TypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaSet1TypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'set1 of nat' asViennaTypeAst asMaximalViennaType
		equals: ViennaType nat set1
]
