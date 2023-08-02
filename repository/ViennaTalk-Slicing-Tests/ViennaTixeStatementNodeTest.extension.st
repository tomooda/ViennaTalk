Extension { #name : #ViennaTixeStatementNodeTest }

{ #category : #'*ViennaTalk-Slicing-Tests' }
ViennaTixeStatementNodeTest >> testSliceWith [

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
    op() == tixe {p |-> x := p} in exit z;
end A
' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	statement := op statement.
	slicer := ViennaSlicer
		          operation: op
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: (spec moduleNamed: 'A');
				           resolve) }.
	statement sliceWith: slicer.
	self assert: slicer agenda equals: {
			((ViennaLocalNameNode identifier: 'x')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'z')
				 parent: statement;
				 resolve) } asSet
]
