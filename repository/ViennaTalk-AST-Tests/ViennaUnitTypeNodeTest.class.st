Class {
	#name : 'ViennaUnitTypeNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaUnitTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: '()' asViennaTypeAst asMaximalViennaType
		equals: ViennaType unit
]
