Extension { #name : 'ViennaPreconditionExpressionNodeTest' }

{ #category : '*ViennaTalk-Slicing-Tests' }
ViennaPreconditionExpressionNodeTest >> testSliceWith [

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
	f(a) == a;

operations
	op : () ==> ()
	op() == if pre_(f, y) then x := 2;
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
			((ViennaLocalNameNode identifier: 'f')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'x')
				 parent: statement;
				 resolve).
			((ViennaLocalNameNode identifier: 'y')
				 parent: statement;
				 resolve) } asSet
]
