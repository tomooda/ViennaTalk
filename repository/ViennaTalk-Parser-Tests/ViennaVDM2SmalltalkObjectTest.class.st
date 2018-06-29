Class {
	#name : #ViennaVDM2SmalltalkObjectTest,
	#superclass : #TestCase,
	#traits : 'TViennaVDMBoundVariableCollectorTestCase + TViennaVDMFreeVariableCollectorTestCase',
	#classTraits : 'TViennaVDMBoundVariableCollectorTestCase classTrait + TViennaVDMFreeVariableCollectorTestCase classTrait',
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testExplicitFunctionPostcondition [
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

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testExtendedExplicitFunctionPostcondition [
	self
		transpile:
			'
	functions 
	pred(x:int) res:int == x - 1
	post res >= 0;'
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

{ #category : #'tests-type checking' }
ViennaVDM2SmalltalkObjectTest >> testExtendedExplicitOperation [
	self
		transpile:
			'
	state State of 
		count : int
		init s == s = mk_State(10) 
	end
	operations 
	sub(x:nat) res:nat == (count := count - x; return count)
	post count + x = count~ and count = res;'
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
			self assert: (obj instVarNamed: 'count') equals: 1.
			self
				assert:
					(Compiler
						evaluate:
							(transpiler
								generate: (ViennaVDMParser new expression parse: 'post_sub(1, mk_State(9), mk_State(10), 9)'))
						for: obj
						logged: false)
				equals: true ]
]

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
ViennaVDM2SmalltalkObjectTest >> testImplilcitFunctionPostcondition [
	self
		transpile:
			'
	functions 
	pred(x:int) res:int
	post res - x = 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'post_pred(10, 11)'))
						for: obj
						logged: false)
				equals: true.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'post_pred(10, 9)'))
						for: obj
						logged: false)
				equals: false.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(0)'))
						for: obj
						logged: false ]
				raise: ViennaImplicitEvaluationError ]
]

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testImplilcitOperationPostcondition [
	self
		transpile:
			'
	operations 
	pred(x:int) res:int
	pre x > 0
	post res - x = 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate:
							(transpiler
								generate: (ViennaVDMParser new expression parse: 'post_pred(10, nil, nil, 11)'))
						for: obj
						logged: false)
				equals: true.
			self
				assert:
					(Compiler
						evaluate:
							(transpiler
								generate: (ViennaVDMParser new expression parse: 'post_pred(10, nil, nil, 9)'))
						for: obj
						logged: false)
				equals: false.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(10)'))
						for: obj
						logged: false ]
				raise: ViennaImplicitEvaluationError.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'pred(0)'))
						for: obj
						logged: false ]
				raise: ViennaPreconditionViolation ]
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testImportsFunctions [
	self
		transpile:
			'
		module T
		exports all
		definitions
		functions 
			succ : nat -> nat
			succ(x) == x + 1;
		end T
		module M
		imports from T functions succ
		exports all
		definitions
		functions
			next : int -> int
			next(x) == T`succ(x)
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next(1)'))
						for: obj
						logged: false)
				equals: 2.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next(-1)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testImportsOperations [
	self
		transpile:
			'
		module T
		exports all
		definitions
		state S of
			count : nat
			init s == s = mk_S(0)
		end
		operations 
			succ : () ==> nat
			succ() == (count := count + 1; return count);
		end T
		module M
		imports from T operations succ : () ==> nat
		exports all
		definitions
		operations
			next : () ==> nat
			next() == return T`succ()
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next()'))
						for: obj
						logged: false)
				equals: 1.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next()'))
						for: obj
						logged: false)
				equals: 2 ]
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testImportsTypes [
	self
		transpile:
			'
		module T
		exports all
		definitions
		types 
			n = int inv x == x >= 0
		end T
		module M
		imports from T types n
		exports all
		definitions
		functions
			succ : T`n -> T`n
			succ(x) == x + 1
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`succ(1)'))
						for: obj
						logged: false)
				equals: 2.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`succ(-1)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testImportsValues [
	self
		transpile:
			'
		module T
		exports all
		definitions
		values 
			zero = 0
		end T
		module M
		imports from T values zero
		exports all
		definitions
		functions
			isZero : int -> bool
			isZero(x) == x = T`zero
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`isZero(1)'))
						for: obj
						logged: false)
				equals: false.
			self
				assert: ( Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`isZero(0)'))
						for: obj
						logged: false )
				equals: true ]
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

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testRenamedFunctions [
	self
		transpile:
			'
		module T
		exports all
		definitions
		functions 
			succ : nat -> nat
			succ(x) == x + 1;
		end T
		module M
		imports from T functions succ renamed successor
		exports all
		definitions
		functions
			next : int -> int
			next(x) == successor(x)
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next(1)'))
						for: obj
						logged: false)
				equals: 2.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next(-1)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testRenamedOperations [
	self
		transpile:
			'
		module T
		exports all
		definitions
		state S of
			count : nat
			init s == s = mk_S(0)
		end
		operations 
			succ : () ==> nat
			succ() == (count := count + 1; return count);
		end T
		module M
		imports from T operations succ : () ==> nat renamed successor
		exports all
		definitions
		operations
			next : () ==> nat
			next() == return successor()
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next()'))
						for: obj
						logged: false)
				equals: 1.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`next()'))
						for: obj
						logged: false)
				equals: 2 ]
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testRenamedTypes [
	self
		transpile:
			'
		module T
		exports all
		definitions
		types 
			n = int inv x == x >= 0
		end T
		module M
		imports from T types n renamed n0
		exports all
		definitions
		functions
			succ : n0 -> n0
			succ(x) == x + 1
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`succ(1)'))
						for: obj
						logged: false)
				equals: 2.
			self
				should: [ Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`succ(-1)'))
						for: obj
						logged: false ]
				raise: ViennaRuntimeTypeError ]
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testRenamedValues [
	self
		transpile:
			'
		module T
		exports all
		definitions
		values 
			zero = 0
		end T
		module M
		imports from T values zero renamed z
		exports all
		definitions
		functions
			isZero : int -> bool
			isZero(x) == x = z
		end M'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true
		do: [ :obj :transpiler | 
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`isZero(1)'))
						for: obj
						logged: false)
				equals: false.
			self
				assert:
					(Compiler
						evaluate: (transpiler generate: (ViennaVDMParser new expression parse: 'M`isZero(0)'))
						for: obj
						logged: false)
				equals: true ]
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
