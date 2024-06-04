Class {
	#name : 'ViennaMultipleAssignStatementNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaMultipleAssignStatementNodeTest >> testMaximalType [

	| spec |
	spec := 'state S of x:nat y:[char] end values v:nat1 = 3'
		        asViennaDocumentAst.
	self
		assert: ('atomic(x := 1; y := nil)' asViennaStatementAst
				 parent: spec;
				 maximalType)
		equals: ViennaType unit.
	self
		should: [
			'atomic(x := 1; y := 2)' asViennaStatementAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
