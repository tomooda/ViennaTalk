Class {
	#name : #ViennaVDM2SmalltalkObjectTest,
	#superclass : #TestCase,
	#traits : 'TViennaVDMBoundVariableCollectorTestCase + TViennaVDMFreeVariableCollectorTestCase',
	#classTraits : 'TViennaVDMBoundVariableCollectorTestCase classTrait + TViennaVDMFreeVariableCollectorTestCase classTrait',
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testFunctionPostcondition [
	self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	post RESULT >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(10)') )
						for: obj
						logged: false)
				equals: 9.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(0)') )
						for: obj
						logged: false ]
				raise: ViennaPostconditionViolation ]
]

{ #category : #'tests-preconditions' }
ViennaVDM2SmalltalkObjectTest >> testFunctionPrecondition [
	self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	pre x > 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(9)'))
						for: obj
						logged: false)
				equals: 8.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(-1)'))
						for: obj
						logged: false ]
				raise: ViennaPreconditionViolation ]
]

{ #category : #'tests-type checking' }
ViennaVDM2SmalltalkObjectTest >> testFunctionTypecheck [
	self
		transpile:
			'
	functions 
	pred : nat -> nat 
	pred(x) == x - 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(9)') )
						for: obj
						logged: false)
				equals: 8.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(0)') )
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(-1)') )
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]
]

{ #category : #'tests-postconditions' }
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
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') )
						for: obj
						logged: false)
				equals: 1.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') )
						for: obj
						logged: false ]
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
		do: [ :obj  :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') )
						for: obj
						logged: false)
				equals: 1.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') )
						for: obj
						logged: false ]
				raise: ViennaPreconditionViolation ]
]

{ #category : #'tests-type checking' }
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
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)'))
						for: obj
						logged: false)
				equals: 1.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(-9)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]
]

{ #category : #'tests-invariants' }
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
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)') )
						for: obj
						logged: false)
				equals: 1.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)'))
						for: obj
						logged: false ]
				raise: ViennaStateInvariantViolation ]
]

{ #category : #'tests-invariants' }
ViennaVDM2SmalltalkObjectTest >> testTypeInvariant [
	self
		transpile:
			'
	types
		N0 = int inv n == n >= 0
	state State of 
		count : N0
		init s == s = mk_State(10) 
	end
	operations 
	sub : int ==> int 
	sub(x) == (count := count - x; return count);'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)'))
						for: obj
						logged: false)
				equals: 1.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'sub(9)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'is_N0(1)') )
						for: obj
						logged: false)
				equals: true.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'is_N0(-1)') )
						for: obj
						logged: false)
				equals: false ]
]

{ #category : #private }
ViennaVDM2SmalltalkObjectTest >> transpile: aString runtimeTypeCheck: aBoolean1 runtimeAssertionCheck: aBoolean2 do: aBlock [
	| ast transpiler obj |
	ast := ViennaVDMParser new parse: aString.
	ast isPetitFailure
		ifTrue: [ ^ Error signal: 'syntax error' ].
	transpiler := ViennaVDM2SmalltalkObject new.
	transpiler
		runtimeTypeCheck: aBoolean1;
		runtimeAssertionCheck: aBoolean2.
	obj := transpiler generate: ast.
	transpiler defaultEnv: ((transpiler buildEnv: ast) at: 'DEFAULT').
	^ aBlock value: obj value: transpiler
]
