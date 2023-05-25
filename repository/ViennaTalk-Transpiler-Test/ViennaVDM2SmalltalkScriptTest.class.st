Class {
	#name : #ViennaVDM2SmalltalkScriptTest,
	#superclass : #TestCase,
	#traits : 'TViennaVDMBoundVariableCollectorTestCase + TViennaVDMFreeVariableCollectorTestCase',
	#classTraits : 'TViennaVDMBoundVariableCollectorTestCase classTrait + TViennaVDMFreeVariableCollectorTestCase classTrait',
	#category : #'ViennaTalk-Transpiler-Test'
}

{ #category : #private }
ViennaVDM2SmalltalkScriptTest >> evaluate: aString [
	^ OpalCompiler new
		source: aString;
		evaluate
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testAlwaysStatementEnv [
	self
		assert:
			(self
				evaluate:
					' | a | ['
						,
							(ViennaVDM2SmalltalkScript new
								generate: (ViennaVDMParser new statement parse: 'always a := 2 in return 1'))
						, '] value')
		equals: 1.
	self
		assert:
			(self
				evaluate:
					' | a | ['
						,
							(ViennaVDM2SmalltalkScript new
								generate: (ViennaVDMParser new statement parse: 'always a := 2 in return 1'))
						, '] value. a')
		equals: 2.
	self
		assert:
			(self
				evaluate:
					' | a | ['
						,
							(ViennaVDM2SmalltalkScript new
								generate: (ViennaVDMParser new statement parse: 'always a := 2 in exit 1'))
						, '] on: ViennaException do: [:ex | ex return]. a')
		equals: 2
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testAndEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'x and y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaAndNode.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'true').
						  ('y' -> 'false') } asDictionary))
		equals: false.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'true').
						  ('y' -> 'true') } asDictionary))
		equals: true.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'false').
						  ('y' -> self undefined) } asDictionary))
		equals: false.
	self
		should: [
			self evaluate:
				(ViennaVDM2SmalltalkScript new generate: node env: {
						 ('x' -> 'true').
						 ('y' -> self undefined) } asDictionary) ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testApplyEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '{1|->2}(1)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaApplyNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 2
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testArithmeticAbsEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'abs -1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaArithmeticAbsNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testArithmeticDivideEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '3 / 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaArithmeticDivideNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 1.5
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testArithmeticIntegerDivisionEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '3 div 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaArithmeticIntegerDivisionNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testArithmeticMinusEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '3 - 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaArithmeticMinusNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testArithmeticModEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '3 mod 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaArithmeticModNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testArithmeticMultiplicationEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '3 * 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaArithmeticMultiplicationNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 6
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testArithmeticPlusEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '3 + 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaArithmeticPlusNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 5
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testArithmeticRemEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '3 rem 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaArithmeticRemNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 1
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testAssignStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'x := 1'.
	self deny: node isPetit2Failure.
	self assert: node label = 'AssignStatement'.
	self assert: (self evaluate: '|x|' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 1
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testBasicTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'int'.
	self deny: node isPetit2Failure.
	self assert: node label = 'BasicType'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType int
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testBlockStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: '(dcl x:nat := 1, y:nat; y := 2; a := x + y)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'BlockStatement'.
	self assert: (self evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node) , '. a') equals: 3
]

