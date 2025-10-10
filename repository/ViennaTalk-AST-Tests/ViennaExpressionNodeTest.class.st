Class {
	#name : 'ViennaExpressionNodeTest',
	#superclass : 'TestCase',
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'tests' }
ViennaExpressionNodeTest >> testPurityCheck [

	| spec |
	spec := 'module Test exports all definitions values v = 0; state S of x : nat init s == s = mk_S(0) end operations pure pureOp : () ==> () pureOp() == skip; op : () ==> () op() == skip end Test'
		        asViennaDocumentAst.
	self
		shouldnt: [
				('v + 1' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) purityCheck ]
		raise: ViennaPurityError.
	self
		shouldnt: [
				('x + 1' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) purityCheck ]
		raise: ViennaPurityError.
	self
		shouldnt: [
				('pureOp() + 1' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) purityCheck ]
		raise: ViennaPurityError.
	self
		should: [
				('op() + 1' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) purityCheck ]
		raise: ViennaPurityError.
	self
		shouldnt: [
				('mk_S(1)' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) purityCheck ]
		raise: ViennaPurityError
]

{ #category : 'tests' }
ViennaExpressionNodeTest >> testTransparencyCheck [

	| spec |
	spec := 'module Test exports all definitions values v = 0; state S of x : nat init s == s = mk_S(0) end operations pure pureOp : () ==> () pureOp() == skip; op : () ==> () op() == skip end Test'
		        asViennaDocumentAst.
	self
		shouldnt: [
				('v + 1' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) transparencyCheck ]
		raise: ViennaTransparencyError.
	self
		should: [
				('x + 1' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) transparencyCheck ]
		raise: ViennaTransparencyError.
	self
		should: [
				('pureOp() + 1' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) transparencyCheck ]
		raise: ViennaTransparencyError.
	self
		should: [
				('op() + 1' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) transparencyCheck ]
		raise: ViennaTransparencyError.
	self
		shouldnt: [
				('mk_S(1)' asViennaExpressionAst
					 parent: (spec moduleNamed: 'Test');
					 yourself) transparencyCheck ]
		raise: ViennaTransparencyError
]
