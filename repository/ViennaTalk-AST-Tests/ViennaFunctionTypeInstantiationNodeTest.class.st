Class {
	#name : #ViennaFunctionTypeInstantiationNodeTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-AST-Tests'
}

{ #category : #tests }
ViennaFunctionTypeInstantiationNodeTest >> testMaximalType [

	| spec expression |
	spec := 'functions f[@T]: @T -> real f(x) == x' asViennaDocumentAst.
	expression := 'f[nat]' asViennaExpressionAst
		              parent: spec;
		              yourself.
	self
		assert: expression maximalType
		equals: ViennaType nat -> ViennaType real.
	spec := 'functions f[@T1, @T2, @T3]: @T1 -> @T2 * @T3 * char f(x) == mk_(x, mk_token(0), ''1'')'
		        asViennaDocumentAst.
	expression := 'f[nat, real, token]' asViennaExpressionAst
		              parent: spec;
		              yourself.
	self assert: expression maximalType equals: ViennaType nat
		-> (ViennaType real * ViennaType token * ViennaType char)
]
