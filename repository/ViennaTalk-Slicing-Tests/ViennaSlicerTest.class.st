Class {
	#name : #ViennaSlicerTest,
	#superclass : #TestCase,
	#instVars : [
		'spec',
		'op',
		'op2',
		'x',
		'y',
		'z',
		'skip1',
		'skip2',
		'skip3',
		'slicer'
	],
	#category : #'ViennaTalk-Slicing-Tests'
}

{ #category : #tests }
ViennaSlicerTest >> setUp [

	spec := '
module A
exports all
definitions
state S of
	x : nat
	y : nat
	z : nat
init s == s = mk_S(0, 0, 0)
end
operations
	op : () ==> ()
	op() == x := y;
	
	op2 : () ==> ()
	op2() == skip;
end A' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	op2 := (spec moduleNamed: 'A') resolveIdentifier: 'op2'.
	x := 'x' asViennaExpressionAst
		     parent: op;
		     resolve.
	y := 'y' asViennaExpressionAst
		     parent: op;
		     resolve.
	z := 'z' asViennaExpressionAst
		     parent: op;
		     resolve.
	skip1 := 'skip' asViennaStatementAst
		         parent: op;
		         yourself.
	skip2 := 'skip' asViennaStatementAst
		         parent: op;
		         yourself.
	skip3 := 'skip' asViennaStatementAst
		         parent: op;
		         yourself.
	slicer := ViennaSlicer new
]

{ #category : #tests }
ViennaSlicerTest >> testAgenda [

	| names |
	names := {
		         x.
		         y } asSet.
	slicer criteria: names.
	self assert: slicer agenda asSet equals: names
]

{ #category : #tests }
ViennaSlicerTest >> testBranch [

	slicer addCriterion: x.
	slicer onNode: skip1 do: [  ].
	slicer branch
		value: [ :subslicer |
			subslicer onNode: skip2 do: [
					subslicer
						read: y;
						write: x ] ];
		value: [ :subslicer |
			subslicer onNode: skip3 do: [
				subslicer
					read: z;
					write: y ] ];
		value: nil.
	self assert: slicer agenda asSet equals: {
			x.
			y } asSet
]

{ #category : #tests }
ViennaSlicerTest >> testCall [

	slicer operation: op2.
	slicer criteria: { x }.
	slicer call: ('op' asViennaExpressionAst
			 parent: op2 statement;
			 yourself).
	self assert: slicer agenda asSet equals: { y } asSet
]

{ #category : #tests }
ViennaSlicerTest >> testContinue [

	slicer criteria: { x }.
	slicer read: y.
	slicer write: z.
	slicer continue: (slicer copy
			 agenda: { y };
			 read: x;
			 write: z;
			 yourself).
	self assert: slicer agenda asSet equals: { y } asSet.
	self assert: slicer reads asSet equals: {
			x.
			y } asSet.
	self assert: slicer writes asSet equals: { z } asSet
]

{ #category : #tests }
ViennaSlicerTest >> testCriteria [

	| names |
	names := {
		         x.
		         y } asSet.
	slicer criteria: names.
	self assert: slicer criteria asSet equals: names
]

{ #category : #tests }
ViennaSlicerTest >> testCut [

	op statement: 'if z = 0 then op2() else x := y' asViennaStatementAst.
	op2 statement: 'if z <> 0 then op() else y := z' asViennaStatementAst.
	slicer operation: op2.
	slicer criteria: { x }.
	slicer cut.
	self assert: slicer agenda equals: {
			x.
			y.
			z } asSet
]

{ #category : #tests }
ViennaSlicerTest >> testPostCopy [

	| copy |
	slicer
		addCriterion: x;
		read: y;
		write: z.
	self assert: slicer agenda equals: { x } asIdentitySet.
	self assert: slicer reads equals: { y } asIdentitySet.
	self assert: slicer writes equals: { z } asIdentitySet.
	copy := slicer copy.
	self
		assert: (copy instVarNamed: 'agenda')
		equals: (slicer instVarNamed: 'agenda').
	self
		deny: (copy instVarNamed: 'agenda')
		identicalTo: (slicer instVarNamed: 'agenda').
	self
		assert: (copy instVarNamed: 'reads')
		equals: (slicer instVarNamed: 'reads').
	self
		deny: (copy instVarNamed: 'reads')
		identicalTo: (slicer instVarNamed: 'reads').
	self
		assert: (copy instVarNamed: 'writes')
		equals: (slicer instVarNamed: 'writes').
	self
		deny: (copy instVarNamed: 'writes')
		identicalTo: (slicer instVarNamed: 'writes')
]

{ #category : #tests }
ViennaSlicerTest >> testRead [

	| let a block b |
	slicer read: x.
	self assert: (slicer reads includes: x).
	let := 'let a = 1 in a' asViennaExpressionAst
		       parent: op;
		       yourself.
	a := let expression.
	slicer read: a.
	self assert: (slicer reads includes: a resolve).
	block := '(dcl b:nat := 1; return b)' asViennaStatementAst
		         parent: op;
		         yourself.
	b := block last expression.
	slicer read: b.
	self assert: (slicer reads includes: b resolve)
]

{ #category : #tests }
ViennaSlicerTest >> testSlice [

	op statement:
		'if z = 0 then (z := y; op2()) else x := y' asViennaStatementAst.
	op2 statement: 'if z <> 0 then op()' asViennaStatementAst.
	slicer operation: op2.
	slicer criteria: { x }.
	slicer slice.
	self assert: slicer agenda asSet equals: {
			x.
			y.
			z } asSet
]

{ #category : #tests }
ViennaSlicerTest >> testStartNode [

	op statement:
		'(if z = 0 then x := 1; y := x + 1; op2())' asViennaStatementAst.
	op2 statement: 'x := z' asViennaStatementAst.
	slicer operation: op.
	slicer criteria: { x }.
	slicer slice.
	self assert: slicer agenda asSet equals: { z } asSet.
	slicer := ViennaSlicer new.
	slicer operation: op.
	slicer criteria: { x }.
	slicer startNode: (op statement at: 2).
	slicer slice.
	self assert: slicer agenda asSet equals: {
			x.
			z } asSet
]

{ #category : #tests }
ViennaSlicerTest >> testWrite [

	| let a block b |
	slicer write: x.
	self assert: (slicer writes includes: x).
	let := 'let a = 1 in a' asViennaExpressionAst
		       parent: op;
		       yourself.
	a := let expression.
	slicer write: a.
	self assert: (slicer writes includes: a resolve).
	block := '(dcl b:nat := 1; return b)' asViennaStatementAst
		         parent: op;
		         yourself.
	b := block last expression.
	slicer write: b.
	self assert: (slicer writes includes: b resolve)
]