{ #category : #'tests-bound variables-patterns and binds' }
ViennaVDM2SmalltalkScriptTest >> testBoundVariablesSetUnionPatternInto [
	| node binds |
	node := ViennaVDMParser new setUnionPattern end parse: '{v1, v2} union {v3}'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SetUnionPattern'.
	binds := Set new.
	ViennaVDM2SmalltalkScript new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			'v2'.
			'v3'} asSet
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testCallStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'op(1)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'CallStatement'.
	self
		assert: (self evaluate: '|op x| x:= 0. op := [:a | x := a]. ' , (ViennaVDM2SmalltalkScript new generate: node) , '.x')
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testCasesExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'cases 1: []^x -> <seq>, {}^x -> <set>, x -> x + 2, others -> undefined end'.
	self deny: node isPetit2Failure.
	self assert: node isViennaCasesExpressionNode.
	self
		assert:
		(self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testCasesStatementEnv [
	| node |
	node := ViennaVDMParser new statement end
		parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set>, x -> a:=x + 2, others -> a:=undefined end'.
	self deny: node isPetit2Failure.
	self assert: node label = 'CasesStatement'.
	self assert: (self evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node) , '.a') equals: 3.
	node := ViennaVDMParser new statement end parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set>, others -> a:=1 end'.
	self deny: node isPetit2Failure.
	self assert: node label = 'CasesStatement'.
	self assert: (self evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node) , '.a') equals: 1.
	node := ViennaVDMParser new statement end parse: 'cases 1: []^x -> a:=<seq>, {}^x -> a:=<set> end'.
	self deny: node isPetit2Failure.
	self assert: node label = 'CasesStatement'.
	self should: [ self evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node) , '.a' ] raise: ViennaNoMatch
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testCompositeTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'compose T of x:nat y:-int char end'.
	self deny: node isPetit2Failure.
	self assert: node label = 'CompositeType'.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
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
ViennaVDM2SmalltalkScriptTest >> testCompositionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '(lambda x:nat & x + 1) comp (lambda x:nat & x * 2)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaCompositionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node) , ' value: 3')
		equals: 7
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testDclStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: '(dcl x:nat := 1, y:nat; y := 2; a := x + y)'.
	self deny: node isPetit2Failure.
	self assert: node first label = 'DclStatement'.
	self assert: (self evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node) , '. a') equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testDefExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'def  y : nat = x + 1; x : nat = 1 in x + y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDefExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 3.
	node := ViennaVDMParser new expression end parse:
		        'def  mk_(x, y) = mk_(1, 2) in x + y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDefExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testDefStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'def x : nat = 1; y : nat = x + 1 in a := x + y'.
	self deny: node isPetit2Failure.
	self assert: node label = 'DefStatement'.
	self assert: (self evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) , '.a') equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testDistributedMapMergeEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'merge {{1|->2}, {2|->3}}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDistributedMapMergeNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> 2).
				(2 -> 3) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testDistributedSequenceConcatenationEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'conc [[1,2,3],[4,5,6]]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDistributedSequenceConcatenationNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 1. 2. 3. 4. 5. 6 } asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testDistributedSetIntersectionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'dinter {{1,2,3},{2,3,4}}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDistributedSetIntersectionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 2. 3 } asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testDistributedSetUnionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'dunion {{1,2,3},{2,3,4}}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaDistributedSetUnionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 1. 2. 3. 4 } asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testEqualEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '1 = 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse: '1 = 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testExists1ExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'exists1 x in set {1,2} & x mod 2 = 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExists1ExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse:
		        'exists1 x in set {1,2,3} & x mod 2 = 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExists1ExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse:
		        'exists1 x in set {1,2} & x = 3'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExists1ExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testExistsExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'exists x in set {1,2}, y in set { 2, 3 } & x = y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExistsExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse:
		        'exists x in set {1,2,3}, y in set {2,3,4} & x = y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExistsExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse:
		        'exists x in set {1,2}, y in set {3,4} & x = y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaExistsExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testExitStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'exit 1'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ExitStatement'.
	self
		should: [ self evaluate: (ViennaVDM2SmalltalkScript new generate: node) ]
		raise: ViennaException
		withExceptionDo: [ :ex | self assert: ex expression equals: 1 ]
]

