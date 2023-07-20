Extension { #name : #ViennaAlwaysStatementNodeTest }

{ #category : #'*ViennaTalk-Slicing-Tests' }
ViennaAlwaysStatementNodeTest >> testSliceWith [

	| spec statement slicer |
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
	op() == always x := y in y := z
end A' asViennaDocumentAst.
	statement := ((spec moduleNamed: 'A') resolveIdentifier: 'op')
		             statement.
	slicer := ViennaIntraOperationSlicer withAll:
		          { ((ViennaLocalNameNode identifier: 'x')
			           parent: statement;
			           resolve) }.
	statement sliceWith: slicer.
	self
		assert: slicer agenda asSet
		equals: { ((ViennaLocalNameNode identifier: 'z')
				 parent: statement;
				 resolve) } asSet
]
