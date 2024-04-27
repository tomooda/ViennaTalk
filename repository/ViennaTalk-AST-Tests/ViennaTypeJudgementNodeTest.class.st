Class {
	#name : #ViennaTypeJudgementNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #test }
ViennaTypeJudgementNodeTest >> testMaximalType [

	| spec |
	spec := 'types N1 = nat1' asViennaDocumentAst.
	self
		assert: ('is_(1, N1)' asViennaExpressionAst
				 parent: spec;
				 maximalType)
		equals: ViennaType bool.
	self
		should: [
			'is_(1, N)' asViennaExpressionAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError.
	self
		should: [
			'is_(1+nil, N1)' asViennaExpressionAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