{ #category : #'tests-code generation-definitions' }
ViennaVDM2SmalltalkScriptTest >> testExtendedExplicitFunction [
	| code |
	code := ViennaVDM2SmalltalkScript new
		translate:
			'
	functions 
	succ(x:int) res:int == x + 1
	post res = x + 1;'
		ifError: [ self fail ].
	self assert: (self evaluate: code , '. succ value: 0') equals: 1.
	self assert: (self evaluate: code , '. post_succ value: 0 value: 1').
	self deny: (self evaluate: code , '. post_succ value: 0 value: 2')
]

{ #category : #'tests-code generation-definitions' }
ViennaVDM2SmalltalkScriptTest >> testExtendedExplicitOperation [
	| code |
	code := ViennaVDM2SmalltalkScript new
		translate:
			'
	operations 
	succ(x:int) res:int == return x + 1
	post res = x + 1;'
		ifError: [ self fail ].
	self assert: (self evaluate: code , '. succ value: 0') equals: 1.
	self
		assert: (self evaluate: code , '. post_succ value: 0 value: 1 value: nil value: nil').
	self deny: (self evaluate: code , '. post_succ value: 0 value: 2 value: nil value: nil')
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testFieldReferenceEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'x.f := 1'.
	self deny: node isPetit2Failure.
	self assert: node first label = 'FieldReference'.
	self
		assert:
			(self
				evaluate:
					'|x|x:=(ViennaComposite constructorName:''T'' with: nil with: 2) fieldNameAt: 1 put: ''f''; yourself.'
						, (ViennaVDM2SmalltalkScript new generate: node) , '. {x at: 1. x at: 2}')
		equals:
			{1.
			2}
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testFieldSelectEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'x.field'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFieldSelectNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env:
						  { ('x'
						   -> ((ViennaComposite constructorName: 'T' with: 1 with: 2)
								    fieldNameAt: 1 put: 'field';
								    fieldNameAt: 2 put: 'field2';
								    storeString)) } asDictionary))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testFinitePowerSetEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'power {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFinitePowerSetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: (Set
				 with: Set new
				 with: (Set with: 1)
				 with: (Set with: 2)
				 with: (Set with: 1 with: 2))
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testFloorEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'floor 1.5'.
	self deny: node isPetit2Failure.
	self assert: node isViennaFloorNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testForallExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'forall x in set {1, 3, 5}, y in set {2, 4, 6} & x mod 2 = y mod 2 + 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaForallExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse:
		        'forall x in set {1, 2, 3} & x mod 2 = 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaForallExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testGreaterThanEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '1 > 0'.
	self deny: node isPetit2Failure.
	self assert: node isViennaGreaterThanNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse: '1 > 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaGreaterThanNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse: '1 > 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaGreaterThanNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testGreaterThanOrEqualEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '1 >= 0'.
	self deny: node isPetit2Failure.
	self assert: node isViennaGreaterThanOrEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse: '1 >= 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaGreaterThanOrEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse: '1 >= 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaGreaterThanOrEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testIfExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'if x > 0 then <positive> elseif x = 0 then <zero> else <negative>'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIfExpressionNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env: { ('x' -> '1') } asDictionary))
		equals: #positive.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env: { ('x' -> '0') } asDictionary))
		equals: #zero.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env: { ('x' -> '-1') } asDictionary))
		equals: #negative
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testIfStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'if true then x := x + 1'.
	self deny: node isPetit2Failure.
	self assert: node label = 'IfStatement'.
	self assert: (self evaluate: '|x| x:= 0.' , (ViennaVDM2SmalltalkScript new generate: node) , '.x') equals: 1.
	node := ViennaVDMParser new statement end parse: 'if false then x := 1 elseif true then x := 2 else x := 3'.
	self deny: node isPetit2Failure.
	self assert: node label = 'IfStatement'.
	self assert: (self evaluate: '|x|' , (ViennaVDM2SmalltalkScript new generate: node) , '.x') equals: 2
]

