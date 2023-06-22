Class {
	#name : #ViennaResolverTest,
	#superclass : #TestCase,
	#instVars : [
		'modularDocument',
		'flatDocument'
	],
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #utilities }
ViennaResolverTest >> f [

	flatDocument
		allDescendantsSuchThat: #isViennaExplicitFunctionDefinitionNode
		do: [ :n | ^ n ]
]

{ #category : #utilities }
ViennaResolverTest >> moduleA [
	^ modularDocument moduleNamed: 'A'
]

{ #category : #utilities }
ViennaResolverTest >> moduleB [

	^ modularDocument moduleNamed: 'B'
]

{ #category : #utilities }
ViennaResolverTest >> o [

	flatDocument
		allDescendantsSuchThat: #isViennaExplicitOperationDefinitionNode
		do: [ :n | ^ n ]
]

{ #category : #running }
ViennaResolverTest >> setUp [

	modularDocument := ViennaVDMParser new document parse: '
module A
imports from B types tb renamed tb1; values vb:t renamed vb1; functions fb:nat->nat renamed fb1; operations ob:()==>() renamed ob1
exports all
definitions
types
	t = nat
values
	v = 1
functions
	f : nat -> nat
	f(x) == x
state Sa of
	a : nat
init s == s = mk_Sa(0)
end
operations
	o:() ==> ()
	o() == skip;
end A
module B
exports all
definitions
types
	tb = nat
values
	vb = 1
functions
	fb : nat -> nat
	fb(x) == x
operations
	ob : () ==> ()
	ob() == skip
end B
' trim.
	flatDocument := ViennaVDMParser new document parse: '
types
	t = nat
values
	v = 1
functions
	f : nat -> nat
	f(x) == x
state Sa of
	a : nat
init s == s = mk_Sa(0)
end
operations
	o: nat ==> ()
	o(x) == return x;
' trim
]

{ #category : #utilities }
ViennaResolverTest >> t [

	flatDocument
		allDescendantsSuchThat: #isViennaTypeSynonymNode
		do: [ :n | ^ n ]
]

{ #category : #'tests-statements' }
ViennaResolverTest >> testBlockStatement [

	| node |
	node := ViennaVDMParser new statement parse:
		        '(dcl x:nat := 0; return x)'.
	self assert: (node second findResolverForIdentifier: 'x') identicalTo: node
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testCasesExpression [

	| node |
	node := ViennaVDMParser new casesExpressionAlternative parse:
		        'x -> nil'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolverTest >> testCasesStatement [

	| node |
	node := ViennaVDMParser new casesStatementAlternative parse:
		        'x -> skip'.
	self
		assert: (node statement findResolverForIdentifier: 'x')
		identicalTo: node
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveImportedFunction [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'fb1'.
	self assert: node identicalTo: self moduleB
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveImportedOperation [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'ob1'.
	self assert: node identicalTo: self moduleB
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveImportedType [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'tb1'.
	self assert: node identicalTo: self moduleB
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveImportedValue [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'vb1'.
	self assert: node identicalTo: self moduleB
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveLocalFunction [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'f'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveLocalFunctionParameter [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveLocalOperation [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'o'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveLocalStateVariable [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'a'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveLocalType [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 't'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testDeepResolveLocalValue [

	| node |
	node := self moduleA deepFindResolverForIdentifier: 'v'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testExists1Expression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'exists1 x in set xs & x < 10'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testExistsExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'exists x, y in set s & x + y = z'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-toplevel definitions' }
ViennaResolverTest >> testExplicitFunctionDefinition [

	| node |
	node := self f.
	self assert: node identifier equals: 'f'.
	self assert: (node parametersList bindsIdentifier: 'x').
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node
]

{ #category : #'tests-toplevel definitions' }
ViennaResolverTest >> testExplicitOperationDefinition [

	| node |
	node := self o.
	self assert: node identifier equals: 'o'.
	self assert: (node parameters bindsIdentifier: 'x').
	self
		assert: (node statement findResolverForIdentifier: 'x')
		identicalTo: node
]

{ #category : #'tests-toplevel definitions' }
ViennaResolverTest >> testExtendedExplicitFunctionDefinition [

	| node |
	node := ViennaVDMParser new extendedExplicitFunctionDefinition end
		        parse: 'f[@T] (x:@T) res:@T == x post res = x'.
	self assert: (node type findResolverForIdentifier: '@T') identicalTo: node.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self assert: (node post findResolverForIdentifier: 'res') identicalTo: node
]

{ #category : #'tests-toplevel definitions' }
ViennaResolverTest >> testExtendedExplicitOperationDefinition [

	| node |
	node := ViennaVDMParser new extendedExplicitOperationDefinition end
		        parse: 'o (x:T) res:T == return x post res = x'.
	self
		assert: (node statement expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self assert: (node post findResolverForIdentifier: 'res') identicalTo: node
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testForallExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'forall x, y in set s & x + y = z'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-toplevel definitions' }
ViennaResolverTest >> testImplicitFunctionDefinition [

	| node |
	node := ViennaVDMParser new implicitFunctionDefinition end parse:
		        'f[@T] (x:@T) res:@T post res = x'.
	self assert: (node type findResolverForIdentifier: '@T') identicalTo: node.
	self assert: (node post findResolverForIdentifier: 'x') identicalTo: node.
	self assert: (node post findResolverForIdentifier: 'res') identicalTo: node
]

{ #category : #'tests-toplevel definitions' }
ViennaResolverTest >> testImplicitOperationDefinition [

	| node |
	node := ViennaVDMParser new implicitOperationDefinition end parse:
		        'o (x:T) res:T ext rd a:T post res = x'.
	self assert: (node post findResolverForIdentifier: 'x') identicalTo: node.
	self assert: (node post findResolverForIdentifier: 'res') identicalTo: node.
	self assert: (node post findResolverForIdentifier: 'a') isNil
]

{ #category : #'tests-statements' }
ViennaResolverTest >> testIndexForLoop [

	| node |
	node := ViennaVDMParser new statement parse:
		        'for i = 1 to 10 by 2 do skip'.
	self
		assert: (node statement findResolverForIdentifier: 'i')
		identicalTo: node
]

{ #category : #'tests-others' }
ViennaResolverTest >> testInvariant [

	| node |
	node := ViennaVDMParser new invariantInitialFunction end parse:
		        'mk_(x, y) == x = y'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression findResolverForIdentifier: 'y')
		identicalTo: node
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testIotaExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'iota x in set xs & x < 10'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testLambdaExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'lambda x:nat, y:nat & x + y'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testLetBeExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'let x, y in set s be st x = y in x + y'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolverTest >> testLetBeStatement [

	| node |
	node := ViennaVDMParser new statement parse:
		        'let x, y in set s be st x = y in z := x + y'.
	self
		assert: (node statement findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node statement findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node statement findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testLetExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'let mk_(x, y) = z in x + y'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolverTest >> testLetStatement [

	| node |
	node := ViennaVDMParser new statement parse:
		        'let mk_(x, y) = z in z := mk_(x + y, x - y)'.
	self
		assert: (node statement findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node statement findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node statement findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testLookupFlatFunction [

	| node |
	node := flatDocument lookupIdentifier: 'f'.
	self assert: node isViennaAccessFunctionDefinitionNode
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testLookupFlatFunctionParameter [

	| node |
	node := flatDocument lookupIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testLookupFlatOperation [

	| node |
	node := flatDocument lookupIdentifier: 'o'.
	self assert: node isViennaAccessOperationDefinitionNode
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testLookupFlatStateVariable [

	| node |
	node := flatDocument lookupIdentifier: 'a'.
	self assert: node isViennaStateDefinitionNode
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testLookupFlatType [

	| node |
	node := flatDocument lookupIdentifier: 't'.
	self assert: node isViennaAccessTypeDefinitionNode
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testLookupFlatValue [

	| node |
	node := flatDocument lookupIdentifier: 'v'.
	self assert: node isViennaAccessValueDefinitionNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupImportedFunction [

	| node |
	node := self moduleA lookupIdentifier: 'fb1'.
	self assert: node isViennaFunctionImportNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupImportedOperation [

	| node |
	node := self moduleA lookupIdentifier: 'ob1'.
	self assert: node isViennaOperationImportNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupImportedType [

	| node |
	node := self moduleA lookupIdentifier: 'tb1'.
	self assert: node isViennaTypeImportNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupImportedValue [

	| node |
	node := self moduleA lookupIdentifier: 'vb1'.
	self assert: node isViennaValueImportNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupLocalFunction [

	| node |
	node := self moduleA lookupIdentifier: 'f'.
	self assert: node isViennaAccessFunctionDefinitionNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupLocalOperation [

	| node |
	node := self moduleA lookupIdentifier: 'o'.
	self assert: node isViennaAccessOperationDefinitionNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupLocalStateVariable [

	| node |
	node := self moduleA lookupIdentifier: 'a'.
	self assert: node isViennaStateDefinitionNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupLocalType [

	| node |
	node := self moduleA lookupIdentifier: 't'.
	self assert: node isViennaAccessTypeDefinitionNode
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testLookupLocalValue [

	| node |
	node := self moduleA lookupIdentifier: 'v'.
	self assert: node isViennaAccessValueDefinitionNode
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testMapComprehension [

	| node |
	node := ViennaVDMParser new expression parse:
		        '{k |-> v | k in set s, v in set s & k = v + z}'.
	self
		assert: (node suchthatExpression findResolverForIdentifier: 'k')
		identicalTo: node.
	self
		assert: (node suchthatExpression findResolverForIdentifier: 'v')
		identicalTo: node.
	self assert: (node suchthatExpression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testResolveFlatFunction [

	| node |
	node := flatDocument findResolverForIdentifier: 'f'.
	self assert: node identicalTo: node
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testResolveFlatFunctionParameter [

	| node |
	node := flatDocument findResolverForIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testResolveFlatOperation [

	| node |
	node := flatDocument findResolverForIdentifier: 'o'.
	self assert: node identicalTo: flatDocument
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testResolveFlatStateVariable [

	| node |
	node := flatDocument findResolverForIdentifier: 'a'.
	self assert: node identicalTo: node
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testResolveFlatType [

	| node |
	node := flatDocument findResolverForIdentifier: 't'.
	self assert: node identicalTo: flatDocument
]

{ #category : #'tests-flat documents' }
ViennaResolverTest >> testResolveFlatValue [

	| node |
	node := flatDocument findResolverForIdentifier: 'v'.
	self assert: node identicalTo: flatDocument
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveImportedFunction [

	| node |
	node := self moduleA findResolverForIdentifier: 'fb1'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveImportedOperation [

	| node |
	node := self moduleA findResolverForIdentifier: 'ob1'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveImportedType [

	| node |
	node := self moduleA findResolverForIdentifier: 'tb1'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveImportedValue [

	| node |
	node := self moduleA findResolverForIdentifier: 'vb1'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveLocalFunction [

	| node |
	node := self moduleA findResolverForIdentifier: 'f'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveLocalFunctionParameter [

	| node |
	node := self moduleA findResolverForIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveLocalOperation [

	| node |
	node := self moduleA findResolverForIdentifier: 'o'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveLocalStateVariable [

	| node |
	node := self moduleA findResolverForIdentifier: 'a'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveLocalType [

	| node |
	node := self moduleA findResolverForIdentifier: 't'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-modules' }
ViennaResolverTest >> testResolveLocalValue [

	| node |
	node := self moduleA findResolverForIdentifier: 'v'.
	self assert: node identicalTo: self moduleA
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testSequenceComprehension [

	| node |
	node := ViennaVDMParser new expression parse:
		        '[x + z | x in set {1, ..., z} & x < z]'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolverTest >> testSequenceForLoop [

	| node |
	node := ViennaVDMParser new statement parse:
		        'for mk_(x, y) in z do z := [mk_(x, y)]'.
	self
		assert: (node statement findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node statement findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node statement findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolverTest >> testSetComprehension [

	| node |
	node := ViennaVDMParser new expression parse:
		        '{x + y + z | x in set {1, ..., z}, y in set {z, ..., 10} & x < y}'.
	self
		assert: (node expression findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression findResolverForIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolverTest >> testSetForLoop [

	| node |
	node := ViennaVDMParser new statement parse:
		        'for all mk_(x, y) in set z do z := {mk_(x, y)}'.
	self
		assert: (node statement findResolverForIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node statement findResolverForIdentifier: 'y')
		identicalTo: node.
	self assert: (node statement findResolverForIdentifier: 'z') isNil
]

{ #category : #utilities }
ViennaResolverTest >> v [

	flatDocument
		allDescendantsSuchThat: #isViennaValueDefinitionNode
		do: [ :n | ^ n ]
]
