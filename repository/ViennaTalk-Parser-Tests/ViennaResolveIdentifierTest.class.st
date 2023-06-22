Class {
	#name : #ViennaResolveIdentifierTest,
	#superclass : #TestCase,
	#instVars : [
		'modularDocument',
		'flatDocument'
	],
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #utilities }
ViennaResolveIdentifierTest >> f [

	flatDocument
		allDescendantsSuchThat: #isViennaExplicitFunctionDefinitionNode
		do: [ :n | ^ n ]
]

{ #category : #utilities }
ViennaResolveIdentifierTest >> moduleA [
	^ modularDocument moduleNamed: 'A'
]

{ #category : #utilities }
ViennaResolveIdentifierTest >> moduleB [

	^ modularDocument moduleNamed: 'B'
]

{ #category : #utilities }
ViennaResolveIdentifierTest >> o [

	flatDocument
		allDescendantsSuchThat: #isViennaExplicitOperationDefinitionNode
		do: [ :n | ^ n ]
]

{ #category : #running }
ViennaResolveIdentifierTest >> setUp [

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
ViennaResolveIdentifierTest >> t [

	flatDocument
		allDescendantsSuchThat: #isViennaTypeSynonymNode
		do: [ :n | ^ n ]
]

{ #category : #'tests-statements' }
ViennaResolveIdentifierTest >> testBlockStatement [

	| node |
	node := ViennaVDMParser new statement parse:
		        '(dcl x:nat := 0; return x)'.
	self assert: (node second resolveIdentifier: 'x') identicalTo: node
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testCasesExpression [

	| node |
	node := ViennaVDMParser new casesExpressionAlternative parse:
		        'x -> nil'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolveIdentifierTest >> testCasesStatement [

	| node |
	node := ViennaVDMParser new casesStatementAlternative parse:
		        'x -> skip'.
	self
		assert: (node statement resolveIdentifier: 'x')
		identicalTo: node
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveImportedFunction [

	| node |
	node := self moduleA deepResolveIdentifier: 'fb1'.
	self assert: node isViennaAccessFunctionDefinitionNode.
	self assert: node identifier equals: 'fb'.
	self assert: node module identifier equals: 'B'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveImportedOperation [

	| node |
	node := self moduleA deepResolveIdentifier: 'ob1'.
	self assert: node isViennaAccessOperationDefinitionNode.
	self assert: node identifier equals: 'ob'.
	self assert: node module identifier equals: 'B'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveImportedType [

	| node |
	node := self moduleA deepResolveIdentifier: 'tb1'.
	self assert: node isViennaAccessTypeDefinitionNode.
	self assert: node identifier equals: 'tb'.
	self assert: node module identifier equals: 'B'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveImportedValue [

	| node |
	node := self moduleA deepResolveIdentifier: 'vb1'.
	self assert: node isViennaAccessValueDefinitionNode.
	self assert: node pattern identifier equals: 'vb'.
	self assert: node module identifier equals: 'B'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveLocalFunction [

	| node |
	node := self moduleA deepResolveIdentifier: 'f'.
	self assert: node isViennaAccessFunctionDefinitionNode.
	self assert: node identifier equals: 'f'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveLocalFunctionParameter [

	| node |
	node := self moduleA deepResolveIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveLocalOperation [

	| node |
	node := self moduleA deepResolveIdentifier: 'o'.
	self assert: node isViennaAccessOperationDefinitionNode.
	self assert: node identifier equals: 'o'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveLocalStateVariable [

	| node |
	node := self moduleA deepResolveIdentifier: 'a'.
	self assert: node isViennaStateDefinitionNode.
	self assert: node identifier equals: 'Sa'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveLocalType [

	| node |
	node := self moduleA deepResolveIdentifier: 't'.
	self assert: node isViennaAccessTypeDefinitionNode.
	self assert: node identifier equals: 't'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testDeepResolveLocalValue [

	| node |
	node := self moduleA deepResolveIdentifier: 'v'.
	self assert: node isViennaAccessValueDefinitionNode.
	self assert: node pattern identifier equals: 'v'
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testExists1Expression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'exists1 x in set xs & x < 10'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testExistsExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'exists x, y in set s & x + y = z'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-toplevel definitions' }
ViennaResolveIdentifierTest >> testExplicitFunctionDefinition [

	| node |
	node := self f.
	self assert: node identifier equals: 'f'.
	self assert: (node parametersList bindsIdentifier: 'x').
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node
]

{ #category : #'tests-toplevel definitions' }
ViennaResolveIdentifierTest >> testExplicitOperationDefinition [

	| node |
	node := self o.
	self assert: node identifier equals: 'o'.
	self assert: (node parameters bindsIdentifier: 'x').
	self
		assert: (node statement resolveIdentifier: 'x')
		identicalTo: node
]

{ #category : #'tests-toplevel definitions' }
ViennaResolveIdentifierTest >> testExtendedExplicitFunctionDefinition [

	| node |
	node := ViennaVDMParser new extendedExplicitFunctionDefinition end
		        parse: 'f[@T] (x:@T) res:@T == x post res = x'.
	self assert: (node type resolveIdentifier: '@T') identicalTo: node.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self assert: (node post resolveIdentifier: 'res') identicalTo: node
]

{ #category : #'tests-toplevel definitions' }
ViennaResolveIdentifierTest >> testExtendedExplicitOperationDefinition [

	| node |
	node := ViennaVDMParser new extendedExplicitOperationDefinition end
		        parse: 'o (x:T) res:T == return x post res = x'.
	self
		assert: (node statement expression resolveIdentifier: 'x')
		identicalTo: node.
	self assert: (node post resolveIdentifier: 'res') identicalTo: node
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testForallExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'forall x, y in set s & x + y = z'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-toplevel definitions' }
ViennaResolveIdentifierTest >> testImplicitFunctionDefinition [

	| node |
	node := ViennaVDMParser new implicitFunctionDefinition end parse:
		        'f[@T] (x:@T) res:@T post res = x'.
	self assert: (node type resolveIdentifier: '@T') identicalTo: node.
	self assert: (node post resolveIdentifier: 'x') identicalTo: node.
	self assert: (node post resolveIdentifier: 'res') identicalTo: node
]

{ #category : #'tests-toplevel definitions' }
ViennaResolveIdentifierTest >> testImplicitOperationDefinition [

	| node |
	node := ViennaVDMParser new implicitOperationDefinition end parse:
		        'o (x:T) res:T ext rd a:T post res = x'.
	self assert: (node post resolveIdentifier: 'x') identicalTo: node.
	self assert: (node post resolveIdentifier: 'res') identicalTo: node.
	self assert: (node post resolveIdentifier: 'a') isNil
]

{ #category : #'tests-statements' }
ViennaResolveIdentifierTest >> testIndexForLoop [

	| node |
	node := ViennaVDMParser new statement parse:
		        'for i = 1 to 10 by 2 do skip'.
	self
		assert: (node statement resolveIdentifier: 'i')
		identicalTo: node
]

{ #category : #'tests-others' }
ViennaResolveIdentifierTest >> testInvariant [

	| node |
	node := ViennaVDMParser new invariantInitialFunction end parse:
		        'mk_(x, y) == x = y'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression resolveIdentifier: 'y')
		identicalTo: node
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testIotaExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'iota x in set xs & x < 10'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testLambdaExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'lambda x:nat, y:nat & x + y'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testLetBeExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'let x, y in set s be st x = y in x + y'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolveIdentifierTest >> testLetBeStatement [

	| node |
	node := ViennaVDMParser new statement parse:
		        'let x, y in set s be st x = y in z := x + y'.
	self
		assert: (node statement resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node statement resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node statement resolveIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testLetExpression [

	| node |
	node := ViennaVDMParser new expression parse:
		        'let mk_(x, y) = z in x + y'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolveIdentifierTest >> testLetStatement [

	| node |
	node := ViennaVDMParser new statement parse:
		        'let mk_(x, y) = z in z := mk_(x + y, x - y)'.
	self
		assert: (node statement resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node statement resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node statement resolveIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testMapComprehension [

	| node |
	node := ViennaVDMParser new expression parse:
		        '{k |-> v | k in set s, v in set s & k = v + z}'.
	self
		assert: (node suchthatExpression resolveIdentifier: 'k')
		identicalTo: node.
	self
		assert: (node suchthatExpression resolveIdentifier: 'v')
		identicalTo: node.
	self assert: (node suchthatExpression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-flat documents' }
ViennaResolveIdentifierTest >> testResolveFlatFunction [

	| node |
	node := flatDocument resolveIdentifier: 'f'.
	self assert: node isViennaAccessFunctionDefinitionNode.
	self assert: node identifier equals: 'f'
]

{ #category : #'tests-flat documents' }
ViennaResolveIdentifierTest >> testResolveFlatFunctionParameter [

	| node |
	node := flatDocument resolveIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #'tests-flat documents' }
ViennaResolveIdentifierTest >> testResolveFlatOperation [

	| node |
	node := flatDocument resolveIdentifier: 'o'.
	self assert: node isViennaAccessOperationDefinitionNode.
	self assert: node identifier equals: 'o'
]

{ #category : #'tests-flat documents' }
ViennaResolveIdentifierTest >> testResolveFlatStateVariable [

	| node |
	node := flatDocument resolveIdentifier: 'a'.
	self assert: node isViennaStateDefinitionNode.
	self assert: node identifier equals: 'Sa'
]

{ #category : #'tests-flat documents' }
ViennaResolveIdentifierTest >> testResolveFlatType [

	| node |
	node := flatDocument resolveIdentifier: 't'.
	self assert: node isViennaAccessTypeDefinitionNode.
	self assert: node identifier equals: 't'
]

{ #category : #'tests-flat documents' }
ViennaResolveIdentifierTest >> testResolveFlatValue [

	| node |
	node := flatDocument resolveIdentifier: 'v'.
	self assert: node isViennaAccessValueDefinitionNode.
	self assert: node pattern identifier equals: 'v'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveImportedFunction [

	| node |
	node := self moduleA resolveIdentifier: 'fb1'.
	self assert: node isViennaFunctionImportNode.
	self assert: node identifier equals: 'fb'.
	self assert: node rename identifier equals: 'fb1'.
	node := self moduleA resolveIdentifier: 'fb'.
	self assert: node isNil
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveImportedOperation [

	| node |
	node := self moduleA resolveIdentifier: 'ob1'.
	self assert: node isViennaOperationImportNode.
	self assert: node identifier equals: 'ob'.
	self assert: node rename identifier equals: 'ob1'.
	node := self moduleA resolveIdentifier: 'ob'.
	self assert: node isNil
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveImportedType [

	| node |
	node := self moduleA resolveIdentifier: 'tb1'.
	self assert: node isViennaTypeImportNode.
	self assert: node identifier equals: 'tb'.
	self assert: node rename identifier equals: 'tb1'.
	node := self moduleA resolveIdentifier: 'tb'.
	self assert: node isNil
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveImportedValue [

	| node |
	node := self moduleA resolveIdentifier: 'vb1'.
	self assert: node isViennaValueImportNode.
	self assert: node identifier equals: 'vb'.
	self assert: node rename identifier equals: 'vb1'.
	node := self moduleA resolveIdentifier: 'vb'.
	self assert: node isNil
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveLocalFunction [

	| node |
	node := self moduleA resolveIdentifier: 'f'.
	self assert: node isViennaAccessFunctionDefinitionNode.
	self assert: node identifier equals: 'f'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveLocalFunctionParameter [

	| node |
	node := self moduleA resolveIdentifier: 'x'.
	self assert: node isNil
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveLocalOperation [

	| node |
	node := self moduleA resolveIdentifier: 'o'.
	self assert: node isViennaAccessOperationDefinitionNode.
	self assert: node identifier equals: 'o'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveLocalStateVariable [

	| node |
	node := self moduleA resolveIdentifier: 'a'.
	self assert: node isViennaStateDefinitionNode.
	self assert: node identifier equals: 'Sa'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveLocalType [

	| node |
	node := self moduleA resolveIdentifier: 't'.
	self assert: node isViennaAccessTypeDefinitionNode.
	self assert: node identifier equals: 't'
]

{ #category : #'tests-modules' }
ViennaResolveIdentifierTest >> testResolveLocalValue [

	| node |
	node := self moduleA resolveIdentifier: 'v'.
	self assert: node isViennaAccessValueDefinitionNode.
	self assert: node pattern identifier equals: 'v'
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testSequenceComprehension [

	| node |
	node := ViennaVDMParser new expression parse:
		        '[x + z | x in set {1, ..., z} & x < z]'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolveIdentifierTest >> testSequenceForLoop [

	| node |
	node := ViennaVDMParser new statement parse:
		        'for mk_(x, y) in z do z := [mk_(x, y)]'.
	self
		assert: (node statement resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node statement resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node statement resolveIdentifier: 'z') isNil
]

{ #category : #'tests-expressions' }
ViennaResolveIdentifierTest >> testSetComprehension [

	| node |
	node := ViennaVDMParser new expression parse:
		        '{x + y + z | x in set {1, ..., z}, y in set {z, ..., 10} & x < y}'.
	self
		assert: (node expression resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node expression resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node expression resolveIdentifier: 'z') isNil
]

{ #category : #'tests-statements' }
ViennaResolveIdentifierTest >> testSetForLoop [

	| node |
	node := ViennaVDMParser new statement parse:
		        'for all mk_(x, y) in set z do z := {mk_(x, y)}'.
	self
		assert: (node statement resolveIdentifier: 'x')
		identicalTo: node.
	self
		assert: (node statement resolveIdentifier: 'y')
		identicalTo: node.
	self assert: (node statement resolveIdentifier: 'z') isNil
]

{ #category : #utilities }
ViennaResolveIdentifierTest >> v [

	flatDocument
		allDescendantsSuchThat: #isViennaValueDefinitionNode
		do: [ :n | ^ n ]
]
