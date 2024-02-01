Class {
	#name : #ViennaInSetNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaInSetNodeTest >> testTypecheck [

	| nil_in_set_xs |
	nil_in_set_xs := 'nil in set xs' asViennaExpressionAst.
	nil_in_set_xs expression2 maximalType: ViennaType nat optional set.
	self
		assert: (nil_in_set_xs typecheck: ViennaType bool)
		equals: ViennaType bool.
	nil_in_set_xs expression2 maximalType: ViennaType nat set.
	self
		should: [ nil_in_set_xs typecheck: ViennaType bool ]
		raise: ViennaTypeError
]
