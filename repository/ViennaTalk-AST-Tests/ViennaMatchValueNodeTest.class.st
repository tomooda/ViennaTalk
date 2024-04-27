"
A ViennaMatchValueNodeTest is a test class for testing the behavior of ViennaMatchValueNode
"
Class {
	#name : #ViennaMatchValueNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaMatchValueNodeTest >> testMaximalType [

	| matchValue |
	matchValue := ViennaMatchValueNode expression:
		              '1' asViennaExpressionAst.
	self assert: matchValue maximalType equals: ViennaType nat1.
	matchValue maximalType: ViennaType real.
	self assert: matchValue maximalType equals: ViennaType nat1
]
