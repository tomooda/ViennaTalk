Extension { #name : 'ViennaWhileStatementNodeTest' }

{ #category : '*ViennaTalk-Slicing-Tests' }
ViennaWhileStatementNodeTest >> testSliceWith [

	| spec op2 statement slicer |
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
    op : () ==> bool
    op() == (x := y; return true);
    
    op2 : () ==> ()
    op2() == while op() do y := z;
end A
' asViennaDocumentAst.
	op2 := (spec moduleNamed: 'A') resolveIdentifier: 'op2'.
	statement := op2 statement.
	slicer := ViennaSlicer
		          toplevelDefinition: op2
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: (spec moduleNamed: 'A');
				           resolve) }.
	statement sliceWith: slicer.
	self assert: slicer agenda equals: {
			((ViennaLocalNameNode identifier: 'y')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'z')
				 parent: statement;
				 resolve) } asSet
]
