Extension { #name : 'ViennaIndexForLoopNodeTest' }

{ #category : '*ViennaTalk-Slicing-Tests' }
ViennaIndexForLoopNodeTest >> testSliceWith [

	| spec op op2 statement slicer |
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
    op() == for i = y to z do x := x + i;
    op2 : () ==> ()
    op2() == for i = y to z do y := x + i;
end A
' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	statement := op statement.
	slicer := ViennaSlicer
		          toplevelDefinition: op
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: (spec moduleNamed: 'A');
				           resolve) }.
	statement sliceWith: slicer.
	self assert: slicer agenda equals: {
			((ViennaLocalNameNode identifier: 'x')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'y')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'z')
				 parent: statement;
				 resolve) } asSet.
	op2 := (spec moduleNamed: 'A') resolveIdentifier: 'op2'.
	statement := op2 statement.
	slicer := ViennaSlicer
		          toplevelDefinition: op2
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: (spec moduleNamed: 'A');
				           resolve) }.
	statement sliceWith: slicer.
	self
		assert: slicer agenda
		equals: { ((ViennaLocalNameNode identifier: 'x')
				 parent: statement;
				 resolve) } asSet
]
