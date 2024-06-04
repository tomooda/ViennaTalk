"
A ViennaNotInSetNodeTest is a test class for testing the behavior of ViennaNotInSetNode
"
Class {
	#name : 'ViennaNotInSetNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaNotInSetNodeTest >> testMaximalType [

	| nil_in_set_xs |
	nil_in_set_xs := 'nil not in set xs' asViennaExpressionAst.
	nil_in_set_xs expression2 setMaximalType: ViennaType nat optional set.
	self assert: nil_in_set_xs maximalType equals: ViennaType bool.
	nil_in_set_xs expression2 setMaximalType: ViennaType nat set.
	self should: [ nil_in_set_xs maximalType ] raise: ViennaTypeError
]
