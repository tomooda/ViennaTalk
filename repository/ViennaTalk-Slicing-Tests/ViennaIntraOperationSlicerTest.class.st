Class {
	#name : #ViennaIntraOperationSlicerTest,
	#superclass : #TestCase,
	#instVars : [
		'spec',
		'op',
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
ViennaIntraOperationSlicerTest >> setUp [

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
	op() == x := y
end A' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
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
	slicer := ViennaIntraOperationSlicer new
]

{ #category : #tests }
ViennaIntraOperationSlicerTest >> testAgenda [

	| names |
	names := {
		         x.
		         y } asSet.
	slicer agenda: names.
	self assert: slicer agenda asSet equals: names
]

{ #category : #tests }
ViennaIntraOperationSlicerTest >> testBranch [

	slicer addAgenda: x.
	slicer node: skip1 do: [  ].
	slicer branch
		value: [ :subslicer |
			subslicer node: skip2 do: [
					subslicer
						read: y;
						write: x ] ];
		value: [ :subslicer |
			subslicer node: skip3 do: [
				subslicer
					read: z;
					write: y ] ];
		value: nil.
	self assert: slicer agenda asSet equals: {
			x.
			y } asSet
]

{ #category : #tests }
ViennaIntraOperationSlicerTest >> testCall [

	slicer addAgenda: x.
	slicer node: skip1 do: [
		slicer call: ((ViennaApplyNode
				  expression: ((ViennaLocalNameNode identifier: 'op')
						   parent: op;
						   yourself)
				  argumentExpressionList: ViennaExpressionListNode empty)
				 parent: op;
				 yourself) ].
	self assert: slicer agenda asSet equals: { y } asSet
]

{ #category : #tests }
ViennaIntraOperationSlicerTest >> testContinue [

	slicer agenda: { x }.
	slicer read: y.
	slicer write: z.
	slicer continue: (slicer subslicer
			 agenda: { y };
			 read: x;
			 write: z;
			 yourself).
	self assert: slicer agenda asSet equals: { y } asSet.
	self assert: slicer reads asSet equals: { y } asSet.
	self assert: slicer writes asSet equals: { z } asSet
]

{ #category : #tests }
ViennaIntraOperationSlicerTest >> testPostCopy [

	| copy |
	slicer
		addAgenda: x;
		read: y;
		write: z.
	self assert: slicer agenda equals: { x }.
	self assert: slicer reads equals: { y }.
	self assert: slicer writes equals: { z }.
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
ViennaIntraOperationSlicerTest >> testRead [

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
ViennaIntraOperationSlicerTest >> testSubslicer [

	| subslicer |
	slicer
		addAgenda: x;
		read: y;
		write: z.
	self assert: slicer agenda equals: { x }.
	self assert: slicer reads equals: { y }.
	self assert: slicer writes equals: { z }.
	subslicer := slicer subslicer.
	self assert: subslicer agenda asSet equals: slicer agenda asSet.
	self assertEmpty: subslicer reads.
	self assertEmpty: subslicer writes
]

{ #category : #tests }
ViennaIntraOperationSlicerTest >> testWithAll [

	| names |
	names := {
		         x.
		         y } asSet.
	slicer := ViennaIntraOperationSlicer withAll: names.
	self assert: slicer agenda asSet equals: names
]

{ #category : #tests }
ViennaIntraOperationSlicerTest >> testWrite [

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
