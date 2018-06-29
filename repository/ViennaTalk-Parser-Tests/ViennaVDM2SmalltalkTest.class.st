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

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesExportDefinitionInto [
	| node binds |
	node := ViennaVDMParser new exportDefinition end parse: 'exports types t1; t2; values v1:t3; v2:t4'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportDefinition'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't2'.
			'v1'.
			't3'.
			'v2'.
			't4'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesExportFunctionsSignatureInto [
	| node binds |
	node := ViennaVDMParser new exportFunctionsSignature end parse: 'functions f1[@t1,@t2]:t3->t4; f2[@t5,@t6]:t7->t8'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportFunctionsSignature'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'f1'.
			't3'.
			't4'.
			'f2'.
			't7'.
			't8'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesExportModuleSignatureInto [
	| node binds |
	node := ViennaVDMParser new exportModuleSignature end parse: 'values v1 : t1; types t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportModuleSignature'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'v1'.
			't1'.
			't2'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesExportTypesSignatureInto [
	| node binds |
	node := ViennaVDMParser new exportTypesSignature end parse: 'types t1; t2'.
	self deny: node isPetitFailure.
	self assert: node label = 'ExportTypesSignature'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'t1'.
			't2'} asSet
]

{ #category : #'tests-bound variables-interfaces' }
ViennaVDM2SmalltalkTest >> testBoundVariablesFunctionExportInto [
	| node binds |
	node := ViennaVDMParser new functionExport end parse: 'f1[@t1,@t2]:t3->t4'.
	self deny: node isPetitFailure.
	self assert: node label = 'FunctionExport'.
	binds := Set new.
	ViennaVDM2Smalltalk new boundVariables: node into: binds.
	self
		assert: binds
		equals:
			{'f1'.
			't3'.
			't4'} asSet
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

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testCompositionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: '(lambda x:nat & x + 1) comp (lambda x:nat & x * 2)'.
	self deny: node isPetitFailure.
	self assert: node label = 'Composition'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node) , ' value: 3') equals: 7
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testDefExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'def  y : nat = x + 1; x : nat = 1 in x + y'.
	self deny: node isPetitFailure.
	self assert: node label = 'DefExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: Dictionary new)) equals: 3
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testIfExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'if x > 0 then <positive> elseif x = 0 then <zero> else <negative>'.
	self deny: node isPetitFailure.
	self assert: node label = 'IfExpression'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('x' -> '1')} asDictionary))
		equals: #'<positive>'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('x' -> '0')} asDictionary))
		equals: #'<zero>'.
	self
		assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node env: {('x' -> '-1')} asDictionary))
		equals: #'<negative>'
]

{ #category : #'tests-code generation-expressions' }
ViennaVDM2SmalltalkTest >> testLambdaExpressionEnv [
	| node |
	node := ViennaVDMParser new expression end parse: 'lambda x:nat & x + 1'.
	self deny: node isPetitFailure.
	self assert: node label = 'LambdaExpression'.
	self assert: (Compiler evaluate: (ViennaVDM2Smalltalk new generate: node) , ' value: 2') equals: 3
]

{ #category : #private }
ViennaVDM2SmalltalkTest >> undefined [
	^ ViennaVDM2Smalltalk new generate: (ViennaVDMParser new expression parse: 'undefined')
]
