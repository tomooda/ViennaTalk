Class {
	#name : 'ViennaNondeterministicStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaNondeterministicStatementNodeTest >> testMaximalType [

	| spec |
	spec := 'state S of x:nat y:[char] end values v:nat1 = 3'
		        asViennaDocumentAst.
	self
		assert: ('||(x := 1, y := nil, skip)' asViennaStatementAst
				 parent: spec;
				 maximalType)
		equals: ViennaType unit.
	self
		should: [
			'||(x := 1, y := 2, skip)' asViennaStatementAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
