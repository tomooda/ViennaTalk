Class {
	#name : #ViennaVDM2SmalltalkObjectTest,
	#superclass : #TestCase,
	#traits : 'TViennaVDMBoundVariableCollectorTestCase + TViennaVDMFreeVariableCollectorTestCase',
	#classTraits : 'TViennaVDMBoundVariableCollectorTestCase classTrait + TViennaVDMFreeVariableCollectorTestCase classTrait',
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #'tests-preconditions' }
ViennaVDM2SmalltalkObjectTest >> testOperationPostcondition [
	self
		transpile:
			'
	state State of 
		count : int
		init s == s = mk_State(10) 
	end
	operations 
	sub : nat ==> int 
	sub(x) == (count := count - x; return count)
	post count >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :env :transpiler | 
			self
				assert: (Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') env: env) for: obj logged: false)
				equals: 1.
			self
				should: [ Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') env: env) for: obj logged: false ]
				raise: ViennaPostconditionViolation ]
]

{ #category : #'tests-preconditions' }
ViennaVDM2SmalltalkObjectTest >> testOperationPrecondition [
	self
		transpile:
			'
	state State of 
		count : nat
		init s == s = mk_State(10) 
	end
	operations 
	sub : nat ==> nat 
	sub(x) == (count := count - x; return count)
	pre count >= x;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :env :transpiler | 
			self
				assert: (Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') env: env) for: obj logged: false)
				equals: 1.
			self
				should: [ Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') env: env) for: obj logged: false ]
				raise: ViennaPreconditionViolation ]
]

{ #category : #'tests-preconditions' }
ViennaVDM2SmalltalkObjectTest >> testOperationTypecheck [
	self
		transpile:
			'
	state State of 
		count : int
		init s == s = mk_State(10) 
	end
	operations 
	sub : nat ==> nat 
	sub(x) == (count := count - x; return count)
	post count >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :env :transpiler | 
			self
				assert: (Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') env: env) for: obj logged: false)
				equals: 1.
			self
				should: [ Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(-9)') env: env) for: obj logged: false ]
				raise: ViennaRuntimeTypeError.
			self
				should: [ Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') env: env) for: obj logged: false ]
				raise: ViennaRuntimeTypeError ]
]

{ #category : #'tests-preconditions' }
ViennaVDM2SmalltalkObjectTest >> testStateInvariant [
	self
		transpile:
			'
	state State of 
		count : int
		inv mk_State(c) == c >= 0
		init s == s = mk_State(10) 
	end
	operations 
	sub : int ==> int 
	sub(x) == (count := count - x; return count)
	post count >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :env :transpiler | 
			self
				assert: (Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') env: env) for: obj logged: false)
				equals: 1.
			self
				should: [ Compiler evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') env: env) for: obj logged: false ]
				raise: ViennaStateInvariantViolation ]
]

{ #category : #private }
ViennaVDM2SmalltalkObjectTest >> transpile: aString runtimeTypeCheck: aBoolean1 runtimeAssertionCheck: aBoolean2 do: aBlock [
	| ast transpiler |
	ast := ViennaVDMParser new parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ Error signal: 'syntax error' ].
	transpiler := ViennaVDM2SmalltalkObject new.
	transpiler
		runtimeTypeCheck: aBoolean1;
		runtimeAssertionCheck: aBoolean2.
	aBlock value: (transpiler generate: ast) value: (transpiler buildEnv: ast) value: transpiler
]