{ #category : #'tests-code generation-definitions' }
ViennaVDM2SmalltalkScriptTest >> testImplicitFunctionPostcondition [
	| code |
	code := ViennaVDM2SmalltalkScript new
		translate:
			'
	functions 
	succ(x:int) res:int
	post res = x + 1;'
		ifError: [ self fail ].
	self
		should: [ self evaluate: code , '. succ value: 1' ]
		raise: ViennaImplicitEvaluationError.
	self assert: (self evaluate: code , '. post_succ value: 0 value: 1').
	self deny: (self evaluate: code , '. post_succ value: 0 value: 2')
]

{ #category : #'tests-code generation-definitions' }
ViennaVDM2SmalltalkScriptTest >> testImplicitOperationPostcondition [
	| code |
	code := ViennaVDM2SmalltalkScript new
		translate:
			'
	state S of
		v : int
		init s == s = mk_S(0)
	end
	operations 
	succ(x:int) res:int
	post res = x + 1;'
		ifError: [ self fail ].
	self
		should: [ self evaluate: code , '. succ value: 1' ]
		raise: ViennaImplicitEvaluationError.
	self
		assert:
			(self
				evaluate: code , '. post_succ value: 0 value: 1 value: (S value: 0) value: (S value: 0)').
	self
		deny:
			(self
				evaluate: code , '. post_succ value: 0 value: 2 value: (S value: 0) value: (S value: 0)')
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testImplyEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'x => y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaImplyNode.
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'false')} asDictionary))
		equals: false.
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'true')} asDictionary))
		equals: true.
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> 'false')} asDictionary))
		equals: true.
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'false').
							('y' -> self undefined)} asDictionary))
		equals: true.
	self
		should: [ 
			self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('x' -> 'true').
							('y' -> self undefined)} asDictionary) ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testInSetEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '1 in set {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaInSetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse: '0 in set {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaInSetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testIndexForLoop [
	| node |
	node := ViennaVDMParser new statement end parse: 'for i = 1 to 10 by 2 do x := x + i'.
	self deny: node isPetit2Failure.
	self assert: node label = 'IndexForLoop'.
	self
		assert: (self evaluate: '|x| x:= 0.' , (ViennaVDM2SmalltalkScript new generate: node) , '.x')
		equals: 1 + 3 + 5 + 7 + 9
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testInmapTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'inmap nat to int'.
	self deny: node isPetit2Failure.
	self assert: node label = 'InmapType'.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: (ViennaType nat inmapTo: ViennaType int)
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testIotaExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'iota x in set {3, 4} & x mod 2 = 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIotaExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 3.
	node := ViennaVDMParser new expression end parse:
		        'iota x in set {2, 4} & x mod 2 = 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIotaExpressionNode.
	self
		should: [
			self evaluate:
				(ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) ]
		raise: ViennaNoMatch
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testIsBasicExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'is_nat(1)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIsBasicExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse: 'is_nat(-1)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIsBasicExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testIsNameExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'is_T(1)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIsNameExpressionNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env: { ('T' -> 'ViennaType nat') } asDictionary))
		equals: true.
	node := ViennaVDMParser new expression end parse: 'is_T(-1)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIsNameExpressionNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env: { ('T' -> 'ViennaType nat') } asDictionary))
		equals: false
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testIsNotYetSpecifiedEnv [
	| node |
	node := ViennaVDMParser new explicitFunctionDefinition end parse: 'f:t1->t2 f(x) == is not yet specified'.
	self deny: node isPetit2Failure.
	node := node at: 6.
	self assert: node label = 'IsNotYetSpecified'.
	self
		should: [ self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) ]
		raise: NotYetImplemented
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testIterateEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1|->2, 2|->3, 3|->4, 4|->5, 5|->1} ** 3'.
	self deny: node isPetit2Failure.
	self assert: node isViennaIterateNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> 4).
				(2 -> 5).
				(3 -> 1).
				(4 -> 2).
				(5 -> 3) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testLambdaExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'lambda x:nat, mk_(y, z):nat*nat & x + y + z'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLambdaExpressionNode.
	self
		assert:
			(self evaluate: (ViennaVDM2SmalltalkScript new generate: node)
				 , ' value: 1 value: {2 . 3}')
		equals: 6
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testLessThanEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '1 < 0'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLessThanNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse: '1 < 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLessThanNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse: '1 < 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLessThanNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testLessThanOrEqualEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '1 <= 0'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLessThanOrEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse: '1 <= 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLessThanOrEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse: '1 <= 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLessThanOrEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testLetBeExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'let x in set {1,2} be st x mod 2 = 0 in x + 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLetBeExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testLetBeStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'let x in set {1,2} be st x mod 2 = 0 in a := x + 1'.
	self deny: node isPetit2Failure.
	self assert: node label = 'LetBeStatement'.
	self
		assert: (self evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) , '. a')
		equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testLetExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'let x:nat = y+1, y:nat = 2, f:nat->nat f(n)==n+1 in f(x * y)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLetExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 7
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testLetStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'let x:nat = y+1, y:nat = 2, f:nat->nat f(n)==n+1 in a:=f(x * y)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'LetStatement'.
	self assert: (self evaluate: '|a|' , (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) , '.a') equals: 7
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testLocalNameEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'x'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLocalNameNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env: { ('x' -> '1') } asDictionary))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testLogicalEquivalenceEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'x <=> y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaLogicalEquivalenceNode.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'true').
						  ('y' -> 'true') } asDictionary))
		equals: true.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'true').
						  ('y' -> 'false') } asDictionary))
		equals: false.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'false').
						  ('y' -> 'true') } asDictionary))
		equals: false.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'false').
						  ('y' -> 'false') } asDictionary))
		equals: true.
	self
		should: [
			self evaluate:
				(ViennaVDM2SmalltalkScript new generate: node env: {
						 ('x' -> 'false').
						 ('y' -> self undefined) } asDictionary) ]
		raise: ViennaUndefinedEvaluationError.
	self
		should: [
			self evaluate:
				(ViennaVDM2SmalltalkScript new generate: node env: {
						 ('x' -> 'true').
						 ('y' -> self undefined) } asDictionary) ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapComprehensionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{i |-> i mod 5 + 1 | i in set {1,...,10} & i <= 5}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapComprehensionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> 2).
				(2 -> 3).
				(3 -> 4).
				(4 -> 5).
				(5 -> 1) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapDomainEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'dom {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapDomainNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 1. 2. 3 } asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapDomainRestrictedByEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{3} <-: {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapDomainRestrictedByNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> #one).
				(2 -> #two) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapDomainRestrictedToEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{2, 3} <: {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapDomainRestrictedToNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(2 -> #two).
				(3 -> #three) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapEnumerationEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapEnumerationNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> #one).
				(2 -> #two).
				(3 -> #three) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapEnumerationPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x |-> 1, 2 |-> y } = { 1 |-> 1, 2 |-> 2 } in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first label = 'MapEnumerationPattern'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapInverseEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'inverse {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapInverseNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(#one -> 1).
				(#two -> 2).
				(#three -> 3) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapMergeEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1|-><one>, 2|-><two>} munion {3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapMergeNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> #one).
				(2 -> #two).
				(3 -> #three) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapMunionPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x|->y } munion { 10|->20 } = { 1 |-> 2, 10 |-> 20} in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first label = 'MapMunionPattern'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapOrSequenceModifyEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1|-><one>, 2|-><two>, 3|->3} ++ {3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapOrSequenceModifyNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> #one).
				(2 -> #two).
				(3 -> #three) } asDictionary.
	node := ViennaVDMParser new expression end parse:
		        '[<one>, <two>, <many>] ++ {3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapOrSequenceModifyNode.

	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { #one. #two. #three } asOrderedCollection
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testMapOrSequenceReferenceEnv [

	| node |
	node := ViennaVDMParser new statement end parse: 'x("key") := 1'.
	self deny: node isPetit2Failure.
	self assert: node first isViennaMapOrSequenceReferenceNode.
	self
		assert:
			(self evaluate: '|x|x:={''key''->nil. 2 -> 2} asDictionary.'
				 , (ViennaVDM2SmalltalkScript new generate: node)
				 , '. {x at: ''key''. x at: 2}')
		equals: { 1. 2 }.
	node := ViennaVDMParser new statement end parse: 'x(1) := 1'.
	self deny: node isPetit2Failure.
	self assert: node first isViennaMapOrSequenceReferenceNode.
	self
		assert: (self evaluate: '|x|x:={nil . 2} asOrderedCollection.'
				 , (ViennaVDM2SmalltalkScript new generate: node)
				 , '. {x at: 1. x at: 2}')
		equals: { 1. 2 }
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapRangeEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'rng {1|-><one>, 2|-><two>, 3|-><three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapRangeNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { #one. #two. #three } asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapRangeRestrictedByEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1|-><one>, 2|-><two>, 3|-><three>} :-> {<three>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapRangeRestrictedByNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> #one).
				(2 -> #two) } asDictionary
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMapRangeRestrictedToEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1|-><one>, 2|-><two>, 3|-><three>} :> {<one>, <two>}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaMapRangeRestrictedToNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: {
				(1 -> #one).
				(2 -> #two) } asDictionary
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testMapTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'map nat to int'.
	self deny: node isPetit2Failure.
	self assert: node label = 'MapType'.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: (ViennaType nat mapTo: ViennaType int)
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testMatchValueEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  ({10|->20}) munion { x|->y } = { 1 |-> 2, 10 |-> 20} in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first first label = 'MatchValue'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testMultipleAssignStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'atomic(x:= y; y:= x)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'MultipleAssignStatement'.
	self
		assert: (self evaluate: '|x y| x := 1. y := 2. ' , (ViennaVDM2SmalltalkScript new generate: node) , '. {x . y}')
		equals:
			{2.
			1}
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testNondeterministicStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: '||(a := a union {1}, a := a union {2}, a := a union {3})'.
	self deny: node isPetit2Failure.
	self assert: node label = 'NondeterministicStatement'.
	self
		assert: (self evaluate: '|a| a := Set new.' , (ViennaVDM2SmalltalkScript new generate: node) , '. a')
		equals: #(1 2 3) asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testNotEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'not true'.
	self deny: node isPetit2Failure.
	self assert: node isViennaNotNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse: 'not false'.
	self deny: node isPetit2Failure.
	self assert: node isViennaNotNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testNotEqualEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '1 <> 1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaNotEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse: '1 <> 2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaNotEqualNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testNotInSetEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '1 not in set {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaNotInSetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse:
		        '0 not in set {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaNotInSetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testOldNameEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'x~'.
	self deny: node isPetit2Failure.
	self assert: node isViennaOldNameNode.
	self
		assert:
			(self evaluate:
				 '|_oldState|_oldState := {''x'' -> 1} asDictionary. '
				 ,
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 1
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testOptionalTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: '[nat]'.
	self deny: node isPetit2Failure.
	self assert: node label = 'OptionalType'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat optional
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testOrEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'x or y'.
	self deny: node isPetit2Failure.
	self assert: node isViennaOrNode.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'true').
						  ('y' -> 'true') } asDictionary))
		equals: true.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'true').
						  ('y' -> 'false') } asDictionary))
		equals: true.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'false').
						  ('y' -> 'true') } asDictionary))
		equals: true.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'false').
						  ('y' -> 'false') } asDictionary))
		equals: false.
	self
		should: [
			self evaluate:
				(ViennaVDM2SmalltalkScript new generate: node env: {
						 ('x' -> 'false').
						 ('y' -> self undefined) } asDictionary) ]
		raise: ViennaUndefinedEvaluationError.
	self
		assert:
			(self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: {
						  ('x' -> 'true').
						  ('y' -> self undefined) } asDictionary))
		equals: true
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testPartialFunctionTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int -> real'.
	self deny: node isPetit2Failure.
	self assert: node label = 'PartialFunctionType'.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: ViennaType nat * ViennaType int -> ViennaType real
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testProductTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ProductType'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat * ViennaType int
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testProperSubsetEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1,2} psubset {1,2,3}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaProperSubsetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse:
		        '{1,2} psubset {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaProperSubsetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false.
	node := ViennaVDMParser new expression end parse:
		        '{1,2,3} psubset {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaProperSubsetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testQuoteTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: '<quote>'.
	self deny: node isPetit2Failure.
	self assert: node label = 'QuoteType'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: (ViennaType quote: #quote)
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testRecordConstructorEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'mk_T(1,2)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaRecordConstructorNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env:
						  { ('T'
						   -> (ViennaCompositeType constructorName: 'T' withAll: {
									    {
										    'f1'.
										    false.
										    ViennaType nat }.
									    {
										    'f2'.
										    false.
										    ViennaType nat } }) storeString) } asDictionary))
		equals: ((ViennaComposite constructorName: 'T' with: 1 with: 2)
				 fieldNameAt: 1 put: 'f1';
				 fieldNameAt: 2 put: 'f2';
				 yourself)
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testRecordModifierEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        'mu(mk_T(1,2), f1|->11, f2|->12)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaRecordModifierNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env:
						  { ('T'
						   -> (ViennaCompositeType constructorName: 'T' withAll: {
									    {
										    'f1'.
										    false.
										    ViennaType nat }.
									    {
										    'f2'.
										    false.
										    ViennaType nat } }) storeString) } asDictionary))
		equals: ((ViennaComposite constructorName: 'T' with: 11 with: 12)
				 fieldNameAt: 1 put: 'f1';
				 fieldNameAt: 2 put: 'f2';
				 yourself)
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkScriptTest >> testRecordPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  mk_T(x, y) = mk_T(1, 2) in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first label = 'RecordPattern'.
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: node
						env:
							{('T' -> '(ViennaType compose: ''T'' of: {{nil. false. (ViennaType nat)}. {nil. false. (ViennaType nat)}})')}
								asDictionary))
		equals: 3
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testRecordTypeDefinitionEnv [
	| node |
	node := ViennaVDMParser new recordTypeDefinition end parse: 'T :: x:nat y:-int char'.
	self deny: node isPetit2Failure.
	self assert: node label = 'RecordTypeDefinition'.
	self
		assert: (self evaluate: '| T |' , (ViennaVDM2SmalltalkScript new generate: node))
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
ViennaVDM2SmalltalkScriptTest >> testResultExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'RESULT'.
	self deny: node isPetit2Failure.
	self assert: node isViennaResultExpressionNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new
					  generate: node
					  env: { ('RESULT' -> '1') } asDictionary))
		equals: 1
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testReturnStatementEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'return 1'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ReturnStatement'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: 1
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testSeq1TypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'seq1 of nat'.
	self deny: node isPetit2Failure.
	self assert: node label = 'Seq1Type'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat seq1
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkScriptTest >> testSeqConcPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  [x]^[y] = [1, 2] in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first label = 'SeqConcPattern'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkScriptTest >> testSeqEnumPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  [x, y] = [1, 2] in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first label = 'SeqEnumPattern'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testSeqTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'seq of nat'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SeqType'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat seq
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceComprehensionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '[i*2| i in set {1,...,5}]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceComprehensionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 2. 4. 6. 8. 10 } asOrderedCollection.
	node := ViennaVDMParser new expression end parse:
		        '[i*2| i in set {1,...,5} & i mod 2 = 0]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceComprehensionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 4. 8 } asOrderedCollection.
	node := ViennaVDMParser new expression end parse:
		        '[i*2| i in set {1,2,3,4,5}]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceComprehensionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 2. 4. 6. 8. 10 } asOrderedCollection.
	node := ViennaVDMParser new expression end parse:
		        '[i*2| i in set {1,2,3,4,5} & i mod 2 = 0]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceComprehensionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 4. 8 } asOrderedCollection.
	node := ViennaVDMParser new expression end parse:
		        '[i*2| i in seq [ 5,4,3,2,1 ] & i mod 2 = 0]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceComprehensionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 8. 4 } asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceConcatenateEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '[1,2,3]^[4,5,6]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceConcatenateNode.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals:
			{1.
			2.
			3.
			4.
			5.
			6} asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceElementsEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'elems [4,5,6]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceElementsNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 4. 5. 6 } asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceEnumerationEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '[4,5,6]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceEnumerationNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 4. 5. 6 } asOrderedCollection
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testSequenceForLoopEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'for i in [5,6,7] do x := x + i'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SequenceForLoop'.
	self assert: (self evaluate: '|x|x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 18.
	node := ViennaVDMParser new statement end parse: 'for mk_(i,j) in [mk_(1, 2), mk_(2, 3)] do x := x + i*j'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SequenceForLoop'.
	self assert: (self evaluate: '|x|x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 8
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceHeadEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'hd [4,5,6]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceHeadNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 4
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceIndicesEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'inds [4,5,6]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceIndicesNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 1. 2. 3 } asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceLengthEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'len [4,5,6]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceLengthNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceReverseEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'reverse [4,5,6]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceReverseNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 6. 5. 4 } asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSequenceTailEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'tl [4,5,6]'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSequenceTailNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 5. 6 } asOrderedCollection
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testSet1TypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'set1 of nat'.
	self deny: node isPetit2Failure.
	self assert: node label = 'Set1Type'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat set1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSetCardinalityEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'card {4, 5, 6}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetCardinalityNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSetComprehensionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{i*j| i, j in set {1,...,5} & i mod 2 = 0 and j mod 2 = 0}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetComprehensionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 4. 8. 16 } asSet.
	node := ViennaVDMParser new expression end parse:
		        '{i*j| mk_(i,j) in set { mk_(1, 2), mk_(2, 3), mk_(3, 4) } & i <= 2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetComprehensionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 2. 6 } asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSetDifferenceEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1,2,3} \ {2, 3, 4}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetDifferenceNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 1 } asSet
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkScriptTest >> testSetEnumPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x, y } = { 1, 2 } in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first label = 'SetEnumPattern'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSetEnumerationEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '{4,5,6}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetEnumerationNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 4. 5. 6 } asSet
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testSetForLoopEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'for all i in set {5,6,7} do x := x + i'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SetForLoop'.
	self assert: (self evaluate: '|x|x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 18.
	node := ViennaVDMParser new statement end parse: 'for all mk_(i, j) in set {mk_(1, 2), mk_(2, 3)} do x := x + i*j'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SetForLoop'.
	self assert: (self evaluate: '|x|x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 8.
	node := ViennaVDMParser new statement end parse: 'for all s in set power { 1,...,3 } do x := x + 1'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SetForLoop'.
	self assert: (self evaluate: '|x|x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 8
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSetIntersectionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1,2,3} inter {2, 3, 4}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetIntersectionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 2. 3 } asSet
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSetRangeExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '{1,...,4}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetRangeExpressionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 1. 2. 3. 4 } asSet
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testSetTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'set of nat'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SetType'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat set
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSetUnionEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1,2,3} union {2, 3, 4}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSetUnionNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 1. 2. 3. 4 } asSet
]

