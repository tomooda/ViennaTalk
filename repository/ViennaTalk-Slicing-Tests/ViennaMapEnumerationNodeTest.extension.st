Extension { #name : #ViennaMapEnumerationNodeTest }

{ #category : #'*ViennaTalk-Slicing-Tests' }
ViennaMapEnumerationNodeTest >> testSliceWith [

	| spec op statement slicer |
	spec := '
module A
exports all
definitions
state S of
	x : map nat to nat
	y : nat
	z : nat
init s == s = mk_S(0,0,0)
end
operations
	op : () ==> ()
	op() == x := {1 |-> y, z |-> 2}
end A' asViennaDocumentAst.
	op := (spec moduleNamed: 'A') resolveIdentifier: 'op'.
	statement := op statement.
	slicer := ViennaSlicer
		          operation: op
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
