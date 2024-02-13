Class {
	#name : #ViennaIsNameExpressionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaIsNameExpressionNodeTest >> testMaximalType [

	| spec expr |
	spec := 'types N = nat' asViennaDocumentAst.
	expr := 'is_N(3.14)' asViennaExpressionAst
		        parent: spec;
		        yourself.
	self assert: expr typecheck equals: ViennaType bool.
	expr := 'is_T(3.14)' asViennaExpressionAst
		        parent: spec;
		        yourself.
	self should: [ expr typecheck ] raise: ViennaTypeError.
	expr := 'is_N(1 and 0)' asViennaExpressionAst
		        parent: spec;
		        yourself.
	self should: [ expr typecheck ] raise: ViennaTypeError
]
