Class {
	#name : #ViennaVDM2SmalltalkObjectTest,
	#superclass : #TestCase,
	#category : #'ViennaTalk-Transpiler-Test'
}

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testExplicitFunctionPostcondition [
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	post RESULT >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(10)') equals: 9.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaPostconditionViolation
]

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testExtendedExplicitFunctionPostcondition [
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred(x:int) res:int == x - 1
	post res >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(10)') equals: 9.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaPostconditionViolation
]

{ #category : #'tests-type checking' }
ViennaVDM2SmalltalkObjectTest >> testExtendedExplicitOperation [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self assert: (obj instVarNamed: 'count') equals: 1.
	self
		assert: (obj evaluateExpression: 'post_sub(1, mk_State(9), mk_State(10), 9)')
		equals: true
]

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testFunctionPostcondition [
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	post RESULT >= 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(10)') equals: 9.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaPostconditionViolation
]

{ #category : #'tests-preconditions' }
ViennaVDM2SmalltalkObjectTest >> testFunctionPrecondition [
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred : int -> int 
	pred(x) == x - 1
	pre x > 0;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(9)') equals: 8.
	self should: [ obj evaluateExpression: 'pred(-1)' ] raise: ViennaPreconditionViolation
]

{ #category : #'tests-type checking' }
ViennaVDM2SmalltalkObjectTest >> testFunctionTypecheck [
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred : nat -> nat 
	pred(x) == x - 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'pred(9)') equals: 8.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaRuntimeTypeError.
	self should: [ obj evaluateExpression: 'pred(-1)' ] raise: ViennaRuntimeTypeError
]

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testImplilcitFunctionPostcondition [
	| obj |
	obj := self
		transpile:
			'
	functions 
	pred(x:int) res:int
	post res - x = 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'post_pred(10, 11)') equals: true.
	self assert: (obj evaluateExpression: 'post_pred(10, 9)') equals: false.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaImplicitEvaluationError
]

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testImplilcitOperationPostcondition [
	| obj |
	obj := self
		transpile:
			'
	operations 
	pred(x:int) res:int
	pre x > 0
	post res - x = 1;'
		runtimeTypeCheck: true
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'post_pred(10, nil, nil, 11)') equals: true.
	self assert: (obj evaluateExpression: 'post_pred(10, nil, nil, 9)') equals: false.
	self should: [ obj evaluateExpression: 'pred(10)' ] raise: ViennaImplicitEvaluationError.
	self should: [ obj evaluateExpression: 'pred(0)' ] raise: ViennaPreconditionViolation
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testImportsFunctions [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`next(1)' ifError: [  ]) equals: 2.
	self
		should: [ obj evaluateExpression: 'M`next(-1)' ifError: [  ] ]
		raise: ViennaRuntimeTypeError
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testImportsOperations [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`next()' ifError: [  ]) equals: 1.
	self assert: (obj evaluateExpression: 'M`next()' ifError: [  ]) equals: 2
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testImportsTypes [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`succ(1)') equals: 2.
	self should: [ obj evaluateExpression: 'M`succ(-1)' ] raise: ViennaRuntimeTypeError
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testImportsValues [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`isZero(1)') equals: false.
	self assert: (obj evaluateExpression: 'M`isZero(0)') equals: true
]

{ #category : #'tests-postconditions' }
ViennaVDM2SmalltalkObjectTest >> testOperationPostcondition [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self should: [ obj evaluateExpression: 'sub(9)' ] raise: ViennaPostconditionViolation
]

{ #category : #'tests-preconditions' }
ViennaVDM2SmalltalkObjectTest >> testOperationPrecondition [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self should: [ obj evaluateExpression: 'sub(9)' ] raise: ViennaPreconditionViolation
]

{ #category : #'tests-type checking' }
ViennaVDM2SmalltalkObjectTest >> testOperationTypecheck [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self should: [ obj evaluateExpression: 'sub(-9)' ] raise: ViennaRuntimeTypeError.
	self should: [ obj evaluateExpression: 'sub(9)' ] raise: ViennaRuntimeTypeError
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testRenamedFunctions [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`next(1)') equals: 2.
	self should: [ obj evaluateExpression: 'M`next(-1)' ] raise: ViennaRuntimeTypeError
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testRenamedOperations [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`next()') equals: 1.
	self assert: (obj evaluateExpression: 'M`next()') equals: 2
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testRenamedTypes [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`succ(1)') equals: 2.
	self should: [ obj evaluateExpression: 'M`succ(-1)' ] raise: ViennaRuntimeTypeError
]

{ #category : #'tests-imports' }
ViennaVDM2SmalltalkObjectTest >> testRenamedValues [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'M`isZero(1)') equals: false.
	self assert: (obj evaluateExpression: 'M`isZero(0)') equals: true
]

{ #category : #'tests-invariants' }
ViennaVDM2SmalltalkObjectTest >> testStateInvariant [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self should: [ obj evaluateExpression: 'sub(9)' ] raise: ViennaStateInvariantViolation
]

{ #category : #'tests-invariants' }
ViennaVDM2SmalltalkObjectTest >> testTypeInvariant [
	| obj |
	obj := self
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
		runtimeAssertionCheck: true.
	self assert: (obj evaluateExpression: 'sub(9)') equals: 1.
	self should: [ obj evaluateExpression: 'sub(9)' ] raise: ViennaRuntimeTypeError.
	self assert: (obj evaluateExpression: 'is_N0(1)') equals: true.
	self assert: (obj evaluateExpression: 'is_N0(-1)') equals: false
]

{ #category : #private }
ViennaVDM2SmalltalkObjectTest >> transpile: aString runtimeTypeCheck: aBoolean1 runtimeAssertionCheck: aBoolean2 [
	| ast transpiler |
	ast := ViennaVDMParser new parse: aString.
	ast isPetit2Failure
		ifTrue: [ ^ Error signal: 'syntax error' ].
	transpiler := ViennaVDM2SmalltalkObject new.
	transpiler
		runtimeTypeCheck: aBoolean1;
		runtimeAssertionCheck: aBoolean2.
	^ transpiler generate: ast
]
