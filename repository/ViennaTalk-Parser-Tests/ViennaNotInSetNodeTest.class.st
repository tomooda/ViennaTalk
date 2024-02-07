"
A ViennaNotInSetNodeTest is a test class for testing the behavior of ViennaNotInSetNode
"
Class {
	#name : #ViennaNotInSetNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaNotInSetNodeTest >> testTypecheck [

	| nil_in_set_xs |
	nil_in_set_xs := 'nil not in set xs' asViennaExpressionAst.
	nil_in_set_xs expression2 maximalType: ViennaType nat optional set.
	self
		assert: (nil_in_set_xs typecheck: ViennaType bool)
		equals: ViennaType bool.
	nil_in_set_xs expression2 maximalType: ViennaType nat set.
	self
		should: [ nil_in_set_xs typecheck: ViennaType bool ]
		raise: ViennaTypeError
]