Extension { #name : 'ViennaUndefinedExpressionNodeTest' }

{ #category : '*ViennaTalk-Slicing-Tests' }
ViennaUndefinedExpressionNodeTest >> testSliceWith [

	| spec op statement slicer |
	spec := '
module A
exports all
definitions
state S of
	x : nat
	y : nat
	z : nat
init s == s = mk_S(0,0,0)
end
operations
	op : () ==> nat
	op() == x := undefined;
end A' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	statement := op statement.
	slicer := ViennaSlicer
		          toplevelDefinition: op
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: statement;
				           resolve) }.
	statement sliceWith: slicer.
	self assert: slicer agenda asSet equals: {  } asSet
]
