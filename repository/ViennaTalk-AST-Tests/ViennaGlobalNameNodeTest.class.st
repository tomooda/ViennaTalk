"
A ViennaGlobalNameNodeTest is a test class for testing the behavior of ViennaGlobalNameNode
"
Class {
	#name : 'ViennaGlobalNameNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaGlobalNameNodeTest >> testMaximalType [

	| spec |
	spec := 'module A exports all definitions values v : real = 1 end A module B imports from A all exports all definitions end B'
		        asViennaDocumentAst.
	((spec moduleNamed: 'A') resolveIdentifier: 'v') typecheck.
	self
		assert: ('A`v' asViennaExpressionAst
				 parent: (spec moduleNamed: 'B') moduleBody;
				 maximalType)
		equals: ViennaType nat1.
	self
		should: [
			'A`w' asViennaExpressionAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
