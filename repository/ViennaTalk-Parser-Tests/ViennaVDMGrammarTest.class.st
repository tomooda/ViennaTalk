Class {
	#name : #ViennaVDMGrammarTest,
	#superclass : #TestCase,
	#instVars : [
		'grammar'
	],
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #running }
ViennaVDMGrammarTest >> setUp [
	grammar := ViennaVDMGrammar new
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testActExpression1 [
	self assert: (grammar expression end parse: '#act(o)') equals: #('o')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testActExpression2 [
	self assert: (grammar expression end parse: '#act(o1, o2)') equals: #('o1' 'o2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testActExpression3 [
	self assert: (grammar expression end parse: '#act()') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testActiveExpression1 [
	self assert: (grammar expression end parse: '#active(o)') equals: #('o')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testActiveExpression2 [
	self assert: (grammar expression end parse: '#active(o1, o2)') equals: #('o1' 'o2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testActiveExpression3 [
	self assert: (grammar expression end parse: '#active()') isPetitFailure
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

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testBooleanLiteral1 [
	self assert: (grammar symbolicLiteral end parse: 'true') equals: true
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testBooleanLiteral2 [
	self assert: (grammar symbolicLiteral end parse: 'false') equals: false
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testCasesExpression1 [
	self
		assert: (grammar expression end parse: 'cases e:p11,p12->e1,p2->e2,others->default end')
		equals: #('e' #(#(#('p11' 'p12') 'e1') #(#('p2') 'e2')) 'default')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testCasesExpression2 [
	self assert: (grammar expression end parse: 'cases e:p1->e1 end') equals: #('e' #(#(#('p1') 'e1')) nil)
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testCasesExpression3 [
	self assert: (grammar expression end parse: 'cases e:others->default end') isPetitFailure
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
	self assert: (grammar expression end parse: '''ab''') isPetitFailure
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
	self assert: (grammar expression end parse: 'exists1 v1,v2:t1, v3:t2 & e') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testExistsExpression1 [
	self
		assert: (grammar expression end parse: 'exists v1,v2:t1, v3:t2 & e')
		equals: #(#(#(#('v1' 'v2') 't1') #(#('v3') 't2')) 'e')
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testExplicitFunctionDefinition1 [
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 f(x) == y pre b1 post b2 measure f2')
		equals: #('f' #('@t') #('t1' 't2') 'f' #(#('x')) 'y' 'b1' 'b2' 'f2')
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testExplicitFunctionDefinition2 [
	self
		assert: (grammar functionDefinition end parse: 'f[@t] : t1 -> t2 -> t3 f(x)(y) == z pre b1 post b2 measure f2')
		equals: #('f' #('@t') #('t1' #('t2' 't3')) 'f' #(#('x') #('y')) 'z' 'b1' 'b2' 'f2')
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testExplicitFunctionDefinition3 [
	self
		assert: (grammar functionDefinition end parse: 'f: t1->t2 f(x) == y')
		equals: #('f' #() #('t1' 't2') 'f' #(#('x')) 'y' nil nil nil)
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
ViennaVDMGrammarTest >> testFinExpression1 [
	self assert: (grammar expression end parse: '#fin(o)') equals: #('o')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testFinExpression2 [
	self assert: (grammar expression end parse: '#fin(o1, o2)') equals: #('o1' 'o2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testFinExpression3 [
	self assert: (grammar expression end parse: '#fin()') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testForallExpression1 [
	self
		assert: (grammar expression end parse: 'forall v1,v2:t1, v3:t2 & e')
		equals: #(#(#(#('v1' 'v2') 't1') #(#('v3') 't2')) 'e')
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
	self assert: (grammar expression end parse: 'f[]') isPetitFailure
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
	self assert: (grammar identifier end parse: '1v1') isPetitFailure
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testIdentifier3 [
	self assert: (grammar identifier end parse: 'mk_t') isPetitFailure
]

{ #category : #'tests-symbols' }
ViennaVDMGrammarTest >> testIdentifier4 [
	self assert: (grammar identifier end parse: 'lambda') isPetitFailure
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

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIotaExpression1 [
	self assert: (grammar expression end parse: 'iota v1 in set s & e') equals: #(#('v1' 's') 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIotaExpression2 [
	self assert: (grammar expression end parse: 'iota v1, v2 in set s & e') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression1 [
	self assert: (grammar expression end parse: 'is_t(e)') equals: #('t' 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression2 [
	self assert: (grammar expression end parse: 'is_t(e1, e2)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression3 [
	self assert: (grammar expression end parse: 'is_ t(e1)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression4 [
	self assert: (grammar expression end parse: 'is_bool(e)') equals: #('bool' 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression5 [
	self assert: (grammar expression end parse: 'is_bool(e1, e2)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression6 [
	self assert: (grammar expression end parse: 'is_ bool(e)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression7 [
	self assert: (grammar expression end parse: 'is_(e, t)') = #('e' 't')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsExpression8 [
	self assert: (grammar expression end parse: 'is_(e1, e2, e3)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsofbaseclassExpression1 [
	self assert: (grammar expression end parse: 'isofbaseclass(t, e)') equals: #('t' 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testIsofclassExpression1 [
	self assert: (grammar expression end parse: 'isofclass(t, e)') equals: #('t' 'e')
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
	self assert: (grammar expression end parse: 'lambda v1,v2:t&e') isPetitFailure
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
	self assert: (grammar pattern end parse: 'a munion b munion c') isPetitFailure
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
ViennaVDMGrammarTest >> testNarrowExpression [
	self assert: (grammar expression end parse: 'narrow_(e,t)') equals: #('e' 't')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testNarrowExpression2 [
	self assert: (grammar expression end parse: 'narrow_(e)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testNarrowExpression3 [
	self assert: (grammar expression end parse: 'narrow_()') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testNarrowExpression4 [
	self assert: (grammar expression end parse: 'narrow_(e1,e2,e3)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testNewExpression1 [
	self assert: (grammar expression end parse: 'new t()') equals: #('t' #())
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testNewExpression2 [
	self assert: (grammar expression end parse: 'new t(e1, e2, e3)') equals: #('t' #('e1' 'e2' 'e3'))
]

{ #category : #'tests-literals' }
ViennaVDMGrammarTest >> testNilLiteral [
	self assert: (grammar symbolicLiteral end parse: 'nil') equals: nil
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testObjectPattern1 [
	self assert: (grammar pattern end parse: 'obj_T()') equals: #('T' #())
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testObjectPattern2 [
	self assert: (grammar pattern end parse: 'obj_T(f|->-)') equals: #('T' #(#('f' nil)))
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testObjectPattern3 [
	self assert: (grammar pattern end parse: 'obj_T(f1|->-,f2|->v1)') equals: #('T' #(#('f1' nil) #('f2' 'v1')))
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testObjectPattern4 [
	self assert: (grammar pattern end parse: 'obj_T (f1 |-> - , f2 |-> v1 )') equals: #('T' #(#('f1' nil) #('f2' 'v1')))
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
	self assert: (grammar type end parse: '[ ]') isPetitFailure
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
	self assert: (grammar expression end parse: 'pre_()') isPetitFailure
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
	self assert: (grammar type end parse: '<quo-te>') isPetitFailure
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
	self assert: (grammar expression end parse: 'mk_ t(e1,e2,e3)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordModifier1 [
	self assert: (grammar expression end parse: 'mu(e,f1|->e1,f2|->e2)') equals: #('e' #(#('f1' 'e1') #('f2' 'e2')))
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRecordModifier2 [
	self assert: (grammar expression end parse: 'mu(e)') isPetitFailure
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

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testRelations1 [
	#('=' '<>' '<=' '>=' 'subset' 'psubset' 'in set' 'not in set')
		do: [ :op | self assert: (grammar expression end parse: 'e1 ' , op , ' e2') equals: #('e1' 'e2') ]
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testReqExpression1 [
	self assert: (grammar expression end parse: '#req(o)') equals: #('o')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testReqExpression2 [
	self assert: (grammar expression end parse: '#req(o1, o2)') equals: #('o1' 'o2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testReqExpression3 [
	self assert: (grammar expression end parse: '#req()') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSamebaseclassExpression1 [
	self assert: (grammar expression end parse: 'samebaseclass(e1, e2)') equals: #('e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSameclassExpression1 [
	self assert: (grammar expression end parse: 'sameclass(e1, e2)') equals: #('e1' 'e2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSelfExpression [
	self assert: (grammar expression parse: 'self') equals: nil
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
	self assert: (grammar pattern end parse: '[] ^ rest ^ tail') isPetitFailure
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
	self assert: (grammar expression end parse: '[v1|v1:t&v3]') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testSequenceComprehension4 [
	self assert: (grammar expression end parse: '[v1|v1,v2 in set s&v3]') isPetitFailure
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
	self assert: (grammar pattern end parse: '{} union s1 union s2') isPetitFailure
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

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testTimeExpression [
	self assert: (grammar expression parse: 'time') equals: nil
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
	self assert: (grammar expression end parse: 'mk_(e1)') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testTupleConstructor5 [
	self assert: (grammar expression end parse: 'mk_()') isPetitFailure
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testTuplePattern1 [
	self assert: (grammar pattern end parse: 'mk_()') isPetitFailure
]

{ #category : #'tests-patterns' }
ViennaVDMGrammarTest >> testTuplePattern2 [
	self assert: (grammar pattern end parse: 'mk_(e)') isPetitFailure
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
	self assert: (grammar typeVariableIdentifier end parse: '@1v1') isPetitFailure
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
ViennaVDMGrammarTest >> testValueDefinition1 [
	self assert: (grammar valueDefinition end parse: 'v:t=e') equals: #('v' 't' 'e')
]

{ #category : #'tests-definitions' }
ViennaVDMGrammarTest >> testValueDefinition2 [
	self assert: (grammar valueDefinition end parse: 'v=e') equals: #('v' nil 'e')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testWaitingExpression2 [
	self assert: (grammar expression end parse: '#waiting(o1, o2)') equals: #('o1' 'o2')
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testWaitingExpression3 [
	self assert: (grammar expression end parse: '#waiting()') isPetitFailure
]

{ #category : #'tests-expressions' }
ViennaVDMGrammarTest >> testWatitingExpression1 [
	self assert: (grammar expression end parse: '#waiting(o)') equals: #('o')
]
