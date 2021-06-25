Class {
	#name : #ViennaNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'ast',
		'skip'
	],
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #running }
ViennaNodeTest >> setUp [
	ast := ViennaVDMParser new
		parse:
			'module A
imports from B types Ti renamed Ti operations opi: () ==> () renamed opi; opi2
exports 
	types T1; struct T2
	values v2 : nat
	functions 	exp_f : nat -> nat
	operations exp_op : nat ==> nat
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
	s1 : T1
	s2 : int
	inv mk_S(v1, v2) == v1 <> v2
	init s == s = mk_S(1, 2)
end

operations
	exp_op : nat ==> T2
	exp_op(x1) == (dcl l:nat := 0; skip; exp_op(s1); l := opi(); l := exp_f(l); return v1;B`opi2());
	
	op : nat ==> Ti
	op() == return B`opi2();
end A

module B
exports all
definitions
types 
	Ti = nat
operations 
	opi: () ==> ()
	opi() == return ;

	opi2: () ==> Ti
	opi2() == return 0;
end B'.
	skip := ast.
	ast
		allDescendantsDo: [ :n | 
			n label = 'IdentityStatement'
				ifTrue: [ skip := n ] ]
]

{ #category : #running }
ViennaNodeTest >> testDefinitionOfLocalName [
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
	self
		assert: (skip definitionOfLocalName: 'Ti') label
		equals: 'TypeImport'.
	self
		assert: (skip definitionOfLocalName: 'opi') label
		equals: 'OperationImport'
]

{ #category : #running }
ViennaNodeTest >> testIsExportedNameNode [
	| localName |
	localName := skip parent
		at: 1
		put: (ViennaNode label: 'LocalName' with: '').
	localName at: 1 put: 'T1'.
	self assert: localName isExportedNameNode.
	localName at: 1 put: 'T2'.
	self assert: localName isExportedNameNode.
	localName at: 1 put: 'T3'.
	self deny: localName isExportedNameNode.
	localName at: 1 put: 'v1'.
	self deny: localName isExportedNameNode.
	localName at: 1 put: 'v2'.
	self assert: localName isExportedNameNode.
	localName at: 1 put: 'exp_f'.
	self assert: localName isExportedNameNode.
	localName at: 1 put: 'imp_f'.
	self deny: localName isExportedNameNode.
	localName at: 1 put: 'exp_op'.
	self assert: localName isExportedNameNode.
	localName at: 1 put: 'imp_op'.
	self deny: localName isExportedNameNode
]

{ #category : #running }
ViennaNodeTest >> testIsFunctionNameNode [
	| opcall1 opcall2 funcall |
	self deny: skip isOperationNameNode.
	opcall1 := skip parent at: 3.
	self assert: opcall1 label equals: 'CallStatement'.
	self assert: opcall1 first first equals: 'exp_op'.
	self deny: opcall1 first isFunctionNameNode.
	opcall2 := (skip parent at: 4) second.
	self assert: opcall2 label equals: 'Apply'.
	self assert: opcall2 first first equals: 'opi'.
	self deny: opcall2 first isFunctionNameNode.
	funcall := (skip parent at: 5) second.
	self assert: funcall label equals: 'Apply'.
	self assert: funcall first first equals: 'exp_f'.
	self assert: funcall first isFunctionNameNode
]

{ #category : #running }
ViennaNodeTest >> testIsOperationNameNode [
	| opcall1 opcall2 funcall globalopcall |
	self deny: skip isOperationNameNode.
	opcall1 := skip parent at: 3.
	self assert: opcall1 label equals: 'CallStatement'.
	self assert: opcall1 first first equals: 'exp_op'.
	self deny: opcall1 isOperationNameNode.
	self assert: opcall1 first isOperationNameNode.
	self deny: opcall1 second isOperationNameNode.
	opcall2 := (skip parent at: 4) second.
	self assert: opcall2 label equals: 'Apply'.
	self assert: opcall2 first first equals: 'opi'.
	self deny: opcall2 isOperationNameNode.
	self assert: opcall2 first isOperationNameNode.
	self deny: opcall2 second isOperationNameNode.
	funcall := (skip parent at: 5) second.
	self assert: funcall label equals: 'Apply'.
	self assert: funcall first first equals: 'exp_f'.
	self deny: funcall isOperationNameNode.
	self deny: funcall first isOperationNameNode.
	self deny: funcall second isOperationNameNode.
	globalopcall := skip parent at: 7.
	self assert: globalopcall label equals: 'CallStatement'.
	self assert: globalopcall first label = 'GlobalName'.
	self assert: globalopcall first first = 'B'.
	self assert: globalopcall first second = 'opi2'.
	self assert: globalopcall first isOperationNameNode
]

{ #category : #running }
ViennaNodeTest >> testIsStateVariableNameNode [
	| opcall1 opcall1arg funcall funcallarg returnarg |
	self deny: skip isOperationNameNode.
	opcall1 := skip parent at: 3.
	self assert: opcall1 label equals: 'CallStatement'.
	opcall1arg := opcall1 second first.
	self assert: opcall1arg first equals: 's1'.
	self assert: opcall1arg isStateVariableNameNode.
	funcall := (skip parent at: 5) second.
	self assert: funcall label equals: 'Apply'.
	funcallarg := funcall second first.
	self assert: funcallarg first equals: 'l'.
	self deny: funcallarg isStateVariableNameNode.
	returnarg := (skip parent at: 6) first.
	self assert: returnarg first = 'v1'.
	self deny: returnarg isStateVariableNameNode
]

{ #category : #running }
ViennaNodeTest >> testIsTypeNameNode [
	| localName |
	localName := skip parent
		at: 1
		put: (ViennaNode label: 'LocalName' with: '').
	localName at: 1 put: 'T1'.
	self assert: localName isTypeNameNode.
	localName at: 1 put: 'T2'.
	self assert: localName isTypeNameNode.
	localName at: 1 put: 'Ti'.
	self deny: localName isTypeNameNode.
	localName at: 1 put: 'v1'.
	self deny: localName isTypeNameNode
]

{ #category : #running }
ViennaNodeTest >> testIsValueNameNode [
	| opcall1 opcall1arg funcall funcallarg returnarg |
	self deny: skip isValueNameNode.
	opcall1 := skip parent at: 3.
	self assert: opcall1 label equals: 'CallStatement'.
	opcall1arg := opcall1 second first.
	self assert: opcall1arg first equals: 's1'.
	self deny: opcall1arg isValueNameNode.
	funcall := (skip parent at: 5) second.
	self assert: funcall label equals: 'Apply'.
	funcallarg := funcall second first.
	self assert: funcallarg first equals: 'l'.
	self deny: funcallarg isValueNameNode.
	returnarg := (skip parent at: 6) first.
	self assert: returnarg first = 'v1'.
	self assert: returnarg isValueNameNode
]

{ #category : #running }
ViennaNodeTest >> testSameAs [
	self
		assert:
			('1 + 2 = 3' asViennaExpressionAst
				sameAs: '1+2=3' asViennaExpressionAst).
	self
		deny:
			('1 + 2 = 3' asViennaExpressionAst
				sameAs: '1 + 2 = 4' asViennaExpressionAst)
]
