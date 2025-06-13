Extension { #name : 'ViennaApplyNodeTest' }

{ #category : '*ViennaTalk-Slicing-Tests' }
ViennaApplyNodeTest >> testSliceWith [

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
functions
	f : nat -> nat
	f(a) == a + 1;
operations
	op : () ==> nat
	op() == x := op2();
	op2: () ==> nat
	op2() == (y := z; return f(z));	
end A' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	statement := op statement.
	slicer := ViennaSlicer
		          toplevelDefinition: op
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: statement;
				           resolve) }.
	statement sliceWith: slicer.
	self
		assert: slicer agenda asSet
		equals: { ((ViennaLocalNameNode identifier: 'z')
				 parent: statement;
				 resolve) } asSet
]
