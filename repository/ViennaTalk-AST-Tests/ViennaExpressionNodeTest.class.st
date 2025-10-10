Class {
	#name : 'ViennaExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaExpressionNodeTest >> testIsPureExpression [

	| spec |
	spec := 'module Test exports all definitions values v = 0; state S of x : nat init s == s = mk_S(0) end operations pure pureOp : () ==> () pureOp() == skip; op : () ==> () op() == skip end Test'
		        asViennaDocumentAst.
	self assert: ('v + 1' asViennaExpressionAst
			 parent: (spec moduleNamed: 'Test');
			 yourself) isPureExpression.
	self assert: ('x + 1' asViennaExpressionAst
			 parent: (spec moduleNamed: 'Test');
			 yourself) isPureExpression.
	self assert: ('pureOp() + 1' asViennaExpressionAst
			 parent: (spec moduleNamed: 'Test');
			 yourself) isPureExpression.
	self deny: ('op() + 1' asViennaExpressionAst
			 parent: (spec moduleNamed: 'Test');
			 yourself) isPureExpression
]

{ #category : 'tests' }
ViennaExpressionNodeTest >> testIsTransparentExpression [

	| spec |
	spec := 'module Test exports all definitions values v = 0; state S of x : nat init s == s = mk_S(0) end operations pure pureOp : () ==> () pureOp() == skip; op : () ==> () op() == skip end Test'
		        asViennaDocumentAst.
	self assert: ('v + 1' asViennaExpressionAst
			 parent: (spec moduleNamed: 'Test');
			 yourself) isTransparentExpression.
	self deny: ('x + 1' asViennaExpressionAst
			 parent: (spec moduleNamed: 'Test');
			 yourself) isTransparentExpression.
	self deny: ('pureOp() + 1' asViennaExpressionAst
			 parent: (spec moduleNamed: 'Test');
			 yourself) isTransparentExpression.
	self deny: ('op() + 1' asViennaExpressionAst
			 parent: (spec moduleNamed: 'Test');
			 yourself) isTransparentExpression
]
