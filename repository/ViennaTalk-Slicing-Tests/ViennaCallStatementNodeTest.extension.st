Extension { #name : 'ViennaCallStatementNodeTest' }

{ #category : '*ViennaTalk-Slicing-Tests' }
ViennaCallStatementNodeTest >> testSliceWith [

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
    op : () ==> ()
    op() == x := y;
    
    op2 : () ==> ()
    op2() == op();
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
	self
		assert: slicer agenda asSet
		equals: { ((ViennaLocalNameNode identifier: 'y')
				 parent: statement;
				 resolve) } asSet
]
