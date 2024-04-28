Class {
	#name : #ViennaTypeNameNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaTypeNameNodeTest >> testAsMaximalViennaType [

	self
		assert:
			('types T = nat * int inv mk_(n, i) == n > i; values v : T = mk_(2, 1.2)'
				 asViennaDocumentAst resolveIdentifier: 'v') type
				asMaximalViennaType
		equals: ViennaType nat * ViennaType int
]

{ #category : #tests }
ViennaTypeNameNodeTest >> testMaximalType [

	| spec |
	spec := 'types N = nat' asViennaDocumentAst.
	self
		assert: ('N' asViennaTypeAst
				 parent: spec;
				 maximalType)
		equals: ViennaType nat.
	self
		should: [
			'N2' asViennaTypeAst
				parent: spec;
				maximalType ]
		raise: ViennaTypeError
]
