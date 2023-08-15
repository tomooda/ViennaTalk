Extension { #name : #ViennaForallExpressionNodeTest }

{ #category : #'*ViennaTalk-Slicing-Tests' }
ViennaForallExpressionNodeTest >> testSliceWith [

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
	op() == if forall a in set {y}, b in set {y} & a + b = z then x := 2;
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
			((ViennaLocalNameNode identifier: 'x')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'y')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'z')
				 parent: statement;
				 resolve) } asSet
]
