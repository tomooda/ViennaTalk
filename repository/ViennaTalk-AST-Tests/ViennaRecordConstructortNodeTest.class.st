Class {
	#name : #ViennaRecordConstructortNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaRecordConstructortNodeTest >> testMaximalType [

	| spec r |
	spec := 'types R :: f1:nat f2:char' asViennaDocumentAst.
	r := (spec resolveIdentifier: 'R') asMaximalViennaType.
	self
		assert: ('mk_R(1, ''a'')' asViennaExpressionAst
				 parent: spec;
				 yourself) maximalType
		equals: r.
	self
		should: [
			('mk_R(''a'', 1)' asViennaExpressionAst
				 parent: spec;
				 yourself) maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			('mk_T(1, ''a'')' asViennaExpressionAst
				 parent: spec;
				 yourself) maximalType ]
		raise: ViennaTypeError
]
