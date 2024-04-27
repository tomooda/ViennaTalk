"
A ViennaLocalNameNodeTest is a test class for testing the behavior of ViennaLocalNameNode
"
Class {
	#name : #ViennaLocalNameNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaLocalNameNodeTest >> testMaximalType [

	| spec |
	spec := 'state S of x:int init s == s = mk_S(0) end values v:real = 1'
		        asViennaDocumentAst.
	(spec resolveIdentifier: 'v') typecheck.
	self
		assert: ('x := 1' asViennaStatementAst
				 parent: spec;
				 yourself) stateDesignator maximalType
		equals: ViennaType int.
	self
		assert: ('(dcl x:real; x := 1)' asViennaStatementAst
				 parent: spec;
				 at: 2) stateDesignator maximalType
		equals: ViennaType real.
	self
		assert: ('let x:nat = 1 in x' asViennaExpressionAst
				 parent: spec;
				 typecheck;
				 expression) maximalType
		equals: ViennaType nat1.
	self
		assert: ('v' asViennaExpressionAst
				 parent: spec;
				 maximalType)
		equals: ViennaType nat1.
	self
		should: [
			'w' asViennaExpressionAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
