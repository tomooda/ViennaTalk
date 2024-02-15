"
A ViennaRecordModifierNodeTest is a test class for testing the behavior of ViennaRecordModifierNode
"
Class {
	#name : #ViennaRecordModifierNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #test }
ViennaRecordModifierNodeTest >> testMaximalType [

	| spec expression r1 r2 |
	spec := 'types R1 :: f1:nat f2:nat; R2:: f1:nat f3:nat'
		        asViennaDocumentAst.
	r1 := (spec resolveIdentifier: 'R1') asMaximalViennaType.
	r2 := (spec resolveIdentifier: 'R2') asMaximalViennaType.
	expression := 'mu(x, f1 |-> 2, f3 |-> 3)' asViennaExpressionAst
		              parent: spec;
		              yourself.
	expression expression maximalType: r1 | r2.
	self assert: expression maximalType equals: r2.
	expression := 'mu(x, f1 |-> 2+nil, f3 |-> 3)' asViennaExpressionAst
		              parent: spec;
		              yourself.
	expression expression maximalType: r1 | r2.
	self should: [ expression maximalType ] raise: ViennaTypeError
]
