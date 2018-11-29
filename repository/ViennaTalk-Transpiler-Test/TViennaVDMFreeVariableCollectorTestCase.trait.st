Trait {
	#name : #TViennaVDMFreeVariableCollectorTestCase,
	#category : 'ViennaTalk-Transpiler-Test'
}

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesAssignmentDefinitionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new assignmentDefinition end parse: 'v1:t1 := e1'.
	self deny: node isPetit2Failure.
	self assert: node label = 'AssignmentDefinition'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'e1'} asSet
]

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesBlockStatementBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new blockStatement end parse: '(dcl v1:t1 := e1; dcl v2:t2 := f(v1); op(v1, v2))'.
	self deny: node isPetit2Failure.
	self assert: node label = 'BlockStatement'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'e1'.
			't2'.
			'f'.
			'op'} asSet
]

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesCasesExpressionAlternativeBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new casesStatementAlternative end parse: 'p1 munion p2, p1 union p2 -> op(p1, p2)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'CasesStatementAlternative'.
	binds := Set new.
	self assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new) equals: {'op'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesDefExpressionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new defExpression end parse: 'def v1 : t1 = f(v2) ; v2 : t2 = e1 in f(v1, v2)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'DefExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'f'.
			't2'.
			'e1'.
			'f'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesExists1ExpressionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new exists1Expression end parse: 'exists1 v:t & p(v, e)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'Exists1Expression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			'p'.
			'e'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesExistsExpressionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new existsExpression end parse: 'exists v1:t, v2 in set s & p(v1, v2, e)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ExistsExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			's'.
			'p'.
			'e'} asSet
]

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesFieldReferenceBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new indexForLoop end parse: 'for v = e1 to e2 by e3 do op(v)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'IndexForLoop'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'e1'.
			'e2'.
			'e3'.
			'op'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesFieldSelectBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new expression end parse: 'record.field'.
	self deny: node isPetit2Failure.
	self assert: node label = 'FieldSelect'.
	binds := Set new.
	self assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new) equals: {'record'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesForallExpressionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new forallExpression end parse: 'forall v1:t, v2 in set s & p(v1, v2, e)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'ForallExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			's'.
			'p'.
			'e'} asSet
]

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesIndexForLoopBoundVarsInto [
	| node |
	node := ViennaVDMParser new indexForLoop end parse: 'for v = e1 to e2 by e3 do op(v)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'IndexForLoop'.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'e1'.
			'e2'.
			'e3'.
			'op'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesIotaExpressionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new iotaExpression end parse: 'iota v:t & p(v, e)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'IotaExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			'p'.
			'e'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesLambdaExpressionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new lambdaExpression end parse: 'lambda v : t & f(v)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'LambdaExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t'.
			'f'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesLetBeExpressionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new letBeExpression end parse: 'let v in set s be st p(v) in f(v)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'LetBeExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'s'.
			'p'.
			'f'} asSet
]

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesLetBeStatementBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new letBeStatement end parse: 'let v in set s be st p(v) in op(v)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'LetBeStatement'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'s'.
			'p'.
			'op'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesLetExpressionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new letExpression end parse: 'let v1 : t1 = f(v2), v2 : t2 = e in g(v1, v2)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'LetExpression'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'f'.
			't2'.
			'e'.
			'g'} asSet
]

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesLetStatementBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new letStatement end parse: 'let v1 : t1 =e, v2 : t2 = f(v1) in op(v1, v2)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'LetStatement'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'t1'.
			'f'.
			't2'.
			'e'.
			'op'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesLocalNameBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new name end parse: 'v'.
	self deny: node isPetit2Failure.
	self assert: node label = 'LocalName'.
	binds := Set new.
	self assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new) equals: {'v'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesMapComprehensionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new mapComprehension end parse: '{f(v1) |-> g(v2) | v1, v2 in set s & p(v1, v2)}'.
	self deny: node isPetit2Failure.
	self assert: node label = 'MapComprehension'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'f'.
			'g'.
			's'.
			'p'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesRecordConstructorBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new recordConstructor end parse: 'mk_T(v)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'RecordConstructor'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'T'.
			'v'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesSequenceComprehensionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new sequenceComprehension end parse: '[f(v) | v in set s & p(v)]'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SequenceComprehension'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'f'.
			's'.
			'p'} asSet
]

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesSequenceForLoopBoundVarsInto [
	| node |
	node := ViennaVDMParser new sequenceForLoop end parse: 'for v in s do op(v)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SequenceForLoop'.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'s'.
			'op'} asSet
]

{ #category : #'tests-free variables-expressions' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesSetComprehensionBoundVarsInto [
	| node binds |
	node := ViennaVDMParser new setComprehension end parse: '{f(v) | v in set s & p(v)}'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SetComprehension'.
	binds := Set new.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'f'.
			's'.
			'p'} asSet
]

{ #category : #'tests-free variables-statements' }
TViennaVDMFreeVariableCollectorTestCase >> testFreeVariablesSetForLoopBoundVarsInto [
	| node |
	node := ViennaVDMParser new setForLoop end parse: 'for all v in set s do op(v)'.
	self deny: node isPetit2Failure.
	self assert: node label = 'SetForLoop'.
	self
		assert: (ViennaVDM2SmalltalkScript new freeVariables: node env: Dictionary new)
		equals:
			{'s'.
			'op'} asSet
]
