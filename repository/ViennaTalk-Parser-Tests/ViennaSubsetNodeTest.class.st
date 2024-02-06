Class {
	#name : #ViennaSubsetNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaSubsetNodeTest >> testTypecheck [

	| expr |
	expr := 's1 subset s2' asViennaExpressionAst.
	expr expression1 maximalType: ViennaType nat set.
	expr expression2 maximalType: ViennaType nat set.
	self
		assert: (expr typecheck: ViennaType bool)
		equals: ViennaType bool.

	expr expression1 maximalType: ViennaType nat optional set.
	expr expression2 maximalType: ViennaType char optional set.
	self
		assert: (expr typecheck: ViennaType bool)
		equals: ViennaType bool.

	expr expression1 maximalType: ViennaType nat set.
	expr expression2 maximalType: ViennaType char set.
	self
		should: [ expr typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
