Extension { #name : 'ViennaReturnStatementNodeTest' }

{ #category : '*ViennaTalk-Slicing-Tests' }
ViennaReturnStatementNodeTest >> testSliceWith [

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
	op : () ==> ()
	op() == (if z > 0 then (x := y; return); x := z)
end A' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	statement := op statement.
	slicer := ViennaSlicer
		          toplevelDefinition: op
		          criteria: { ((ViennaLocalNameNode identifier: 'x')
				           parent: statement;
				           resolve) }.
	statement sliceWith: slicer.
	self assert: slicer agenda asSet equals: {
			((ViennaLocalNameNode identifier: 'y')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'z')
				 parent: statement;
				 resolve) } asSet
]
