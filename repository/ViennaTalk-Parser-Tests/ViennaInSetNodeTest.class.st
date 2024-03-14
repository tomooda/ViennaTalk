Class {
	#name : #ViennaInSetNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #tests }
ViennaInSetNodeTest >> testMaximalType [

	| nil_in_set_xs |
	nil_in_set_xs := 'nil in set xs' asViennaExpressionAst.
	nil_in_set_xs expression2 setMaximalType: ViennaType nat optional set.
	self assert: nil_in_set_xs maximalType equals: ViennaType bool.
	nil_in_set_xs expression2 setMaximalType: ViennaType nat set.
	self should: [ nil_in_set_xs maximalType ] raise: ViennaTypeError
]
