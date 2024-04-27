"
A ViennaFieldReferenceNodeTest is a test class for testing the behavior of ViennaFieldReferenceNode
"
Class {
	#name : #ViennaFieldReferenceNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaFieldReferenceNodeTest >> testMaximalType [

	| spec |
	spec := 'types R:: f1:nat f2:real state S of x:R init s == s = mk_S(mk_R(1,2.0)) end'
		        asViennaDocumentAst.
	self
		assert: ('x.f2 := 1' asViennaStatementAst
				 parent: spec;
				 stateDesignator) maximalType
		equals: ViennaType real.
	self
		should: [
			('x.f3 := 1' asViennaStatementAst
				 parent: spec;
				 stateDesignator) maximalType ]
		raise: ViennaTypeError
]
