Class {
	#name : 'ViennaNodeTest',
	#superclass : 'TestCase',
	#instVars : [
		'ast',
		'skip'
	],
	#category : 'ViennaTalk-AST-Tests',
	#package : 'ViennaTalk-AST-Tests'
}

{ #category : 'running' }
ViennaNodeTest >> setUp [

	ast := ViennaVDMParser current parse: 'module A
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
	ast allDescendantsDo: [ :n |
		n isViennaIdentityStatementNode ifTrue: [ skip := n ] ]
]

{ #category : 'running' }
ViennaNodeTest >> testAsGlobalName [

	| localName globalName |
	localName := [ :name |
	             (ViennaLocalNameNode identifier: name) parent: skip ].
	globalName := [ :module :name |
	              ViennaGlobalNameNode
		              moduleIdentifier: module
		              identifier: name ].
	self assert: (localName value: 'nothing') asGlobalName equals: nil.
	self assert: (localName value: 'x1') asGlobalName equals: nil.
	self assert: (localName value: 'x') asGlobalName equals: nil.
	self
		assert: (localName value: 'T2') asGlobalName
		equals: (globalName value: 'A' value: 'T2').
	self
		assert: (localName value: 'v2') asGlobalName
		equals: (globalName value: 'A' value: 'v2').
	self
		assert: (localName value: 'exp_f') asGlobalName
		equals: (globalName value: 'A' value: 'exp_f').
	self
		assert: (localName value: 'imp_f') asGlobalName
		equals: (globalName value: 'A' value: 'imp_f').
	self assert: (localName value: 's1') asGlobalName equals: nil.
	self assert: (localName value: 'l') asGlobalName equals: nil.
	self
		assert: (localName value: 'Ti') asGlobalName
		equals: (globalName value: 'B' value: 'Ti').
	self
		assert: (localName value: 'opi') asGlobalName
		equals: (globalName value: 'B' value: 'opi')
]

{ #category : 'running' }
ViennaNodeTest >> testCopyFragment [

	| op1 op2 |
	op1 := skip
		       detectParent: #isViennaExplicitOperationDefinitionNode
		       ifNone: [ nil ].
	op2 := op1 copyFragment.
	self assert: op2 parent isNil.
	self assert: op1 equals: op2.
	self deny: op1 identicalTo: op2
]

{ #category : 'running' }
ViennaNodeTest >> testCopyWhole [

	| op1 op2 |
	op1 := skip
		       detectParent: #isViennaExplicitOperationDefinitionNode
		       ifNone: [ nil ].
	op2 := op1 copyWhole.
	self assert: op1 equals: op2.
	self deny: op1 identicalTo: op2.
	self assert: op1 root equals: op2 root.
	self deny: op1 root identicalTo: op2 root
]

{ #category : 'running' }
ViennaNodeTest >> testDefinitionOfLocalName [

	self assert: (skip definitionOfLocalName: 'nothing') isNil.
	self
		assert: (skip definitionOfLocalName: 'x1') parent parent identifier
		equals: 'exp_op'.
	self assert: (skip definitionOfLocalName: 'x') isNil.
	self assert:
		(skip definitionOfLocalName: 'T2') isViennaRecordTypeDefinitionNode.
	self assert: (skip definitionOfLocalName: 'v2') parent parent
			isViennaTuplePatternNode.
	self assert: (skip definitionOfLocalName: 'exp_f')
			isViennaExplicitFunctionDefinitionNode.
	self assert: (skip definitionOfLocalName: 'imp_f')
			isViennaImplicitFunctionDefinitionNode.
	self assert: (skip definitionOfLocalName: 's1') parent parent
			isViennaStateDefinitionNode.
	self assert:
		(skip definitionOfLocalName: 'l') parent isViennaDclStatementNode.
	self assert:
		(skip definitionOfLocalName: 'Ti') isViennaTypeImportNode.
	self assert:
		(skip definitionOfLocalName: 'opi') isViennaOperationImportNode
]

{ #category : 'running' }
ViennaNodeTest >> testEquals [

	self
		assert: '1 + 2 = 3' asViennaExpressionAst
		equals: '1+2=3' asViennaExpressionAst.
	self
		deny: '1 + 2 = 3' asViennaExpressionAst
		equals: '1 + 2 = 4' asViennaExpressionAst
]

{ #category : 'running' }
ViennaNodeTest >> testIsExportedNameNode [

	| localName |
	localName := skip parent
		             at: 1
		             put: (ViennaLocalNameNode identifier: '').
	localName identifier: 'T1'.
	self assert: localName isExportedNameNode.
	localName identifier: 'T2'.
	self assert: localName isExportedNameNode.
	localName identifier: 'T3'.
	self deny: localName isExportedNameNode.
	localName identifier: 'v1'.
	self deny: localName isExportedNameNode.
	localName identifier: 'v2'.
	self assert: localName isExportedNameNode.
	localName identifier: 'exp_f'.
	self assert: localName isExportedNameNode.
	localName identifier: 'imp_f'.
	self deny: localName isExportedNameNode.
	localName identifier: 'exp_op'.
	self assert: localName isExportedNameNode.
	localName identifier: 'imp_op'.
	self deny: localName isExportedNameNode
]

{ #category : 'running' }
ViennaNodeTest >> testIsFunctionNameNode [

	| opcall1 opcall2 funcall |
	self deny: skip isOperationNameNode.
	opcall1 := skip parent at: 3.
	self assert: opcall1 isViennaCallStatementNode.
	self assert: opcall1 name identifier equals: 'exp_op'.
	self deny: opcall1 name isFunctionNameNode.
	opcall2 := (skip parent at: 4) second.
	self assert: opcall2 isViennaApplyNode.
	self assert: opcall2 expression identifier equals: 'opi'.
	self deny: opcall2 expression isFunctionNameNode.
	funcall := (skip parent at: 5) second.
	self assert: funcall isViennaApplyNode.
	self assert: funcall expression identifier equals: 'exp_f'.
	self assert: funcall expression isFunctionNameNode
]

{ #category : 'running' }
ViennaNodeTest >> testIsOperationNameNode [

	| opcall1 opcall2 funcall globalopcall |
	self deny: skip isOperationNameNode.
	opcall1 := skip parent at: 3.
	self assert: opcall1 isViennaCallStatementNode.
	self assert: opcall1 first first equals: 'exp_op'.
	self deny: opcall1 isOperationNameNode.
	self assert: opcall1 first isOperationNameNode.
	self deny: opcall1 second isOperationNameNode.
	opcall2 := (skip parent at: 4) second.
	self assert: opcall2 isViennaApplyNode.
	self assert: opcall2 expression first equals: 'opi'.
	self deny: opcall2 isOperationNameNode.
	self assert: opcall2 expression isOperationNameNode.
	self deny: opcall2 argumentExpressionList isOperationNameNode.
	funcall := (skip parent at: 5) second.
	self assert: funcall isViennaApplyNode.
	self assert: funcall expression first equals: 'exp_f'.
	self deny: funcall isOperationNameNode.
	self deny: funcall expression isOperationNameNode.
	self deny: funcall argumentExpressionList isOperationNameNode.
	globalopcall := skip parent at: 7.
	self assert: globalopcall isViennaCallStatementNode.
	self assert: globalopcall first isViennaGlobalNameNode.
	self assert: globalopcall first first = 'B'.
	self assert: globalopcall first second = 'opi2'.
	self assert: globalopcall first isOperationNameNode
]

{ #category : 'running' }
ViennaNodeTest >> testIsStateVariableNameNode [

	| opcall1 opcall1arg funcall funcallarg returnarg |
	self deny: skip isOperationNameNode.
	opcall1 := skip parent at: 3.
	self assert: opcall1 isViennaCallStatementNode.
	opcall1arg := opcall1 second first.
	self assert: opcall1arg first equals: 's1'.
	self assert: opcall1arg isStateVariableNameNode.
	funcall := (skip parent at: 5) second.
	self assert: funcall isViennaApplyNode.
	funcallarg := funcall argumentExpressionList first.
	self assert: funcallarg first equals: 'l'.
	self deny: funcallarg isStateVariableNameNode.
	returnarg := (skip parent at: 6) first.
	self assert: returnarg first = 'v1'.
	self deny: returnarg isStateVariableNameNode
]

{ #category : 'running' }
ViennaNodeTest >> testIsTypeNameNode [

	| localName |
	localName := skip parent
		             at: 1
		             put: (ViennaLocalNameNode identifier: '').
	localName at: 1 put: 'T1'.
	self assert: localName isTypeNameNode.
	localName identifier: 'T2'.
	self assert: localName isTypeNameNode.
	localName identifier: 'Ti'.
	self assert: localName isTypeNameNode.
	localName identifier: 'v1'.
	self deny: localName isTypeNameNode
]

{ #category : 'running' }
ViennaNodeTest >> testIsValueNameNode [

	| opcall1 opcall1arg funcall funcallarg returnarg |
	self deny: skip isValueNameNode.
	opcall1 := skip parent at: 3.
	self assert: opcall1 isViennaCallStatementNode.
	opcall1arg := opcall1 second first.
	self assert: opcall1arg first equals: 's1'.
	self deny: opcall1arg isValueNameNode.
	funcall := (skip parent at: 5) second.
	self assert: funcall isViennaApplyNode.
	funcallarg := funcall argumentExpressionList first.
	self assert: funcallarg first equals: 'l'.
	self deny: funcallarg isValueNameNode.
	returnarg := (skip parent at: 6) first.
	self assert: returnarg first = 'v1'.
	self assert: returnarg isValueNameNode
]
