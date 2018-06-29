Class {
	#name : #ViennaVDM2SmalltalkTest,
	#superclass : #TestCase,
	#traits : 'TViennaVDMBoundVariableCollectorTest + TViennaVDMFreeVariableCollectorTest',
	#classTraits : 'TViennaVDMBoundVariableCollectorTest classTrait + TViennaVDMFreeVariableCollectorTest classTrait',
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testAndEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'x and y'.
	self deny: node isPetitFailure.
	self assert: node label = 'And'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'false')} asDictionary))
		equals: false.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> self undefined)} asDictionary))
		equals: false.
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> self undefined)} asDictionary) ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testApplyEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1|->2}(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Apply'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 2
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testArithmeticAbsEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'abs -1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticAbs'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testArithmeticDivideEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '3 / 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticDivide'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1.5
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testArithmeticIntegerDivisionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '3 div 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticIntegerDivision'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testArithmeticMinusEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '3 - 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticMinus'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testArithmeticModEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '3 mod 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticMod'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testArithmeticMultiplicationEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '3 * 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticMultiplication'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 6
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testArithmeticPlusEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '3 + 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticPlus'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 5
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testArithmeticRemEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '3 rem 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ArithmeticRem'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testAssignStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'x := 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'AssignStatement'.
	self assert: (Compiler evaluate: '|x|' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 1
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testBasicTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'int'.
	self deny: node isPetitFailure.
	self assert: node label = 'BasicType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType int
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testBlockStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: '(dcl x:nat := 1, y:nat; y := 2; a := x + y)'.
	self deny: node isPetitFailure.
	self assert: node label = 'BlockStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '. a') equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testCallStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'op(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'CallStatement'.
	self
		assert: (Compiler evaluate: '|op x| x:= 0. op := [:a | x := a]. ' , (ViennaVDM2Smalltalk new generate: node) , '.x')
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testCasesExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end
		parse: 'cases 1: []^x -> <seq>, {}^x -> <set>, x -> x + 2, others -> undefined end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testCasesStatementEnv [
	| node |
	node := ViennaVDMParser new statement end
		parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set>, x -> a:=x + 2, others -> a:=undefined end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '.a') equals: 3.
	node := ViennaVDMParser new statement end parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set>, others -> a:=1 end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '.a') equals: 1.
	node := ViennaVDMParser new statement end parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set> end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CasesStatement'.
	self should: [ Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '.a' ] raise: ViennaNoMatch
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testCompositeTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'compose T of x:nat y:-int char end'.
	self deny: node isPetitFailure.
	self assert: node label = 'CompositeType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals:
			(ViennaType
				compose: 'T'
				of:
					{{'x'.
					false.
					(ViennaType nat)}.
					{'y'.
					true.
					(ViennaType int)}.
					{nil.
					false.
					(ViennaType char)}})
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testCompositionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '(lambda x:nat & x + 1) comp (lambda x:nat & x * 2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Composition'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node) , ' value: 3') equals: 7
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testDclStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: '(dcl x:nat := 1, y:nat; y := 2; a := x + y)'.
	self deny: node isPetitFailure.
	self assert: node first label = 'DclStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node) , '. a') equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testDefExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  y : nat = x + 1; x : nat = 1 in x + y'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3.
	node := ViennaVDMParser new expression end parse: 'def  mk_(x, y) = mk_(1, 2) in x + y'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testDefStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'def x : nat = 1; y : nat = x + 1 in a := x + y'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node env: Dictionary new) , '.a') equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testDistributedMapMergeEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'merge {{1|->2}, {2|->3}}'.
	self deny: node isPetitFailure.
	self assert: node label = 'DistributedMapMerge'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> 2).
			(2 -> 3)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testDistributedSequenceConcatenationEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'conc [[1,2,3],[4,5,6]]'.
	self deny: node isPetitFailure.
	self assert: node label = 'DistributedSequenceConcatenation'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4.
			5.
			6} asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testDistributedSetIntersectionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'dinter {{1,2,3},{2,3,4}}'.
	self deny: node isPetitFailure.
	self assert: node label = 'DistributedSetIntersection'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			3} asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testDistributedSetUnionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'dunion {{1,2,3},{2,3,4}}'.
	self deny: node isPetitFailure.
	self assert: node label = 'DistributedSetUnion'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4} asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testEqualEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '1 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'Equal'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 = 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'Equal'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testExists1ExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'exists1 x in set {1,2} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'Exists1Expression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'exists1 x in set {1,2,3} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'Exists1Expression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: 'exists1 x in set {1,2} & x = 3'.
	self deny: node isPetitFailure.
	self assert: node label = 'Exists1Expression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testExistsExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'exists x in set {1,2}, y in set { 2, 3 } & x = y'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExistsExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'exists x in set {1,2,3}, y in set {2,3,4} & x = y'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExistsExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'exists x in set {1,2}, y in set {3,4} & x = y'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExistsExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testFieldReferenceEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'x.f := 1'.
	self deny: node isPetitFailure.
	self assert: node first label = 'FieldReference'.
	self
		assert:
			(Compiler
				evaluate:
					'|x|x:=(ViennaComposite constructorName:''T'' with: nil with: 2) fieldNameAt: 1 put: ''f''; yourself.'
						, (ViennaVDM2Smalltalk new generate: node) , '. {x at: 1. x at: 2}')
		equals:
			{1.
			2}
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testFieldSelectEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'x.field'.
	self deny: node isPetitFailure.
	self assert: node label = 'FieldSelect'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x'
								->
									((ViennaComposite constructorName: 'T' with: 1 with: 2)
										fieldNameAt: 1 put: 'field';
										fieldNameAt: 2 put: 'field2';
										storeString))} asDictionary))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testFinitePowerSetEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'power {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'FinitePowerSet'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			(Set
				with: Set new
				with: (Set with: 1)
				with: (Set with: 2)
				with: (Set with: 1 with: 2))
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testFloorEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'floor 1.5'.
	self deny: node isPetitFailure.
	self assert: node label = 'Floor'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testForallExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end
		parse: 'forall x in set {1, 3, 5}, y in set {2, 4, 6} & x mod 2 = y mod 2 + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ForallExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'forall x in set {1, 2, 3} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ForallExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testGreaterThanEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '1 > 0'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThan'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 > 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThan'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '1 > 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThan'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testGreaterThanOrEqualEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '1 >= 0'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 >= 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 >= 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'GreaterThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testIfExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'if x > 0 then <positive> elseif x = 0 then <zero> else <negative>'.
	self deny: node isPetitFailure.
	self assert: node label = 'IfExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('x' -> '1')} asDictionary))
		equals: #positive.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('x' -> '0')} asDictionary))
		equals: #zero.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('x' -> '-1')} asDictionary))
		equals: #negative
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testIfStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'if true then x := x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'IfStatement'.
	self assert: (Compiler evaluate: '|x| x:= 0.' , (ViennaVDM2Smalltalk new generate: node) , '.x') equals: 1.
	node := ViennaVDMParser new statement end parse: 'if false then x := 1 elseif true then x := 2 else x := 3'.
	self deny: node isPetitFailure.
	self assert: node label = 'IfStatement'.
	self assert: (Compiler evaluate: '|x|' , (ViennaVDM2Smalltalk new generate: node) , '.x') equals: 2
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testImplyEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'x => y'.
	self deny: node isPetitFailure.
	self assert: node label = 'Imply'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'false')} asDictionary))
		equals: false.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'false')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> self undefined)} asDictionary))
		equals: true.
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> self undefined)} asDictionary) ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testInSetEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '1 in set {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'InSet'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '0 in set {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'InSet'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testIndexForLoop [
	| node |
	node := ViennaVDMParser new statement end parse: 'for i = 1 to 10 by 2 do x := x + i'.
	self deny: node isPetitFailure.
	self assert: node label = 'IndexForLoop'.
	self
		assert: (Compiler evaluate: '|x| x:= 0.' , (ViennaVDM2Smalltalk new generate: node) , '.x')
		equals: 1 + 3 + 5 + 7 + 9
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testInmapTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'inmap nat to int'.
	self deny: node isPetitFailure.
	self assert: node label = 'InmapType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals: (ViennaType nat inmapTo: ViennaType int)
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testIotaExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'iota x in set {3, 4} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'IotaExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3.
	node := ViennaVDMParser new expression end parse: 'iota x in set {2, 4} & x mod 2 = 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'IotaExpression'.
	self should: [ Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new) ] raise: ViennaNoMatch
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testIsBasicExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'is_nat(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IsBasicExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'is_nat(-1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IsBasicExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testIsNameExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'is_T(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IsNameExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('T' -> 'ViennaType nat')} asDictionary))
		equals: true.
	node := ViennaVDMParser new expression end parse: 'is_T(-1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'IsNameExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('T' -> 'ViennaType nat')} asDictionary))
		equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testIsNotYetSpecifiedEnv [
	| node |
	node := ViennaVDMParser new explicitFunctionDefinition end parse: 'f:t1->t2 f(x) == is not yet specified'.
	self deny: node isPetitFailure.
	node := node at: 6.
	self assert: node label = 'IsNotYetSpecified'.
	self
		should: [ Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new) ]
		raise: NotYetImplemented
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testIsSubclassResponsibilityEnv [
	| node |
	node := ViennaVDMParser new explicitFunctionDefinition end parse: 'f:t1->t2 f(x) == is subclass responsibility'.
	self deny: node isPetitFailure.
	node := node at: 6.
	self assert: node label = 'IsSubclassResponsibility'.
	self
		should: [ Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new) ]
		raise: SubclassResponsibility
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testIterateEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1|->2, 2|->3, 3|->4, 4|->5, 5|->1} ** 3'.
	self deny: node isPetitFailure.
	self assert: node label = 'Iterate'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> 4).
			(2 -> 5).
			(3 -> 1).
			(4 -> 2).
			(5 -> 3)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testLambdaExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'lambda x:nat, mk_(y, z):nat*nat & x + y + z'.
	self deny: node isPetitFailure.
	self assert: node label = 'LambdaExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node) , ' value: 1 value: {2 . 3}') equals: 6
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testLessThanEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '1 < 0'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThan'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '1 < 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThan'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '1 < 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThan'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testLessThanOrEqualEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '1 <= 0'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '1 <= 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '1 <= 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'LessThanOrEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testLetBeExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'let x in set {1,2} be st x mod 2 = 0 in x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetBeExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testLetBeStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'let x in set {1,2} be st x mod 2 = 0 in a := x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetBeStatement'.
	self
		assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node env: Dictionary new) , '. a')
		equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testLetExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'let x:nat = y+1, y:nat = 2, f:nat->nat f(n)==n+1 in f(x * y)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 7
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testLetStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'let x:nat = y+1, y:nat = 2, f:nat->nat f(n)==n+1 in a:=f(x * y)'.
	self deny: node isPetitFailure.
	self assert: node label = 'LetStatement'.
	self assert: (Compiler evaluate: '|a|' , (ViennaVDM2Smalltalk new generate: node env: Dictionary new) , '.a') equals: 7
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testLocalNameEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'x'.
	self deny: node isPetitFailure.
	self assert: node label = 'LocalName'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('x' -> '1')} asDictionary)) equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testLogicalEquivalenceEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'x <=> y'.
	self deny: node isPetitFailure.
	self assert: node label = 'LogicalEquivalence'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'false')} asDictionary))
		equals: false.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'true')} asDictionary))
		equals: false.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'false')} asDictionary))
		equals: true.
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> self undefined)} asDictionary) ]
		raise: ViennaUndefinedEvaluationError.
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> self undefined)} asDictionary) ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapComprehensionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{i |-> i mod 5 + 1 | i in set {1,...,10} & i <= 5}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> 2).
			(2 -> 3).
			(3 -> 4).
			(4 -> 5).
			(5 -> 1)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapDomainEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'dom {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapDomain'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3} asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapDomainRestrictedByEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{3} <-: {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapDomainRestrictedBy'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapDomainRestrictedToEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{2, 3} <: {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapDomainRestrictedTo'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(2 -> #two).
			(3 -> #three)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapEnumerationEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapEnumeration'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two).
			(3 -> #three)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapEnumerationPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x |-> 1, 2 |-> y } = { 1 |-> 1, 2 |-> 2 } in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'MapEnumerationPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapInverseEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'inverse {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapInverse'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(#one -> 1).
			(#two -> 2).
			(#three -> 3)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapMergeEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>} munion {3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapMerge'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two).
			(3 -> #three)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapMunionPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x|->y } munion { 10|->20 } = { 1 |-> 2, 10 |-> 20} in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'MapMunionPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapOrSequenceModifyEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>, 3|->3} ++ {3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapOrSequenceModify'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two).
			(3 -> #three)} asDictionary.
	node := ViennaVDMParser new expression end parse: '[<one>, <two>, <many>] ++ {3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapOrSequenceModify'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{#one.
			#two.
			#three} asOrderedCollection
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testMapOrSequenceReferenceEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'x("key") := 1'.
	self deny: node isPetitFailure.
	self assert: node first label = 'MapOrSequenceReference'.
	self
		assert:
			(Compiler
				evaluate:
					'|x|x:={''key''->nil. 2 -> 2} asDictionary.' , (ViennaVDM2Smalltalk new generate: node) , '. {x at: ''key''. x at: 2}')
		equals:
			{1.
			2}.
	node := ViennaVDMParser new statement end parse: 'x(1) := 1'.
	self deny: node isPetitFailure.
	self assert: node first label = 'MapOrSequenceReference'.
	self
		assert:
			(Compiler
				evaluate: '|x|x:={nil . 2} asOrderedCollection.' , (ViennaVDM2Smalltalk new generate: node) , '. {x at: 1. x at: 2}')
		equals:
			{1.
			2}
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapRangeEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'rng {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapRange'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{#one.
			#two.
			#three} asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapRangeRestrictedByEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>, 3|-><three>} :-> {<three>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapRangeRestrictedBy'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two)} asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMapRangeRestrictedToEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1|-><one>, 2|-><two>, 3|-><three>} :> {<one>, <two>}'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapRangeRestrictedTo'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{(1 -> #one).
			(2 -> #two)} asDictionary
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testMapTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'map nat to int'.
	self deny: node isPetitFailure.
	self assert: node label = 'MapType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals: (ViennaType nat mapTo: ViennaType int)
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testMatchValueEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  ({10|->20}) munion { x|->y } = { 1 |-> 2, 10 |-> 20} in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first first label = 'MatchValue'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testMultipleAssignStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'atomic(x:= y; y:= x)'.
	self deny: node isPetitFailure.
	self assert: node label = 'MultipleAssignStatement'.
	self
		assert: (Compiler evaluate: '|x y| x := 1. y := 2. ' , (ViennaVDM2Smalltalk new generate: node) , '. {x . y}')
		equals:
			{2.
			1}
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testNondeterministicStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: '||(a := a union {1}, a := a union {2}, a := a union {3})'.
	self deny: node isPetitFailure.
	self assert: node label = 'NondeterministicStatement'.
	self
		assert: (Compiler evaluate: '|a| a := Set new.' , (ViennaVDM2Smalltalk new generate: node) , '. a')
		equals: #(1 2 3) asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testNotEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'not true'.
	self deny: node isPetitFailure.
	self assert: node label = 'Not'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: 'not false'.
	self deny: node isPetitFailure.
	self assert: node label = 'Not'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testNotEqualEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '1 <> 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'NotEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '1 <> 2'.
	self deny: node isPetitFailure.
	self assert: node label = 'NotEqual'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testNotInSetEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '1 not in set {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'NotInSet'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '0 not in set {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'NotInSet'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testOldNameEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'x~'.
	self deny: node isPetitFailure.
	self assert: node label = 'OldName'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('x~' -> '1')} asDictionary)) equals: 1
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testOptionalTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: '[nat]'.
	self deny: node isPetitFailure.
	self assert: node label = 'OptionalType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat optional
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testOrEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'x or y'.
	self deny: node isPetitFailure.
	self assert: node label = 'Or'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'false')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'false')} asDictionary))
		equals: false.
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> self undefined)} asDictionary) ]
		raise: ViennaUndefinedEvaluationError.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> self undefined)} asDictionary))
		equals: true
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testPartialFunctionTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int -> real'.
	self deny: node isPetitFailure.
	self assert: node label = 'PartialFunctionType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals: ViennaType nat * ViennaType int -> ViennaType real
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testProductTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProductType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat * ViennaType int
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testProperSubsetEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2} psubset {1,2,3}'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProperSubset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '{1,2} psubset {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProperSubset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false.
	node := ViennaVDMParser new expression end parse: '{1,2,3} psubset {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'ProperSubset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testQuoteTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: '<quote>'.
	self deny: node isPetitFailure.
	self assert: node label = 'QuoteType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: (ViennaType quote: #quote)
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testRecordConstructorEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'mk_T(1,2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordConstructor'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('T'
								->
									(ViennaCompositeType
										constructorName: 'T'
										withAll:
											{{'f1'.
											false.
											(ViennaType nat)}.
											{'f2'.
											false.
											(ViennaType nat)}}) storeString)} asDictionary))
		equals:
			((ViennaComposite constructorName: 'T' with: 1 with: 2)
				fieldNameAt: 1 put: 'f1';
				fieldNameAt: 2 put: 'f2';
				yourself)
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testRecordModifierEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'mu(mk_T(1,2), f1|->11, f2|->12)'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordModifier'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('T'
								->
									(ViennaCompositeType
										constructorName: 'T'
										withAll:
											{{'f1'.
											false.
											(ViennaType nat)}.
											{'f2'.
											false.
											(ViennaType nat)}}) storeString)} asDictionary))
		equals:
			((ViennaComposite constructorName: 'T' with: 11 with: 12)
				fieldNameAt: 1 put: 'f1';
				fieldNameAt: 2 put: 'f2';
				yourself)
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkTest >> testRecordPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  mk_T(x, y) = mk_T(1, 2) in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'RecordPattern'.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2Smalltalk new
						generate: node
						env:
							{('T' -> '(ViennaType compose: ''T'' of: {{nil. false. (ViennaType nat)}. {nil. false. (ViennaType nat)}})')}
								asDictionary))
		equals: 3
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testRecordTypeDefinitionEnv [
	| node |
	node := ViennaVDMParser new recordTypeDefinition end parse: 'T :: x:nat y:-int char'.
	self deny: node isPetitFailure.
	self assert: node label = 'RecordTypeDefinition'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals:
			(ViennaType
				compose: 'T'
				of:
					{{'x'.
					false.
					(ViennaType nat)}.
					{'y'.
					true.
					(ViennaType int)}.
					{nil.
					false.
					(ViennaType char)}})
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testResultExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'RESULT'.
	self deny: node isPetitFailure.
	self assert: node label = 'ResultExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('RESULT' -> '1')} asDictionary))
		equals: 1
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testReturnStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'return 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'ReturnStatement'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: 1
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testSeq1TypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'seq1 of nat'.
	self deny: node isPetitFailure.
	self assert: node label = 'Seq1Type'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat seq1
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkTest >> testSeqConcPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  [x]^[y] = [1, 2] in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'SeqConcPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkTest >> testSeqEnumPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  [x, y] = [1, 2] in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'SeqEnumPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testSeqTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'seq of nat'.
	self deny: node isPetitFailure.
	self assert: node label = 'SeqType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat seq
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceComprehensionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '[i*2| i in set {1,...,5}]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			4.
			6.
			8.
			10} asOrderedCollection.
	node := ViennaVDMParser new expression end parse: '[i*2| i in set {1,...,5} & i mod 2 = 0]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			8} asOrderedCollection.
	node := ViennaVDMParser new expression end parse: '[i*2| i in set {1,2,3,4,5}]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			4.
			6.
			8.
			10} asOrderedCollection.
	node := ViennaVDMParser new expression end parse: '[i*2| i in set {1,2,3,4,5} & i mod 2 = 0]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			8} asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceConcatenateEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '[1,2,3]^[4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceConcatenate'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4.
			5.
			6} asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceElementsEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'elems [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceElements'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			5.
			6} asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceEnumerationEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '[4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceEnumeration'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			5.
			6} asOrderedCollection
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testSequenceForLoopEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'for i in [5,6,7] do x := x + i'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 18.
	node := ViennaVDMParser new statement end parse: 'for mk_(i,j) in [mk_(1, 2), mk_(2, 3)] do x := x + i*j'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 8
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceHeadEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'hd [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceHead'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 4
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceIndicesEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'inds [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceIndices'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3} asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceLengthEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'len [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceLength'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceReverseEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'reverse [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceReverse'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{6.
			5.
			4} asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSequenceTailEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'tl [4,5,6]'.
	self deny: node isPetitFailure.
	self assert: node label = 'SequenceTail'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{5.
			6} asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSetCardinalityEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'card {4, 5, 6}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetCardinality'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSetComprehensionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{i*j| i, j in set {1,...,5} & i mod 2 = 0 and j mod 2 = 0}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			8.
			16} asSet.
	node := ViennaVDMParser new expression end parse: '{i*j| mk_(i,j) in set { mk_(1, 2), mk_(2, 3), mk_(3, 4) } & i <= 2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetComprehension'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			6} asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSetDifferenceEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2,3} \ {2, 3, 4}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetDifference'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: {1} asSet
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkTest >> testSetEnumPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x, y } = { 1, 2 } in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'SetEnumPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSetEnumerationEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{4,5,6}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetEnumeration'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{4.
			5.
			6} asSet
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testSetForLoopEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'for all i in set {5,6,7} do x := x + i'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 18.
	node := ViennaVDMParser new statement end parse: 'for all mk_(i, j) in set {mk_(1, 2), mk_(2, 3)} do x := x + i*j'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetForLoop'.
	self assert: (Compiler evaluate: '|x|x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 8
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSetIntersectionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2,3} inter {2, 3, 4}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetIntersection'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{2.
			3} asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSetRangeExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1,...,4}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetRangeExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4} asSet
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testSetTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'set of nat'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat set
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSetUnionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2,3} union {2, 3, 4}'.
	self deny: node isPetitFailure.
	self assert: node label = 'SetUnion'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4} asSet
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkTest >> testSetUnionPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x } union { y } = { 1, 2 } in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'SetUnionPattern'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSubsequenceEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '[4,5,6,7,8](2,...,4)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Subsequence'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{5.
			6.
			7} asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testSubsetEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '{1,2} subset {1,2,3}'.
	self deny: node isPetitFailure.
	self assert: node label = 'Subset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '{1,2} subset {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'Subset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: '{1,2,3} subset {1,2}'.
	self deny: node isPetitFailure.
	self assert: node label = 'Subset'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testTokenConstructorEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'mk_token(1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TokenConstructor'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals: (ViennaToken with: 1)
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testTotalFunctionTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int +> real'.
	self deny: node isPetitFailure.
	self assert: node label = 'TotalFunctionType'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node))
		equals: ViennaType nat * ViennaType int +> ViennaType real
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testTupleConstructorEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'mk_(1,2,3)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TupleConstructor'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3}
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testTuplePatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  mk_(x, y) = mk_(1, 2) in x + y'.
	self deny: node isPetitFailure.
	self assert: node first first first label = 'TuplePattern'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testTupleSelectEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'mk_(4, 5, 6).#2'.
	self deny: node isPetitFailure.
	self assert: node label = 'TupleSelect'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 5
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testTypeJudgementEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'is_(1, nat)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeJudgement'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: true.
	node := ViennaVDMParser new expression end parse: 'is_(-1, nat)'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeJudgement'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: false
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testTypeNameEnv [
	| node |
	node := ViennaVDMParser new type end parse: 't'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeName'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('t' -> 'ViennaType nat')} asDictionary))
		equals: ViennaType nat
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testTypeVariableEnv [
	| node |
	node := ViennaVDMParser new type end parse: '@t'.
	self deny: node isPetitFailure.
	self assert: node label = 'TypeVariable'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('@t' -> 'ViennaType nat')} asDictionary))
		equals: ViennaType nat
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testUnaryMinusEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '-1'.
	self deny: node isPetitFailure.
	self assert: node label = 'UnaryMinus'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: -1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testUnaryPlusEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '+1'.
	self deny: node isPetitFailure.
	self assert: node label = 'UnaryPlus'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testUndefinedExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'undefined'.
	self deny: node isPetitFailure.
	self assert: node label = 'UndefinedExpression'.
	self
		should: [ Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new) ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkTest >> testUnionTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'nat | int'.
	self deny: node isPetitFailure.
	self assert: node label = 'UnionType'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node)) equals: ViennaType nat | ViennaType int
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkTest >> testWhileLoopEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'while i <= 7 do (x := x + i; i := i + 1)'.
	self deny: node isPetitFailure.
	self assert: node label = 'WhileLoop'.
	self assert: (Compiler evaluate: '|i x|i := 5. x:=0.' , (ViennaVDM2Smalltalk new generate: node) , '. x') equals: 18
]

{ #category : #private }
ViennaVDM2SmalltalkTest >> undefined [
	^ ViennaVDM2Smalltalk new generate: (ViennaVDMParser new expression parse: 'undefined')
]
