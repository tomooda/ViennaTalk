Class {
	#name : #ViennaNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'ast'
	],
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #running }
ViennaNodeTest >> setUp [
	ast := ViennaVDMParser new parse: 'module A
exports all
definitions
types
	T1 = nat;
	T2 :: f1 : nat
values
	v1 : nat = 1;
	mk_(v2, v3) = mk_(2, 3);
functions
	exp_f : nat -> nat
	exp_f(x) == x + 1;
	
	imp_f(x : nat) res:nat
	pre x < 10
	post res > x;

state S of
	s1 : nat
	s2 : int
	inv mk_S(v1, v2) == v1 <> v2
	init s == s = mk_S(1, 2)
end

operations
	exp_op : nat ==> nat
	exp_op(x1) == (dcl l:nat := 0; skip; return x1 mod 2)
end A'
]

{ #category : #running }
ViennaNodeTest >> testDefinitionOfLocalName [
	| skip |
	skip := ast.
	ast
		allDescendantsDo: [ :n | 
			n label = 'IdentityStatement'
				ifTrue: [ skip := n ] ].
	self assert: (skip definitionOfLocalName: 'nothing') equals: nil.
	self
		assert: (skip definitionOfLocalName: 'x1') parent parent first
		equals: 'exp_op'.
	self assert: (skip definitionOfLocalName: 'x') equals: nil.
	self
		assert: (skip definitionOfLocalName: 'T2') label
		equals: 'RecordTypeDefinition'.
	self
		assert: (skip definitionOfLocalName: 'v2') parent parent label
		equals: 'TuplePattern'.
	self
		assert: (skip definitionOfLocalName: 'exp_f') label
		equals: 'ExplicitFunctionDefinition'.
	self
		assert: (skip definitionOfLocalName: 'imp_f') label
		equals: 'ImplicitFunctionDefinition'.
	self
		assert: (skip definitionOfLocalName: 's1') parent parent label
		equals: 'StateDefinition'.
	self
		assert: (skip definitionOfLocalName: 'l') parent label
		equals: 'DclStatement'.

]