{ #category : #'tests-code generation-patterns' }
ViennaVDM2SmalltalkScriptTest >> testSetUnionPatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  { x } union { y } = { 1, 2 } in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first label = 'SetUnionPattern'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSubsequenceEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '[4,5,6,7,8](2,...,4)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSubsequenceNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 5. 6. 7 } asOrderedCollection
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testSubsetEnv [

	| node |
	node := ViennaVDMParser new expression end parse:
		        '{1,2} subset {1,2,3}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSubsetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse:
		        '{1,2} subset {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSubsetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse:
		        '{1,2,3} subset {1,2}'.
	self deny: node isPetit2Failure.
	self assert: node isViennaSubsetNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testTixeStatementEnv [
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: (ViennaVDMParser new statement parse: 'tixe { mk_(-, -) |-> return 1, p |-> return p+2 } in exit 3')))
		equals: 5.

]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testTokenConstructorEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'mk_token(1)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTokenConstructorNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: (ViennaToken with: 1)
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testTotalFunctionTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'nat * int +> real'.
	self deny: node isPetit2Failure.
	self assert: node label = 'TotalFunctionType'.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node))
		equals: ViennaType nat * ViennaType int +> ViennaType real
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testTrapStatementEnv [
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: (ViennaVDMParser new statement parse: 'trap p with return p in exit 1')))
		equals: 1.
	self
		assert:
			(self
				evaluate:
					(ViennaVDM2SmalltalkScript new
						generate: (ViennaVDMParser new statement parse: 'trap - with return 1 in exit nil')))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testTupleConstructorEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'mk_(1,2,3)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTupleConstructorNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: { 1. 2. 3 }
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testTuplePatternEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  mk_(x, y) = mk_(1, 2) in x + y'.
	self deny: node isPetit2Failure.
	self assert: node first first first label = 'TuplePattern'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testTupleSelectEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'mk_(4, 5, 6).#2'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTupleSelectNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 5
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testTypeJudgementEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'is_(1, nat)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTypeJudgementNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: true.
	node := ViennaVDMParser new expression end parse: 'is_(-1, nat)'.
	self deny: node isPetit2Failure.
	self assert: node isViennaTypeJudgementNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: false
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testTypeNameEnv [
	| node |
	node := ViennaVDMParser new type end parse: 't'.
	self deny: node isPetit2Failure.
	self assert: node label = 'TypeName'.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('t' -> 'ViennaType nat')} asDictionary))
		equals: ViennaType nat
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testTypeVariableEnv [
	| node |
	node := ViennaVDMParser new type end parse: '@t'.
	self deny: node isPetit2Failure.
	self assert: node label = 'TypeVariable'.
	self
		assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node env: {('@t' -> 'ViennaType nat')} asDictionary))
		equals: ViennaType nat
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testUnaryMinusEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '-1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaUnaryMinusNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: -1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testUnaryPlusEnv [

	| node |
	node := ViennaVDMParser new expression end parse: '+1'.
	self deny: node isPetit2Failure.
	self assert: node isViennaUnaryPlusNode.
	self
		assert: (self evaluate:
				 (ViennaVDM2SmalltalkScript new generate: node env: Dictionary new))
		equals: 1
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkScriptTest >> testUndefinedExpressionEnv [

	| node |
	node := ViennaVDMParser new expression end parse: 'undefined'.
	self deny: node isPetit2Failure.
	self assert: node isViennaUndefinedExpressionNode.
	self
		should: [
			self evaluate:
				(ViennaVDM2SmalltalkScript new generate: node env: Dictionary new) ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-code generation-types' }
ViennaVDM2SmalltalkScriptTest >> testUnionTypeEnv [
	| node |
	node := ViennaVDMParser new type end parse: 'nat | int'.
	self deny: node isPetit2Failure.
	self assert: node label = 'UnionType'.
	self assert: (self evaluate: (ViennaVDM2SmalltalkScript new generate: node)) equals: ViennaType nat | ViennaType int
]

{ #category : #'tests-code generation-statements' }
ViennaVDM2SmalltalkScriptTest >> testWhileLoopEnv [
	| node |
	node := ViennaVDMParser new statement end parse: 'while i <= 7 do (x := x + i; i := i + 1)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'WhileLoop'.
	self assert: (self evaluate: '|i x|i := 5. x:=0.' , (ViennaVDM2SmalltalkScript new generate: node) , '. x') equals: 18
]

{ #category : #private }
ViennaVDM2SmalltalkScriptTest >> undefined [
	^ ViennaVDM2SmalltalkScript new generate: (ViennaVDMParser new expression parse: 'undefined')
]
