Class {
	#name : #ViennaVDMGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #running }
ViennaVDMGrammarTest >> setUp [
	grammar := ViennaVDMGrammar new
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testAccessFunctionDefinition [
	self
		assert: (grammar accessFunctionDefinition end parse: 'f : t1 -> t1 f(v)==e')
		equals: #(#() #('f' #() #('t1' 't1') 'f' #(#('v')) 'e' nil nil nil)).
	self
		assert: (grammar accessFunctionDefinition end parse: 'private f : t1 -> t1 f(v)==e')
		equals: #(#('private') #('f' #() #('t1' 't1') 'f' #(#('v')) 'e' nil nil nil))
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testAccessOperationDefinition [
	self
		assert: (grammar accessOperationDefinition end parse: 'op : t1 ==> t2 op(v)==return e')
		equals: #(#() #('op' #('t1' 't2') 'op' #('v') 'e' nil nil)).
	self
		assert: (grammar accessOperationDefinition end parse: 'pure async static public op : t1 ==> t2 op(v)==return e')
		equals: #(#('pure' 'async' 'static' 'public') #('op' #('t1' 't2') 'op' #('v') 'e' nil nil))
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testAccessTypeDefinition [
	self assert: (grammar accessTypeDefinition end parse: 't = t1') equals: #(#() #('t' 't1' nil)).
	self assert: (grammar accessTypeDefinition end parse: 'public t = t1') equals: #(#('public') #('t' 't1' nil)).
	self assert: (grammar accessTypeDefinition end parse: 'static t = t1') equals: #(#('static') #('t' 't1' nil)).
	self
		assert: (grammar accessTypeDefinition end parse: 'static protected t = t1')
		equals: #(#('static' 'protected') #('t' 't1' nil)).
	self
		assert: (grammar accessTypeDefinition end parse: 'private static t = t1')
		equals: #(#('static' 'private') #('t' 't1' nil))
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testAccessValueDefinition [
	self assert: (grammar accessValueDefinition end parse: 'v = 0') equals: #(#() #('v' nil '0')).
	self assert: (grammar accessValueDefinition end parse: 'public v =0') equals: #(#('public') #('v' nil '0'))
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testAlwaysStatement [
	self assert: (grammar statement end parse: 'always return e1 in return e2') equals: #('e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testApply1 [
	self assert: (grammar expression end parse: 'f()') equals: #('f' #())
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testApply2 [
	self assert: (grammar expression end parse: 'f(a1)') equals: #('f' #('a1'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testApply3 [
	self assert: (grammar expression end parse: 'f(a1,a2)') equals: #('f' #('a1' 'a2'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testApply4 [
	self assert: (grammar expression end parse: 'f(a1,a2)(a3)') equals: #(#('f' #('a1' 'a2')) #('a3'))
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testAssignStatement [
	self assert: (grammar statement end parse: 'a := e') equals: #('a' 'e')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testBasicType1 [
	self assert: (grammar type end parse: 'bool') equals: 'bool'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testBasicType2 [
	self assert: (grammar type end parse: 'nat1') equals: 'nat1'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testBasicType3 [
	self assert: (grammar type end parse: 'nat') equals: 'nat'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testBasicType4 [
	self assert: (grammar type end parse: 'int') equals: 'int'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testBasicType5 [
	self assert: (grammar type end parse: 'real') equals: 'real'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testBasicType6 [
	self assert: (grammar type end parse: 'char') equals: 'char'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testBasicType7 [
	self assert: (grammar type end parse: 'token') equals: 'token'
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testBind1 [
	self assert: (grammar bind end parse: 'v:t') equals: #('v' 't')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testBind2 [
	self assert: (grammar bind end parse: 'v in set t') equals: #('v' 't')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testBindList1 [
	self assert: (grammar bindList end parse: 'v1,v2:t , v3 in set s') equals: #(#(#('v1' 'v2') 't') #(#('v3') 's'))
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testBlockStatement [
	self
		assert: (grammar statement end parse: '(dcl v1:t1 := e1,v2:t2:=e2; dcl v3:t3 := e3,v4:t4:=e4; skip; skip)')
		equals: #(#(#(#('v1' 't1' 'e1') #('v2' 't2' 'e2')) #(#('v3' 't3' 'e3') #('v4' 't4' 'e4'))) #(nil nil)).
	self assert: (grammar statement end parse: '(skip; skip;)') equals: #(#() #(nil nil)).
	self assert: (grammar statement end parse: '(dcl v1:t1 := e1,v2:t2:=e2; dcl v3:t3 := e3,v4:t4:=e4)') isPetit2Failure
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testBooleanLiteral1 [
	self assert: (grammar symbolicLiteral end parse: 'true') equals: true
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testBooleanLiteral2 [
	self assert: (grammar symbolicLiteral end parse: 'false') equals: false
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testCallStatement [
	self assert: (grammar statement end parse: 'f(e1,e2,e3)') equals: #('f' #('e1' 'e2' 'e3')).
	self assert: (grammar statement end parse: 'f()') equals: #('f' #())
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testCasesExpression [
	self
		assert: (grammar expression end parse: 'cases e:p11,p12->e1,p2->e2,others->default end')
		equals: #('e' #(#(#('p11' 'p12') 'e1') #(#('p2') 'e2')) 'default')
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testCasesStatement [
	self
		assert: (grammar statement end parse: 'cases e:p11,p12->return e1,p2->return e2,others->return default end')
		equals: #('e' #(#(#('p11' 'p12') 'e1') #(#('p2') 'e2')) 'default')
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral1 [
	self assert: (grammar expression end parse: '''a''') equals: $a
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral10 [
	self assert: (grammar expression end parse: '''\''''') equals: $'
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral2 [
	self assert: (grammar expression end parse: '''ab''') isPetit2Failure
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral3 [
	self assert: (grammar expression end parse: '''\\''') equals: $\
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral4 [
	self assert: (grammar expression end parse: '''\r''') equals: Character cr
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral5 [
	self assert: (grammar expression end parse: '''\n''') equals: Character lf
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral6 [
	self assert: (grammar expression end parse: '''\t''') equals: Character tab
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral7 [
	self assert: (grammar expression end parse: '''\101''') equals: $A
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral8 [
	self assert: (grammar expression end parse: '''\x41''') equals: $A
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testCharacterLiteral9 [
	self assert: (grammar expression end parse: '''\u0041''') equals: $A
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testCompositeType1 [
	self assert: (grammar type end parse: 'compose t of end') equals: #('t' #())
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testCompositeType2 [
	self assert: (grammar type end parse: 'compose t of v1:t1 end') equals: #('t' #(#('v1' 't1')))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testCompositeType3 [
	self
		assert: (grammar type end parse: 'compose t of v1:t1 v2:-t2 t3 end')
		equals: #('t' #(#('v1' 't1') #('v2' 't2') 't3'))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testCompositeType4 [
	self
		assert: (grammar type end parse: 'compose t of v1 : t1 v2 :- t2 t3 end')
		equals: #('t' #(#('v1' 't1') #('v2' 't2') 't3'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testCompositionExpression1 [
	self assert: (grammar expression end parse: 'e1 comp e2') equals: #('e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testCompositionExpression2 [
	self assert: (grammar expression end parse: 'e1 comp e2 comp e3') equals: #('e1' #('e2' 'e3'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testCompositionExpression3 [
	self assert: (grammar expression end parse: 'e1 ** e2 comp e3') equals: #(#('e1' 'e2') 'e3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testCompositionExpression4 [
	self assert: (grammar expression end parse: 'e1 comp e2 ** e3') equals: #('e1' #('e2' 'e3'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testConnectives1 [
	self assert: (grammar expression end parse: 'not e') equals: 'e'
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testConnectives2 [
	#('<=>' '=>' 'or' 'and')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2') equals: #('e1' 'e2') ]
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testConnectives3 [
	self assert: (grammar expression end parse: 'e1 => e2 => e3') equals: #('e1' #('e2' 'e3'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testConnectives4 [
	#('<=>' 'or' 'and')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2 ' , op , ' e3') equals: #(#('e1' 'e2') 'e3') ]
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testConnectives5 [
	self
		assert: (grammar expression end parse: 'not e1 <=> e2 => e3 or e4 and e5')
		equals: #('e1' #('e2' #('e3' #('e4' 'e5'))))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testDefExpression1 [
	self
		assert: (grammar expression end parse: 'def v1:t1=e1;v2 in set s=e2;v3=e3; in e')
		equals: #(#(#(#('v1' 't1') 'e1') #(#('v2' 's') 'e2') #('v3' 'e3')) 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testDefExpression2 [
	self
		assert: (grammar expression end parse: 'def v1:t1=e1;v2 in set s=e2;v3=e3 in e')
		equals: #(#(#(#('v1' 't1') 'e1') #(#('v2' 's') 'e2') #('v3' 'e3')) 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testDefExpression3 [
	self
		assert: (grammar expression end parse: 'def v1 : t1 = e1 ; v2 in set s = e2 ; v3 = e3 in e')
		equals: #(#(#(#('v1' 't1') 'e1') #(#('v2' 's') 'e2') #('v3' 'e3')) 'e')
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testDefStatement [
	self assert: (grammar statement end parse: 'def v:t = e in skip') equals: #(#(#(#('v' 't') 'e')) nil)
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testDicimalLiteral1 [
	self assert: (grammar expression end parse: '0') equals: '0'
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testDicimalLiteral2 [
	self assert: (grammar expression end parse: '-1') equals: '1'
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testDicimalLiteral3 [
	self assert: (grammar expression end parse: '-1.0') equals: '1.0'
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testDicimalLiteral4 [
	self assert: (grammar expression end parse: '-1.0e1') equals: '1.0e1'
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testDicimalLiteral5 [
	self assert: (grammar expression end parse: '-1.0e+1') equals: '1.0e+1'
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testDicimalLiteral6 [
	self assert: (grammar expression end parse: '-1.0e-1') equals: '1.0e-1'
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testDicimalLiteral7 [
	self assert: (grammar expression end parse: '-1e-1') equals: '1e-1'
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testDocument [
	self assert: (grammar document end parse: 'values v = 1') equals: #(#(#(#() #('v' nil '1')))).
	self
		assert:
			(grammar document end parse: 'module m1 exports all definitions values v = 1 end m1 module m2 exports all  end m2')
		equals: #(#('m1' #(nil 'all') #(#(#(#() #('v' nil '1'))))) #('m2' #(nil 'all') nil))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testEvaluators1 [
	#('abs' 'floor' 'card' 'power' 'dinter' 'dunion' 'dom' 'rng' 'merge' 'len' 'elems' 'hd' 'tl' 'conc' 'inds' 'inverse')
		do: [ :unary | self assert: (grammar expression end parse: unary , ' e') equals: 'e' ]
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testEvaluators2 [
	#(':>' ':->' '<:' '<-:' 'div' 'mod' 'rem' '*' '/' 'inter' '+' '-' 'union' '\' 'munion' '++' '^')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2') equals: #('e1' 'e2') ]
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testEvaluators3 [
	#(':>' ':->' 'div' 'mod' 'rem' '*' '/' 'inter' '+' '-' 'union' '\' 'munion' '++' '^')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2 ' , op , ' e3') equals: #(#('e1' 'e2') 'e3') ]
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testEvaluators4 [
	#('<:' '<-:')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2 ' , op , ' e3') equals: #('e1' #('e2' 'e3')) ]
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testExists1Expression1 [
	self assert: (grammar expression end parse: 'exists1 v1 in set s & e') equals: #(#('v1' 's') 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testExists1Expression2 [
	self assert: (grammar expression end parse: 'exists1 v1,v2:t1, v3:t2 & e') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testExistsExpression1 [
	self
		assert: (grammar expression end parse: 'exists v1,v2:t1, v3:t2 & e')
		equals: #(#(#(#('v1' 'v2') 't1') #(#('v3') 't2')) 'e')
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testExitStatement [
	self assert: (grammar statement end parse: 'exit e') equals: 'e'
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testExplicitFunctionDefinition [
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 f(x) == y pre b1 post b2 measure f2')
		equals: #('f' #('@t') #('t1' 't2') 'f' #(#('x')) 'y' 'b1' 'b2' 'f2').
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 -> t3 f(x)(y) == z pre b1 post b2 measure f2')
		equals: #('f' #('@t') #('t1' #('t2' 't3')) 'f' #(#('x') #('y')) 'z' 'b1' 'b2' 'f2').
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 -> t3 f(x)(y) == z pre b1 post b2 measure f2(x, y)')
		equals: #('f' #('@t') #('t1' #('t2' 't3')) 'f' #(#('x') #('y')) 'z' 'b1' 'b2' ('f2' ('x' 'y'))).
	self
		assert: (grammar functionDefinition end parse: 'f: t1->t2 f(x) == y')
		equals: #('f' #() #('t1' 't2') 'f' #(#('x')) 'y' nil nil nil)
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testExplicitOperationDefinition [
	self
		assert: (grammar operationDefinition end parse: 'op : nat==> () op(x) == return x pre e1 post e2')
		equals: #('op' #('nat' nil) 'op' #('x') 'x' 'e1' 'e2')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testExportDefinition [
	self assert: (grammar exportDefinition end parse: 'exports all') equals: 'all'.
	self
		assert: (grammar exportDefinition end parse: 'exports types t1; struct t2; values v1, v2 : nat; v3 : int')
		equals: #(#(#(nil 't1') #('struct' 't2')) #(#(#('v1' 'v2') 'nat') #(#('v3') 'int')))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testExportFunctionsSignature [
	self
		assert: (grammar exportFunctionsSignature end parse: 'functions f1, f2[@t] : @t -> bool; f3 : nat -> nat')
		equals: #(#(#('f1' 'f2') #('@t') #('@t' 'bool')) #(#('f3') #() #('nat' 'nat')))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testExportModuleSignature [
	self assert: (grammar exportModuleSignature end parse: 'all') equals: 'all'.
	self
		assert: (grammar exportModuleSignature end parse: 'types t1; struct t2; values v1, v2 : nat; v3 : int')
		equals: #(#(#(nil 't1') #('struct' 't2')) #(#(#('v1' 'v2') 'nat') #(#('v3') 'int')))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testExportOperationsSignature [
	self
		assert: (grammar exportOperationsSignature end parse: 'operations op1, op2 : nat ==> (); op3 : () ==> nat;')
		equals: #(#(#('op1' 'op2') #('nat' nil)) #(#('op3') #(nil 'nat')))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testExportSignature [
	self assert: (grammar exportSignature end parse: 'types t1; struct t2;') equals: #(#(nil 't1') #('struct' 't2')).
	self
		assert: (grammar exportSignature end parse: 'values v1, v2 : nat; v3 : int')
		equals: #(#(#('v1' 'v2') 'nat') #(#('v3') 'int')).
	self
		assert: (grammar exportSignature end parse: 'functions f1, f2[@t] : @t -> bool; f3 : nat -> nat')
		equals: #(#(#('f1' 'f2') #('@t') #('@t' 'bool')) #(#('f3') #() #('nat' 'nat'))).
	self
		assert: (grammar exportSignature end parse: 'operations op1, op2 : nat ==> (); op3 : () ==> nat;')
		equals: #(#(#('op1' 'op2') #('nat' nil)) #(#('op3') #(nil 'nat')))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testExportTypesSignature [
	self assert: (grammar exportTypesSignature end parse: 'types t1; struct t2;') equals: #(#(nil 't1') #('struct' 't2'))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testExportValuesSignature [
	self
		assert: (grammar exportValuesSignature end parse: 'values v1, v2 : nat; v3 : int')
		equals: #(#(#('v1' 'v2') 'nat') #(#('v3') 'int'))
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testExtendedExplicitFunctionDefinition [
	self
		assert: (grammar functionDefinition end parse: 'f[@t](x:t1) res:t2 == y pre b1 post b2')
		equals: #('f' #('@t') #(('x') 't1') #('res' 't2') 'y' 'b1' 'b2' ).
	self
		assert: (grammar functionDefinition end parse: 'f(x:t1) res:t2 == y post b2')
		equals: #('f' #() #(('x') 't1') #('res' 't2') 'y' nil 'b2' ).
	self
		assert: (grammar functionDefinition end parse: 'f(x:t1) res:t2 == y') isPetit2Failure
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testExtendedExplicitOperationDefinition [
	self
		assert:
			(grammar operationDefinition end
				parse: 'op(p1:t1, p2:t2) i1:t3 == skip ext rd v1:t4 wr v2:t5 pre b1 post b2 errs i2:e1->e2')
		equals:
			#('op' #(#('p1') 't1' #('p2') 't2') #('i1' 't3') nil #(#('rd' #('v1') 't4') #('wr' #('v2') 't5')) 'b1' 'b2' #(#('i2' 'e1' 'e2'))).
	self
		assert: (grammar operationDefinition end parse: 'op(p1:t1, p2:t2) i1:t3 == skip post b2')
		equals: #('op' #(#('p1') 't1' #('p2') 't2') #('i1' 't3') nil nil nil 'b2' nil).
	self
		assert:
			(grammar operationDefinition end
				parse: 'op(p1:t1, p2:t2) i1:t3 == skip ext rd v1:t4 wr v2:t5 pre b1  errs i2:e1->e2')
				isPetit2Failure
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testFieldSelect1 [
	self assert: (grammar expression end parse: 'r1.f1') equals: #('r1' 'f1')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testFieldSelect2 [
	self assert: (grammar expression end parse: 'r1.f1.f2') equals: #(#('r1' 'f1') 'f2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testFieldSelect3 [
	self assert: (grammar expression end parse: 'r1 . f1 . f2') equals: #(#('r1' 'f1') 'f2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testFieldSelect4 [
	self assert: (grammar expression end parse: 'f().f1') equals: #(#('f' #()) 'f1')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testFieldSelect5 [
	self assert: (grammar expression end parse: 'f.f1()') equals: #(#('f' 'f1') #())
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testFinExpression3 [
	self assert: (grammar expression end parse: '#fin()') isPetit2Failure
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testFlatDocument [
	self assert: (grammar flatDocument end parse: 'values v = 1') equals: #(#(#(#() #('v' nil '1'))))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testForallExpression1 [
	self
		assert: (grammar expression end parse: 'forall v1,v2:t1, v3:t2 & e')
		equals: #(#(#(#('v1' 'v2') 't1') #(#('v3') 't2')) 'e')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testFunctionExport [
	self
		assert: (grammar functionExport end parse: 'f1, f2[@t] : @t -> bool')
		equals: #(#('f1' 'f2') #('@t') #('@t' 'bool'))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testFunctionImport [
	self assert: (grammar functionImport end parse: 'f') equals: #('f' nil nil nil).
	self assert: (grammar functionImport end parse: 'f[@t]: @t -> @t') equals: #('f' #('@t') #('@t' '@t') nil).
	self assert: (grammar functionImport end parse: 'f1 renamed f2') equals: #('f1' nil nil 'f2').
	self
		assert: (grammar functionImport end parse: 'f1[@t]: @t -> @t renamed f2')
		equals: #('f1' #('@t') #('@t' '@t') 'f2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testFunctionTypeInstantiation1 [
	self assert: (grammar expression end parse: 'f[bool]') equals: #(#f #('bool'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testFunctionTypeInstantiation2 [
	self assert: (grammar expression end parse: 'f[t1,t2]') equals: #(#f #('t1' 't2'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testFunctionTypeInstantiation3 [
	self assert: (grammar expression end parse: 'f[]') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testFunctionTypeInstantiation4 [
	self assert: (grammar expression end parse: 'f[t1][t2]') equals: #(#('f' #('t1')) #('t2'))
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testHexadecimalLiteral1 [
	self assert: (grammar expression end parse: '0x0') equals: '0'
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testHexadecimalLiteral2 [
	self assert: (grammar expression end parse: '0X0') equals: '0'
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testIdentifier1 [
	self assert: (grammar identifier end parse: 'v1v') equals: 'v1v'
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testIdentifier2 [
	self assert: (grammar identifier end parse: '1v1') isPetit2Failure
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testIdentifier3 [
	self assert: (grammar identifier end parse: 'mk_t') isPetit2Failure
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testIdentifier4 [
	self assert: (grammar identifier end parse: 'lambda') isPetit2Failure
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testIdentityStatement [
	self assert: (grammar statement end parse: 'skip') equals: nil
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIfExpression1 [
	self assert: (grammar expression end parse: 'if cond1 then e1 else e2') equals: #(#(#('cond1' 'e1')) 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIfExpression2 [
	self
		assert: (grammar expression end parse: 'if cond1 then e1 elseif cond2 then e2 else e3')
		equals: #(#(#('cond1' 'e1') #('cond2' 'e2')) 'e3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIfExpression3 [
	self
		assert: (grammar expression end parse: 'if cond1 then e1 else if cond2 then e2 else e3')
		equals: #(#(#('cond1' 'e1')) #(#(#('cond2' 'e2')) 'e3'))
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testIfStatement [
	self
		assert: (grammar statement end parse: 'if cond1 then return e1 elseif cond2 then return e2 else return e3')
		equals: #(#(#('cond1' 'e1') #('cond2' 'e2')) 'e3').
	self assert: (grammar statement end parse: 'if cond1 then return e1 else return e2') equals: #(#(#('cond1' 'e1')) 'e2').
	self
		assert:
			(grammar statement end parse: 'if cond1 then return e1 elseif cond2 then return e2 elseif cond3 then return e3 else return e4')
		equals: #(#(#('cond1' 'e1') #('cond2' 'e2') #('cond3' 'e3')) 'e4').
	self assert: (grammar statement end parse: 'if cond1 then return e1') equals: #(#(#('cond1' 'e1')) nil)
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testImplicitFunctionDefinition [
	self
		assert: (grammar functionDefinition end parse: 'f[@t](p1:t1, p2:t2) i1:t3 pre b1 post b2')
		equals: #('f' #('@t') #(#('p1') 't1' #('p2') 't2') #('i1' 't3') 'b1' 'b2').
	self
		assert: (grammar functionDefinition end parse: 'f[@t](p1:t1, p2:t2) i1:t3 post b2')
		equals: #('f' #('@t') #(#('p1') 't1' #('p2') 't2') #('i1' 't3') nil 'b2').
	self
		assert:
			(grammar functionDefinition end parse: 'f[@t](p1:t1, p2:t2) i1:t3 pre b1') isPetit2Failure
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testImplicitOperationDefinition [
	self
		assert:
			(grammar operationDefinition end
				parse: 'op(p1:t1, p2:t2) i1:t3 ext rd v1:t4 wr v2:t5 pre b1 post b2 errs i2:e1->e2')
		equals:
			#('op' #(#('p1') 't1' #('p2') 't2') #('i1' 't3') #(#(#('rd' #('v1') 't4') #('wr' #('v2') 't5')) 'b1' 'b2' #(#('i2' 'e1' 'e2')))).
	self
		assert: (grammar operationDefinition end parse: 'op(p1:t1, p2:t2) i1:t3 post b2')
		equals: #('op' #(#('p1') 't1' #('p2') 't2') #('i1' 't3') #(nil nil 'b2' nil)).
	self
		assert:
			(grammar operationDefinition end
				parse: 'op(p1:t1, p2:t2) i1:t3 ext rd v1:t4 wr v2:t5 pre b1 errs i2:e1->e2')
				isPetit2Failure
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testImportDefinition [
	self
		assert: (grammar importDefinition end parse: 'from m values v1; v2 functions f ; values v')
		equals: #('m' #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil nil)) #(#('v' nil nil)))).
	self assert: (grammar importDefinition end parse: 'from m all') equals: #('m' 'all')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testImportDefinitionList [
	self
		assert: (grammar importDefinitionList end parse: 'imports from m1 values v1; v2 functions f ; values v, from m2 all')
		equals: #(#('m1' #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil nil)) #(#('v' nil nil)))) #('m2' 'all'))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testImportFunctionsSignature [
	self
		assert: (grammar importFunctionsSignature end parse: 'functions f1; f2 renamed f3')
		equals: #(#('f1' nil nil nil) #('f2' nil nil 'f3'))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testImportModuleSignature [
	self
		assert: (grammar importModuleSignature end parse: 'values v1; v2 functions f ; values v')
		equals: #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil nil)) #(#('v' nil nil))).
	self assert: (grammar importModuleSignature end parse: 'all') equals: 'all'
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testImportOperationsSignature [
	self
		assert: (grammar importOperationsSignature end parse: 'operations op1; op2 : () ==> () renamed op3')
		equals: #(#('op1' nil nil) #('op2' #(nil nil) 'op3'))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testImportSignature [
	self assert: (grammar importSignature end parse: 'values v1; v2;') equals: #(#('v1' nil nil) #('v2' nil nil)).
	self assert: (grammar importSignature end parse: 'functions f') equals: #(#('f' nil nil nil))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testImportTypesSignature [
	self
		assert: (grammar importTypesSignature end parse: 'types t1; t2 renamed t3; t4 = t5 renamed t6; t7;')
		equals: #(#('t1' nil) #('t2' 't3') #(#('t4' 't5' nil) 't6') #('t7' nil))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testImportValuesSignature [
	self
		assert: (grammar importValuesSignature end parse: 'values v1; v2 renamed v3')
		equals: #(#('v1' nil nil) #('v2' nil 'v3'))
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testIndexForLoop [
	self assert: (grammar statement end parse: 'for v = e1 to e2 by e3 do return e4') equals: #('v' 'e1' 'e2' 'e3' 'e4').
	self assert: (grammar statement end parse: 'for v = e1 to e2 do return e3') equals: #('v' 'e1' 'e2' nil 'e3')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testInmapType1 [
	self assert: (grammar type end parse: 'inmap t1 to t2') equals: #('t1' 't2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testInmapType2 [
	self assert: (grammar type end parse: 'inmap t1 to inmap t2 to t3') equals: #('t1' #('t2' 't3'))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testInmapType3 [
	self assert: (grammar type end parse: 'inmap inmap t1 to t2 to t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testInterface [
	self
		assert: (grammar interface end parse: 'imports from m1 values v1; v2 functions f ; values v, from m2 all exports all')
		equals:
			#(#(#('m1' #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil nil)) #(#('v' nil nil)))) #('m2' 'all')) 'all').
	self assert: (grammar interface end parse: 'exports values v1:t1') equals: #(nil #(#(#(#('v1') 't1'))))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testInvariantInitialFunction [
	self
		assert: (ViennaVDMGrammar new invariantInitialFunction end parse: 'p == e')
		equals:
			{'p'.
			'e'}
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIotaExpression1 [
	self assert: (grammar expression end parse: 'iota v1 in set s & e') equals: #(#('v1' 's') 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIotaExpression2 [
	self assert: (grammar expression end parse: 'iota v1, v2 in set s & e') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression1 [
	self assert: (grammar expression end parse: 'is_t(e)') equals: #('t' 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression2 [
	self assert: (grammar expression end parse: 'is_t(e1, e2)') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression3 [
	self assert: (grammar expression end parse: 'is_ t(e1)') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression4 [
	self assert: (grammar expression end parse: 'is_bool(e)') equals: #('bool' 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression5 [
	self assert: (grammar expression end parse: 'is_bool(e1, e2)') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression6 [
	self assert: (grammar expression end parse: 'is_ bool(e)') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression7 [
	self assert: (grammar expression end parse: 'is_(e, t)') = #('e' 't')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression8 [
	self assert: (grammar expression end parse: 'is_(e1, e2, e3)') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIterateExpression1 [
	self assert: (grammar expression end parse: 'e1**e2') equals: #('e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIterateExpression2 [
	self assert: (grammar expression end parse: 'e1 ** e2 ** e3') equals: #('e1' #('e2' 'e3'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLambdaExpression1 [
	self assert: (grammar expression end parse: 'lambda v1:t1,v2:t2&e') equals: #(#(#('v1' 't1') #('v2' 't2')) 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLambdaExpression2 [
	self assert: (grammar expression end parse: 'lambda v1,v2:t&e') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLetBeExpression1 [
	self assert: (grammar expression end parse: 'let v1,v2:t in e') equals: #(#(#('v1' 'v2') 't') nil 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLetBeExpression2 [
	self assert: (grammar expression end parse: 'let v1,v2:t be st e1 in e2') equals: #(#(#('v1' 'v2') 't') 'e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLetBeExpression3 [
	self assert: (grammar expression end parse: 'let v1,v2 in set s in e') equals: #(#(#('v1' 'v2') 's') nil 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLetBeExpression4 [
	self
		assert: (grammar expression end parse: 'let v1,v2 in set t be st e1 in e2')
		equals: #(#(#('v1' 'v2') 't') 'e1' 'e2')
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testLetBeStatement [
	self assert: (grammar statement end parse: 'let v in set s be st e in skip') equals: #(#(#('v') 's') 'e' nil).
	self assert: (grammar statement end parse: 'let v in set s in skip') equals: #(#(#('v') 's') nil nil)
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLetExpression1 [
	self assert: (grammar expression end parse: 'let x = <ok> in <ok>') equals: #(#(#('x' nil '<ok>')) '<ok>')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLetExpression2 [
	self assert: (grammar expression end parse: 'let x:<ok> = <ok> in <ok>') equals: #(#(#('x' '<ok>' '<ok>')) '<ok>')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLetExpression3 [
	self
		assert: (grammar expression end parse: 'let x:<ok> = <ok>, y=<ok> in <ok>')
		equals: #(#(#('x' '<ok>' '<ok>') #('y' nil '<ok>')) '<ok>')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testLetExpression4 [
	self
		assert: (grammar expression end parse: 'let f:t1->t2 f(x)==y in <ok>')
		equals: #(#(#('f' #() #('t1' 't2') 'f' #(#('x')) 'y' nil nil nil)) '<ok>')
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testLetStatement [
	self assert: (grammar statement end parse: 'let s:nat = 1 in skip') equals: #(#(#('s' 'nat' '1')) nil)
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testMapComprehension1 [
	self
		assert: (grammar expression end parse: '{k1|->v1|k1,v1:t,e in set s&e}')
		equals: #('k1' 'v1' #(#(#('k1' 'v1') 't') #(#('e') 's')) 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testMapComprehension2 [
	self assert: (grammar expression end parse: '{k1|->v1|k1,v1 in set s}') equals: #('k1' 'v1' #(#(#('k1' 'v1') 's')) nil)
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testMapEnumeration1 [
	self assert: (grammar expression end parse: '{|->}') equals: #()
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testMapEnumeration2 [
	self assert: (grammar expression end parse: '{k1|->v1}') equals: #(#('k1' 'v1'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testMapEnumeration3 [
	self assert: (grammar expression end parse: '{k1|->v1,k2|->v2}') equals: #(#('k1' 'v1') #('k2' 'v2'))
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMapEnumerationPattern1 [
	self assert: (grammar pattern end parse: '{|->}') equals: #().
	self assert: (grammar pattern end parse: '{ |-> }') equals: #()
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMapEnumerationPattern2 [
	self assert: (grammar pattern end parse: '{a|->b}') equals: #(#('a' 'b')).
	self assert: (grammar pattern end parse: '{ a |-> b }') equals: #(#('a' 'b'))
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMapEnumerationPattern3 [
	self assert: (grammar pattern end parse: '{a|->b,c|->d}') equals: #(#('a' 'b') #('c' 'd')).
	self assert: (grammar pattern end parse: '{ a |-> b , c |-> d }') equals: #(#('a' 'b') #('c' 'd'))
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMapMunionPattern1 [
	self assert: (grammar pattern end parse: 'a munion b') equals: #(#a #b)
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMapMunionPattern2 [
	self assert: (grammar pattern end parse: 'a munion b munion c') isPetit2Failure
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testMapType1 [
	self assert: (grammar type end parse: 'map t1 to t2') equals: #('t1' 't2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testMapType2 [
	self assert: (grammar type end parse: 'map t1 to map t2 to t3') equals: #('t1' #('t2' 't3'))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testMapType3 [
	self assert: (grammar type end parse: 'map map t1 to t2 to t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMatchValue1 [
	self assert: (grammar pattern end parse: '(<quote>)') equals: '<quote>'
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMatchValue2 [
	self assert: (grammar pattern end parse: 'a') equals: 'a'
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testModule [
	self
		assert: (grammar module end parse: 'module m exports all definitions values v = 1 end m')
		equals: #('m' #(nil 'all') #(#(#(#() #('v' nil '1'))))).
	self assert: (grammar module end parse: 'module m1 exports all definitions values v = 1 end m2') isPetit2Failure
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testModuleBody [
	self assert: (grammar moduleBody end parse: 'definitions values v = 1') equals: #(#(#(#() #('v' nil '1'))))
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testModuledDocument [
	self
		assert:
			(grammar moduledDocument end
				parse: 'module m1 exports all definitions values v = 1 end m1 module m2 exports all  end m2')
		equals: #(#('m1' #(nil 'all') #(#(#(#() #('v' nil '1'))))) #('m2' #(nil 'all') nil))
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMultipleBind1 [
	self assert: (grammar multipleBind end parse: 'v1,v2 in set e') equals: #(#('v1' 'v2') 'e')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMultipleBind2 [
	self assert: (grammar multipleBind end parse: 'v1,v2:e') equals: #(#('v1' 'v2') 'e')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMultipleSetBind1 [
	self assert: (grammar multipleSetBind end parse: 'v1,v2 in set e') equals: #(#('v1' 'v2') 'e')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMultipleTypeBind1 [
	self assert: (grammar multipleTypeBind end parse: 'v1,v2:e') equals: #(#('v1' 'v2') 'e')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testMultipleTypeBind2 [
	self assert: (grammar multipleTypeBind end parse: 'v1 , v2 : e') equals: #(#('v1' 'v2') 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testNarrowExpression2 [
	self assert: (grammar expression end parse: 'narrow_(e)') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testNarrowExpression3 [
	self assert: (grammar expression end parse: 'narrow_()') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testNarrowExpression4 [
	self assert: (grammar expression end parse: 'narrow_(e1,e2,e3)') isPetit2Failure
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testNilLiteral [
	self assert: (grammar symbolicLiteral end parse: 'nil') equals: nil
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testNondeterministicStatement [
	self assert: (grammar statement end parse: '||(return e1, return e2, return e3)') equals: #('e1' 'e2' 'e3')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testOperationExport [
	self
		assert: (grammar operationExport end parse: 'op1, op2, op3 : nat ==> ()')
		equals: #(#('op1' 'op2' 'op3') #('nat' nil))
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testOperationImport [
	self assert: (grammar operationImport end parse: 'op') equals: #('op' nil nil).
	self assert: (grammar operationImport end parse: 'op : () ==> ()') equals: #('op' #(nil nil) nil).
	self assert: (grammar operationImport end parse: 'op1 renamed op2') equals: #('op1' nil 'op2').
	self assert: (grammar operationImport end parse: 'op1: nat ==> nat renamed op2') equals: #('op1' #('nat' 'nat') 'op2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testOptionalType1 [
	self assert: (grammar type end parse: '[t]') equals: 't'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testOptionalType2 [
	self assert: (grammar type end parse: '[ t ]') equals: 't'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testOptionalType3 [
	self assert: (grammar type end parse: '[ ]') isPetit2Failure
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testPartialFunctionType1 [
	self assert: (grammar type end parse: 't1->t2') equals: #('t1' 't2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testPartialFunctionType2 [
	self assert: (grammar type end parse: 't1->t2->t3') equals: #('t1' #('t2' 't3'))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testPartialFunctionType3 [
	self assert: (grammar type end parse: '(t1->t2)->t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testPartialFunctionType4 [
	self assert: (grammar type end parse: 't1 -> t2 -> t3') equals: #('t1' #('t2' 't3'))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testPartialFunctionType5 [
	self assert: (grammar type end parse: 't1*t2->t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testPatternIdentifier1 [
	self assert: (grammar pattern end parse: 'p') equals: 'p'
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testPatternIdentifier2 [
	self assert: (grammar pattern end parse: '-') equals: nil
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testPatternList1 [
	self assert: (grammar patternList end parse: 'p') equals: #('p')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testPatternList2 [
	self assert: (grammar patternList end parse: 'p1,p2') equals: #('p1' 'p2')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testPatternList3 [
	self assert: (grammar patternList end parse: 'p1,p2,p3') equals: #('p1' 'p2' 'p3')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testPatternList4 [
	self assert: (grammar patternList end parse: 'p1 , p2 , p3') equals: #('p1' 'p2' 'p3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testPreconditionExpression1 [
	self assert: (grammar expression end parse: 'pre_(e)') equals: #('e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testPreconditionExpression2 [
	self assert: (grammar expression end parse: 'pre_(e1, e2)') equals: #('e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testPreconditionExpression3 [
	self assert: (grammar expression end parse: 'pre_()') isPetit2Failure
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testProductType1 [
	self assert: (grammar type end parse: 't1*t2') equals: #('t1' 't2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testProductType2 [
	self assert: (grammar type end parse: 't1*t2*t3') equals: #('t1' 't2' 't3')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testProductType3 [
	self assert: (grammar type end parse: '(t1*t2)*t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testProductType4 [
	self assert: (grammar type end parse: '( t1 * t2 ) * t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testQuoteLiteral [
	self assert: (grammar symbolicLiteral end parse: '<quote>') equals: '<quote>'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testQuoteType1 [
	self assert: (grammar type end parse: '<quote>') equals: '<quote>'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testQuoteType2 [
	self assert: (grammar type end parse: '<quo-te>') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordConstructor1 [
	self assert: (grammar expression end parse: 'mk_t()') equals: #(#t #())
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordConstructor2 [
	self assert: (grammar expression end parse: 'mk_t(e1)') equals: #(#t #('e1'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordConstructor3 [
	self assert: (grammar expression end parse: 'mk_t(e1,e2)') equals: #(#t #('e1' 'e2'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordConstructor4 [
	self assert: (grammar expression end parse: 'mk_t(e1,e2,e3)') equals: #(#t #('e1' 'e2' 'e3'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordConstructor5 [
	self assert: (grammar expression end parse: 'mk_t ( e1 , e2 , e3 )') equals: #(#t #('e1' 'e2' 'e3'))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordConstructor6 [
	self assert: (grammar expression end parse: 'mk_ t(e1,e2,e3)') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordModifier1 [
	self assert: (grammar expression end parse: 'mu(e,f1|->e1,f2|->e2)') equals: #('e' #(#('f1' 'e1') #('f2' 'e2')))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordModifier2 [
	self assert: (grammar expression end parse: 'mu(e)') isPetit2Failure
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testRecordPattern1 [
	self assert: (grammar pattern end parse: 'mk_T()') equals: #('T' #())
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testRecordPattern2 [
	self assert: (grammar pattern end parse: 'mk_T(f)') equals: #('T' #('f'))
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testRecordPattern3 [
	self assert: (grammar pattern end parse: 'mk_T(f,-)') equals: #('T' #('f' nil))
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testRecordPattern4 [
	self assert: (grammar pattern end parse: 'mk_T ( f , - )') equals: #('T' #('f' nil))
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testRecordTypeDefinition [
	self
		assert: (grammar recordTypeDefinition end parse: 'T::t1 f2:t2 f3:-t3')
		equals:
			{'T'.
			{'t1'.
			{'f2'.
			't2'}.
			{'f3'.
			't3'}}.
			nil}.
	self
		assert: (grammar recordTypeDefinition end parse: 'T::t1 f2:t2 f3:-t3 inv p == e')
		equals:
			{'T'.
			{'t1'.
			{'f2'.
			't2'}.
			{'f3'.
			't3'}}.
			{'p'.
			'e'}}
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRelations1 [
	#('=' '<>' '<=' '>=' 'subset' 'psubset' 'in set' 'not in set')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2') equals: #('e1' 'e2') ]
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testReqExpression3 [
	self assert: (grammar expression end parse: '#req()') isPetit2Failure
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testReturnStatement [
	self assert: (ViennaVDMGrammar new statement parse: 'return 1') equals: '1'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testSeq1Type1 [
	self assert: (grammar type end parse: 'seq1 of t') equals: 't'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testSeq1Type2 [
	self assert: (grammar type end parse: 'seq1 of seq1 of t') equals: 't'
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSeqConcPattern1 [
	self assert: (grammar pattern end parse: '[]^rest') equals: #(#() 'rest')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSeqConcPattern2 [
	self assert: (grammar pattern end parse: '[] ^ rest') equals: #(#() 'rest')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSeqConcPattern3 [
	self
		assert: (grammar pattern end parse: '[] ^ rest ^ tail')
		equals: #(#() 'rest' 'tail')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSeqEnumPattern1 [
	self assert: (grammar pattern end parse: '[]') equals: #()
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSeqEnumPattern2 [
	self assert: (grammar pattern end parse: '[e]') equals: #('e')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSeqEnumPattern3 [
	self assert: (grammar pattern end parse: '[e1,e2]') equals: #('e1' 'e2')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSeqEnumPattern4 [
	self assert: (grammar pattern end parse: '[ e1 , e2 ]') equals: #('e1' 'e2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testSeqType1 [
	self assert: (grammar type end parse: 'seq of t') equals: 't'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testSeqType2 [
	self assert: (grammar type end parse: 'seq of seq of t') equals: 't'
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceComprehension1 [
	self assert: (grammar expression end parse: '[v1|v1 in set s&v3]') equals: #('v1' #('v1' 's') 'v3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceComprehension2 [
	self assert: (grammar expression end parse: '[v1|v1 in set s]') equals: #('v1' #('v1' 's') nil)
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceComprehension3 [
	self assert: (grammar expression end parse: '[v1|v1:t&v3]') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceComprehension4 [
	self assert: (grammar expression end parse: '[v1|v1,v2 in set s&v3]') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceComprehension5 [
	self assert: (grammar expression end parse: '[v1|v1 in seq s&v3]') equals: #('v1' #('v1' 's') 'v3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceEnumeration1 [
	self assert: (grammar expression end parse: '[]') equals: #()
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceEnumeration2 [
	self assert: (grammar expression end parse: '[e1]') equals: #('e1')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceEnumeration3 [
	self assert: (grammar expression end parse: '[e1,e2]') equals: #('e1' 'e2')
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testSequenceForLoop [
	self assert: (grammar statement end parse: 'for v in e1 do return e2') equals: #('v' 'e1' 'e2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testSet1Type1 [
	self assert: (grammar type end parse: 'set1 of t') equals: 't'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testSet1Type2 [
	self assert: (grammar type end parse: 'set1 of set1 of t') equals: 't'
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSetComprehension1 [
	self
		assert: (grammar expression end parse: '{v1 | v1,v2:t1, v3 in set s & v3}')
		equals: #('v1' #(#(#('v1' 'v2') 't1') #(#('v3') 's')) 'v3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSetComprehension2 [
	self
		assert: (grammar expression end parse: '{v1 | v1,v2:t1, v3 in set s }')
		equals: #('v1' #(#(#('v1' 'v2') 't1') #(#('v3') 's')) nil)
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSetEnumPattern1 [
	self assert: (grammar pattern end parse: '{}') equals: #()
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSetEnumPattern2 [
	self assert: (grammar pattern end parse: '{e}') equals: #('e')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSetEnumPattern3 [
	self assert: (grammar pattern end parse: '{e1,e2}') equals: #('e1' 'e2')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSetEnumPattern4 [
	self assert: (grammar pattern end parse: '{ e1 , e2 }') equals: #('e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSetEnumeration1 [
	self assert: (grammar expression end parse: '{}') equals: #()
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSetEnumeration2 [
	self assert: (grammar expression end parse: '{e1}') equals: #('e1')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSetEnumeration3 [
	self assert: (grammar expression end parse: '{e1,e2}') equals: #('e1' 'e2')
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testSetForLoop [
	self assert: (grammar statement end parse: 'for all v in set e1 do return e2') equals: #('v' 'e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSetRangeExpression1 [
	self assert: (grammar expression end parse: '{s,...,e}') equals: #('s' 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSetRangeExpression2 [
	self assert: (grammar expression end parse: '{ s , ... , e }') equals: #('s' 'e')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testSetType1 [
	self assert: (grammar type end parse: 'set of t') equals: 't'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testSetType2 [
	self assert: (grammar type end parse: 'set of set of t') equals: 't'
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSetUnionPattern1 [
	self assert: (grammar pattern end parse: '{}union rest') equals: #(#() 'rest')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSetUnionPattern2 [
	self assert: (grammar pattern end parse: '{} union rest') equals: #(#() 'rest')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testSetUnionPattern3 [
	self assert: (grammar pattern end parse: '{} union s1 union s2') isPetit2Failure
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testStateDesignator [
	self assert: (grammar stateDesignator end parse: 'n.f1(i).f2(j)') equals: #(#(#(#('n' 'f1') 'i') 'f2') 'j').
	self assert: (grammar stateDesignator end parse: 'n') equals: 'n'
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSubsequence1 [
	self assert: (grammar expression end parse: 's(i1,...,i2)') equals: #('s' 'i1' 'i2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSubsequence2 [
	self assert: (grammar expression end parse: 's(i1,...,i2) ( i3 , ... , i4 )') equals: #(#('s' 'i1' 'i2') 'i3' 'i4')
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testTextLiteral1 [
	self assert: (grammar expression end parse: '"A\101\x41\u0041\""') equals: 'AAAA"'
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testTixeStatement [
	self assert: (grammar statement end parse: 'tixe { p1 |-> skip, p2 |-> return e1 } in return e2') equals: #(('p1' nil 'p2' 'e1') 'e2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTotalFunctionType1 [
	self assert: (grammar type end parse: 't1+>t2') equals: #('t1' 't2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTotalFunctionType2 [
	self assert: (grammar type end parse: 't1+>t2+>t3') equals: #('t1' #('t2' 't3'))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTotalFunctionType3 [
	self assert: (grammar type end parse: '(t1+>t2)+>t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTotalFunctionType4 [
	self assert: (grammar type end parse: 't1 +> t2 +> t3') equals: #('t1' #('t2' 't3'))
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTotalFunctionType5 [
	self assert: (grammar type end parse: 't1*t2+>t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testTrapStatement [
	self
		assert: (grammar statement end parse: 'trap p with return e1 in return e2')
		equals: #('p' 'e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testTupleConstructor1 [
	self assert: (grammar expression end parse: 'mk_(e1,e2)') equals: #('e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testTupleConstructor2 [
	self assert: (grammar expression end parse: 'mk_(e1,e2,e3)') equals: #('e1' 'e2' 'e3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testTupleConstructor3 [
	self assert: (grammar expression end parse: 'mk_ ( e1 , e2 , e3 )') equals: #('e1' 'e2' 'e3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testTupleConstructor4 [
	self assert: (grammar expression end parse: 'mk_(e1)') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testTupleConstructor5 [
	self assert: (grammar expression end parse: 'mk_()') isPetit2Failure
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testTuplePattern1 [
	self assert: (grammar pattern end parse: 'mk_()') isPetit2Failure
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testTuplePattern2 [
	self assert: (grammar pattern end parse: 'mk_(e)') isPetit2Failure
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testTuplePattern3 [
	self assert: (grammar pattern end parse: 'mk_(e1,e2)') equals: #('e1' 'e2')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testTuplePattern4 [
	self assert: (grammar pattern end parse: 'mk_(e1,e2,e3)') equals: #('e1' 'e2' 'e3')
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testTuplePattern5 [
	self assert: (grammar pattern end parse: 'mk_ ( e1 , e2 , e3 )') equals: #('e1' 'e2' 'e3')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testTupleSelect1 [
	self assert: (grammar expression end parse: 'mk_(e1,e2,e3).#3') equals: #(#('e1' 'e2' 'e3') '3')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testTypeExport [
	self assert: (grammar typeExport end parse: 't') equals: #(nil 't').
	self assert: (grammar typeExport end parse: 'struct t') equals: #('struct' 't')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testTypeImport [
	self assert: (grammar typeImport end parse: 't') equals: #('t' nil).
	self assert: (grammar typeImport end parse: 't = nat') equals: #(#('t' 'nat' nil) nil).
	self assert: (grammar typeImport end parse: 't1 renamed t2') equals: #('t1' 't2').
	self assert: (grammar typeImport end parse: 't1 = nat renamed t2') equals: #(#('t1' 'nat' nil) 't2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTypeName1 [
	self assert: (grammar type end parse: 't1') equals: 't1'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTypeName2 [
	self assert: (grammar type end parse: 'm1`t1') equals: #('m1' 't1')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTypeName3 [
	self assert: (grammar type end parse: 'm1 ` t1') equals: #('m1' 't1')
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testTypeSynonym [
	self
		assert: (grammar typeSynonym end parse: 't = t1')
		equals:
			{'t'.
			't1'.
			nil}.
	self
		assert: (grammar typeSynonym end parse: 't = t1 inv p == e')
		equals:
			{'t'.
			't1'.
			{'p'.
			'e'}}
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTypeVariable1 [
	self assert: (grammar type end parse: '@t1') equals: '@t1'
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testTypeVariable2 [
	self assert: (grammar type end parse: '@ t1') equals: '@t1'
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testTypeVariableIdentifier1 [
	self assert: (grammar typeVariableIdentifier end parse: '@v1v') equals: '@v1v'
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testTypeVariableIdentifier2 [
	self assert: (grammar typeVariableIdentifier end parse: '@ v1v') equals: '@v1v'
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testTypeVariableIdentifier3 [
	self assert: (grammar typeVariableIdentifier end parse: '@1v1') isPetit2Failure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testUnaryMinus1 [
	self assert: (grammar expression end parse: '-e') equals: 'e'
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testUnaryMinus2 [
	self assert: (grammar expression end parse: '- e') equals: 'e'
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testUnaryPlus1 [
	self assert: (grammar expression end parse: '+e') equals: 'e'
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testUnaryPlus2 [
	self assert: (grammar expression end parse: '+ e') equals: 'e'
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testUndefined [
	self assert: (grammar expression end parse: 'undefined') equals: nil
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testUnionType1 [
	self assert: (grammar type end parse: 't1|t2') equals: #('t1' 't2')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testUnionType2 [
	self assert: (grammar type end parse: 't1|t2|t3') equals: #('t1' 't2' 't3')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testUnionType3 [
	self assert: (grammar type end parse: 't1 | t2 | t3') equals: #('t1' 't2' 't3')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testUnionType4 [
	self assert: (grammar type end parse: 't1*t2|t3') equals: #(#('t1' 't2') 't3')
]

{ #category : #'tests-types' }
ViennaVDMGrammarTest >> testUnionType5 [
	self assert: (grammar type end parse: 't1|t2*t3') equals: #('t1' #('t2' 't3'))
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testValueDefinition [
	self assert: (grammar valueDefinition end parse: 'v:t=e') equals: #('v' 't' 'e').
	self assert: (grammar valueDefinition end parse: 'v=e') equals: #('v' nil 'e')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testValueExport [
	self assert: (grammar valueExport end parse: 'v1, v2 : nat') equals: #(#('v1' 'v2') 'nat')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testValueImport [
	self assert: (grammar valueImport end parse: 'v') equals: #('v' nil nil).
	self assert: (grammar valueImport end parse: 'v :t') equals: #('v' 't' nil).
	self assert: (grammar valueImport end parse: 'v1 renamed v2') equals: #('v1' nil 'v2').
	self assert: (grammar valueImport end parse: 'v1 : t renamed v2') equals: #('v1' 't' 'v2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testWaitingExpression3 [
	self assert: (grammar expression end parse: '#waiting()') isPetit2Failure
]

{ #category : #'tests-statements' }
ViennaVDMGrammarTest >> testWhileLoop [
	self assert: (grammar statement end parse: 'while e1 do return e2') equals: #('e1' 'e2')
]

{ #category : #'tests-interfaces' }
ViennaVDMGrammarTest >> testimportDefinition [
	self
		assert: (grammar importDefinition end parse: 'from m values v1; v2 functions f ; values v')
		equals: #('m' #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil nil)) #(#('v' nil nil)))).
	self assert: (grammar importDefinition end parse: 'from m all') equals: #('m' 'all')
]
