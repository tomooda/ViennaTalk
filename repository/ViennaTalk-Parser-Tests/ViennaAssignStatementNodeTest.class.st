Class {
	#name : #ViennaAssignStatementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaAssignStatementNodeTest >> testMaximalType [

	| spec |
	spec := 'state S of x:nat end values v:nat1 = 3' asViennaDocumentAst.
	self
		assert: ('x := 1' asViennaStatementAst
				 parent: spec;
				 maximalType)
		equals: ViennaType unit.
	self
		assert: ('x := 3.0' asViennaStatementAst
				 parent: spec;
				 maximalType)
		equals: ViennaType unit.
	self
		should: [
			'x.f := nil' asViennaStatementAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'x := nil' asViennaStatementAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'v := 3' asViennaStatementAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
