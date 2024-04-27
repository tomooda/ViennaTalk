Class {
	#name : #ViennaCompositeTypeNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaCompositeTypeNodeTest >> testAsMaximalViennaType [

	self
		assert: 'compose T of f1:nat f2:-nat1 int end' asViennaTypeAst
				asMaximalViennaType
		equals: (ViennaType compose: 'T' of: {
					 {
						 'f1'.
						 false.
						 ViennaType nat }.
					 {
						 'f2'.
						 true.
						 ViennaType nat1 }.
					 {
						 nil.
						 false.
						 ViennaType int } })
]
