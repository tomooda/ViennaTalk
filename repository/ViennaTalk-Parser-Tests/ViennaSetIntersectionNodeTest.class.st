Class {
	#name : #ViennaSetIntersectionNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSetIntersectionNodeTest >> testTypecheck [

	| expr |
	expr := 's1 inter s2' asViennaExpressionAst.
	expr expression1 maximalType: ViennaType nat set.
	expr expression2 maximalType: ViennaType nat set.
	self
		assert: (expr typecheck: ViennaType nat set)
		equals: ViennaType nat set.

	expr expression1 maximalType: ViennaType nat optional set.
	expr expression2 maximalType: ViennaType char optional set.
	self
		assert: (expr typecheck: ViennaType nat optional set)
		equals: ViennaType nat optional set.

	expr expression1 maximalType: ViennaType nat optional set.
	expr expression2 maximalType: ViennaType nat set.
	self
		assert: (expr typecheck: ViennaType nat set)
		equals: ViennaType nat set.

	expr expression1 maximalType: ViennaType nat set.
	expr expression2 maximalType: ViennaType char set.
	self
		should: [ expr typecheck: ViennaType bool ]
		raise: ViennaTypeError
]