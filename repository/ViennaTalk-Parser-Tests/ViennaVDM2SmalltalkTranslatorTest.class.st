Class {
	#name : #ViennaVDM2SmalltalkTranslatorTest,
	#superclass : #TestCase,
	#category : 'ViennaTalk-Parser-Tests'
}

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testAbs [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'abs -1')) equals: 1
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testAndAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true and true'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false and true'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 and true') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true and false'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false and false'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 and false') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true and 1/0') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false and 1/0'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 and 1/0') ]
		raise: ZeroDivide
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testApplyArgs [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '(lambda x:int&x+1)(2)'))
		equals: 3.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '[2,3,4](2)')) equals: 3.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3, 3|->4}(2)'))
		equals: 3
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testBasicType [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'bool')) equals: ViennaType bool.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'nat1')) equals: ViennaType nat1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'nat')) equals: ViennaType nat.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'int')) equals: ViennaType int.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'real')) equals: ViennaType real.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'char')) equals: ViennaType char.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'token')) equals: ViennaType token
]

{ #category : #'tests-literals' }
ViennaVDM2SmalltalkTranslatorTest >> testBooleanLiteral [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false')) equals: false
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testCard [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'card {1,...,10}'))
		equals: 10
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testCasesExpression [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases 2: 0, 1 -> -1, a -> a + 1 end'))
		equals: 3.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
			cases 1:
				0, 2, 3 -> 0, 
				4, 5, 6 -> 1, 
				others -> 2
			end'))
		equals: 2
]

{ #category : #'tests-literals' }
ViennaVDM2SmalltalkTranslatorTest >> testCharacterLiteral [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''A''')) equals: $A.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\''''')) equals: $'.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\\''')) equals: $\.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\n'''))
		equals: Character lf.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\101''')) equals: $A.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\x41''')) equals: $A.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '''\u0041''')) equals: $A
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testCompositeType [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'compose T of bool i : int n :- nat end'))
		equals:
			(ViennaType
				compose: 'T'
				of:
					{{nil.
					false.
					(ViennaType bool)}.
					{'i'.
					false.
					(ViennaType int)}.
					{'n'.
					true.
					(ViennaType nat)}})
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testCompositionExpressionAnd [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse: '((lambda x:int&x+1) comp (lambda s:set of int&card s))({1,2,3})'))
		equals: 4.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '({2|->3, 3|->4} comp {1|->2, 2|->3})(2)'))
		equals: 4.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: '({2|->3, 3|->4} comp (lambda s:set of int&card s))({1,2,3})'))
		equals: 4.
	self
		assert:
			(Compiler
				evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '((lambda x:int&x+1) comp {2|->3, 3|->4})(2)'))
		equals: 4
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testConc [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'conc [[1,2,3],[4,5,6]]'))
		equals: #(1 2 3 4 5 6) asOrderedCollection
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testConcatAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '[1,2,3]^[4,5,6]'))
		equals: #(1 2 3 4 5 6) asOrderedCollection
]

{ #category : #'tests-literals' }
ViennaVDM2SmalltalkTranslatorTest >> testDecimalLiteral [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '10')) equals: 10.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '-1.23e-4')) equals: -1.23e-4.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '-1.23E-4')) equals: -1.23e-4
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testDefExpression [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression
						parse:
							'
			def
				s = power {<a>, <b>, <c>};
				mk_(a, b) = mk_(1, 2)
			in
				card s + a + b'))
		equals: 11
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testDiffAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1,2,3} \ {2,3,4}'))
		equals: #(1) asSet
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testDinter [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'dinter {{1,2,3}, {2,3,4}}'))
		equals: #(2 3) asSet
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testDivAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '3 div 2')) equals: 1
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testDom [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'dom {1|->2, 2|->3}'))
		equals: #(1 2) asSet
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testDunion [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'dunion {{1,2,3}, {2,3,4}}'))
		equals: #(1 2 3 4) asSet
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testElems [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'elems [5,6,7]'))
		equals: #(5 6 7) asSet
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testEqualAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 = 1')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 = 2')) equals: false
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testEquivAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true <=> true'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false <=> true'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 <=> true') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true <=> false'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false <=> false'))
		equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 <=> false') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true <=> 1/0') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false <=> 1/0') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 <=> 1/0') ]
		raise: ZeroDivide
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testExists1Expression [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'exists1 x in set {1, 2, 3} & x < 2'))
		equals: true.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'exists1 x in set {1, 2, 3} & x < 0'))
		equals: false.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'exists1 x in set {1, 2, 3} & x <= 2'))
		equals: false
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testExistsExpression [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'exists x, y in set {1,2}, z in set {2,3} & x + y = z'))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'exists x, y in set {1,2}, z in set {2,3} & x = y and y = z'))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'exists x, y in set {1,2}, z in set {2,3} & x + y + z < 0'))
		equals: false
]

{ #category : #'tests-definitions' }
ViennaVDM2SmalltalkTranslatorTest >> testExplicitFunctionDefinition [
	self
		assert:
			(Compiler
				evaluate:
					'|inc|'
						,
							(ViennaVDM2SmalltalkTranslator new explicitFunctionDefinition end parse: 'inc: int -> int inc(x) == x + 1') second
						, '. inc value: 2')
		equals: 3
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testFieldSelectWith [
	self
		assert:
			(Compiler
				evaluate:
					' | type value | type := ViennaCompositeType constructorName: ''T'' withAll: {{ nil . false . ViennaType int} . {''f'' . false . ViennaType int}}. value := type valueWithArguments: #(10 20). '
						, (ViennaVDM2SmalltalkTranslator new expression end parse: 'value.f'))
		equals: 20.
	self
		should: [ 
			Compiler
				evaluate:
					' | type value | type := ViennaCompositeType constructorName: ''T'' withAll: {{ nil . false . ViennaType int} . {''f'' . false . ViennaType int}}. value := type valueWithArguments: #(10 20). '
						, (ViennaVDM2SmalltalkTranslator new expression end parse: 'value.g') ]
		raise: KeyNotFound
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testFloor [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'floor 1.9')) equals: 1
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testForallExpression [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'forall x, y in set {1,2}, z in set {5,6} & x + y < z'))
		equals: true.
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'forall x, y in set {1,2}, z in set {2,3} & x + y < z'))
		equals: false
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testFractionAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '2 / 3')) equals: 2.0 / 3.0
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testFunctionComposition [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
	let
		f : int * int -> int f(x,y)==x+y,
		g : int -> int * int g(x) == mk_(x, x)
	in
		(f comp g)(1)'))
		equals: 2
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testFunctionTypeInstantiationArgs [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
					let 
						inc[@num] : @num -> @num
						inc(x) == x + 1
					in
						inc[int](2)'))
		equals: 3
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testGreaterAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 > 0')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 > 1')) equals: false.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 > 2')) equals: false
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testGreaterEqAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 >= 0')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 >= 1')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 >= 2')) equals: false
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testHd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'hd [1,2,3]')) equals: 1.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'hd []') ]
		raise: SubscriptOutOfBounds
]

{ #category : #'tests-literals' }
ViennaVDM2SmalltalkTranslatorTest >> testHexadecimalLiteral [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '10')) equals: 10.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '0x10')) equals: 16.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '0X10')) equals: 16
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testIfExpression [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression
						parse: '[(lambda x:int&if x = 0 then <zero> elseif x = 1 then <one> else <many>)(i)|i in set {0,...,3}]'))
		equals: #('<zero>' '<one>' '<many>' '<many>') asOrderedCollection
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testImpAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true => true')) equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false => true'))
		equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 => true') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true => false'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false => false'))
		equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 => false') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true => 1/0') ]
		raise: ZeroDivide.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false => 1/0')) equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 => 1/0') ]
		raise: ZeroDivide
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testInSetAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 in set {1,...,10}'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '0 in set {1,...,10}'))
		equals: false
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testInds [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'inds [10,20,30]'))
		equals: #(1 2 3) asSet
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testInmapType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'inmap int to nat'))
		equals: (ViennaType int inmapTo: ViennaType nat)
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testInterAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1,2,3} inter {2,3,4}'))
		equals: #(2 3) asSet
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testInverse [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'inverse {1|->2, 2|->3}'))
		equals:
			(Dictionary new
				at: 3 put: 2;
				at: 2 put: 1;
				yourself)
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testIotaExpression [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression parse: 'iota mk_(x,y) in set {mk_(1, 2), mk_(2, 3)} & x > 1'))
		equals: #(2 3).
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'iota x in set {1, 2, 3} & x < 0') ]
		raise: NotFound
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testIterateExpressionAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '2 ** 3')) equals: 8.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '((lambda x:int&x+1) ** 2)(1)'))
		equals: 3.
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '({0|->1, 1|->2, 2|->3, 3|->0} ** 2)(1)'))
		equals: 3
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testLambdaExpression [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '(lambda x:int&x+1)(2)'))
		equals: 3
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testLen [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'len [10,20,30]')) equals: 3
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testLessAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 < 0')) equals: false.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 < 1')) equals: false.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 < 2')) equals: true
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testLessEqAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 <= 0')) equals: false.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 <= 1')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 <= 2')) equals: true
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testLetBeExpression [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
						let
							mk_(x, y), mk_(z, w) in set {mk_(1, 2), mk_(2, 3)}
						be st
							y = z
						in
							mk_(x, y, z, w)'))
		equals: #(1 2 2 3).
	self
		should: [ 
			Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse:
							'
						let
							mk_(x, y), mk_(z, w) in set {mk_(1, 2), mk_(3, 4)}
						be st
							y = z
						in
							mk_(x, y, z, w)') ]
		raise: NotFound
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testLetExpression [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'let s = power {<a>, <b>, <c>} in card s'))
		equals: 8
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testLocalfunction [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'let inc:int->int inc(x)==x+1 in inc(2)')) equals: 3
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testMapApplication [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression parse: '({1|-><one>, 2|-><two>, 3|-><three>} comp {<one>|->1, <two>|->2,<three>|->3})(<two>)'))
		equals: #'<two>'
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testMapComprehension [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '{ i |-> i+1 | i in set {1,...,9} & i mod 2 = 0}'))
		equals:
			(Dictionary new
				at: 2 put: 3;
				at: 4 put: 5;
				at: 6 put: 7;
				at: 8 put: 9;
				yourself)
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testMapDomain [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'dom ({"one"|->1, "two"|->2, "three"|->3} :> {1,3})'))
		equals:
			{('one' asOrderedCollection).
			('three' asOrderedCollection)} asSet
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMapDomainRestrictedBy [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0,1,2} <-: {1|->2, 2|->3, 4|->5}'))
		equals:
			(Dictionary new
				at: 4 put: 5;
				yourself)
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMapDomainRestrictedTo [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0,1,2} <: {1|->2, 2|->3, 4|->5}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 2 put: 3;
				yourself)
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testMapEnumeration [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 2 put: 3;
				yourself)
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testMapEnumeration2 [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{|->}'))
		equals: Dictionary new
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testMapEnumerationPattern [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse: 'cases { 1 |-> 2, 2 |-> 3 } : { a |-> b, b |-> c } -> mk_(a, b, c) end'))
		equals: #(1 2 3)
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testMapInverse [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '(inverse {"one"|->1, "two"|->2, "three"|->3})(2)'))
		equals: 'two' asOrderedCollection
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testMapMunionPattern [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end
						parse: 'cases { 1 |-> 2, 2 |-> 3 } : { a |-> b} munion { b |-> c } -> mk_(a, b, c) end'))
		equals: #(1 2 3)
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMapRangeRestrictedBy [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3, 4|->5} :-> {1,2}'))
		equals:
			(Dictionary new
				at: 2 put: 3;
				at: 4 put: 5;
				yourself)
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMapRangeRestrictedTo [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3, 4|->5} :> {1,2}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				yourself)
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testMapType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'map int to nat'))
		equals: (ViennaType int mapTo: ViennaType nat)
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testMatchValueExpression [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {{1}, {1, 2}} : {{a}, ({1,...,2})} -> a end'))
		equals: 1
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testMatchValueLiteral [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {1,2} : {a, 2} -> a end'))
		equals: 1
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMconcatAnd [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3} ++ {2|->4, 4|->5}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 2 put: 4;
				at: 4 put: 5;
				yourself)
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMerge [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'merge {{1|->2, 2|->3}, {2|->3, 4|->5}}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 2 put: 3;
				at: 4 put: 5;
				yourself)
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMinusAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1-2')) equals: -1
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testModAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '3 mod 2')) equals: 1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '-3 mod 2')) equals: 1
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMulAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '2 * 3')) equals: 6
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testMunionAnd [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1|->2, 2|->3} munion {2|->3, 4|->5}'))
		equals:
			(Dictionary new
				at: 1 put: 2;
				at: 2 put: 3;
				at: 4 put: 5;
				yourself)
]

{ #category : #'tests-literals' }
ViennaVDM2SmalltalkTranslatorTest >> testNilLiteral [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'nil')) equals: nil
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testNot [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'not true')) equals: false.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'not false')) equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'not 1/0') ]
		raise: ZeroDivide
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testNotEqualAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 <> 2')) equals: true.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 <> 1')) equals: false
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testNotInSetAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 not in set {1,...,10}'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '0 not in set {1,...,10}'))
		equals: true
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testOptionalType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: '[nat]'))
		equals: ViennaType nat optional
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testOrAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true or true')) equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false or true'))
		equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 or true') ]
		raise: ZeroDivide.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true or false'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false or false'))
		equals: false.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 or false') ]
		raise: ZeroDivide.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'true or 1/0')) equals: true.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'false or 1/0') ]
		raise: ZeroDivide.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1/0 or 1/0') ]
		raise: ZeroDivide
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testPartialFunctionType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'int -> nat'))
		equals: ViennaType int -> ViennaType nat
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testPatternIdentifier [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases 1 : a -> a end'))
		equals: 1
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testPlusAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '1 + 2')) equals: 3
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testPower [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'power {1,2,3}'))
		equals:
			{({} asSet).
			({1} asSet).
			({2} asSet).
			({3} asSet).
			({1.
			2} asSet).
			({2.
			3} asSet).
			({1.
			3} asSet).
			({1.
			2.
			3} asSet)} asSet
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testProductType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'bool*nat*int'))
		equals: ViennaType bool * ViennaType nat * ViennaType int
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testPsubsetAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1} psubset {1, 2}'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1, 2} psubset {1, 2}'))
		equals: false.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0, 1} psubset {1, 2}'))
		equals: false
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testQuoteType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: '<QUOTE>'))
		equals: (ViennaType quote: '<QUOTE>')
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testRecordConstructor [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'mk_t(1,2)'))
		equals: (ViennaComposite constructorName: 't' with: 1 with: 2)
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testRecordPattern [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases mk_t(1) : mk_t(a) -> a end'))
		equals: 1
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testRemAnd [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '5 rem 3')) equals: 2.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '-5 rem 3')) equals: -2
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testRng [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'rng {1|->2, 2|->3}'))
		equals: #(2 3) asSet
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testSeq1Type [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'seq1 of nat'))
		equals: ViennaType nat seq1
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testSeqConcPattern [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases [ 1,2,3 ] : [a]^[2,3] -> a end'))
		equals: 1
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testSeqEnumPattern [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases [1,2,3] : [a,b,3] -> mk_(a, b) end'))
		equals: #(1 2)
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testSeqType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'seq of nat'))
		equals: ViennaType nat seq
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testSequenceApplication [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '[ "0123456789abcdef"(i+1) |i in set {0,...,15} & i mod 2 = 0]'))
		equals: #($0 $2 $4 $6 $8 $a $c $e) asOrderedCollection
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testSequenceComprehension [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '[mk_(x, x+1) | x in set {1,...,3} & x mod 2 <> 0]'))
		equals: #(#(1 2) #(3 4)) asOrderedCollection
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testSequenceEnumeration [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '[1, 3, 5]')) equals: #(1 3 5) asOrderedCollection
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testSetComprehension [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '{ i+1 |i in set {1,...,9} & i mod 2 = 0}'))
		equals: #(3 5 7 9) asSet
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testSetEnumPattern [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {{1}, {1, 2}} : {{a}, {1, b}} -> mk_(a, b) end'))
		equals: #(1 2)
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testSetEnumeration [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '{1, 3, 5}')) equals: #(1 3 5) asSet
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testSetMembership [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '2 in set dom {1|->"one", 2|->"two", 3|->"three"}'))
		equals: true
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testSetRangeExpression [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: '{1,...,10}')) equals: (1 to: 10) asSet
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testSetType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'set of nat'))
		equals: ViennaType nat set
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testSetUnionPattern [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {{1}, {1, 2}} : {a} union {{1, b}} -> mk_(a, b) end'))
		equals:
			{(#(1) asSet).
			2}
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testSubsequenceFromTo [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '[10,20,30,40,50](2,...,3)'))
		equals: #(20 30) asOrderedCollection
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testSubsetAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1} subset {1, 2}'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{1, 2} subset {1, 2}'))
		equals: true.
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0, 1} subset {1, 2}'))
		equals: false
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testTl [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'tl [1,2,3]'))
		equals: #(2 3) asOrderedCollection.
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'tl []') ]
		raise: SubscriptOutOfBounds
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testTotalFunctionType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'int +> nat'))
		equals: ViennaType int +> ViennaType nat
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testTupleConstructor [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'mk_(1,2)')) equals: #(1 2)
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testTuplePattern [
	self
		assert:
			(Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'cases mk_(1,2,3) : mk_(a,2,3) -> a end'))
		equals: 1
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testTupleSelectWith [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: 'mk_(10, 20, 30).#2'))
		equals: 20
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testUnaryMinus [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '-1')) equals: -1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '- 1')) equals: -1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '- - 1')) equals: 1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '- (1+2)')) equals: -3
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testUnaryPlus [
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '+1')) equals: 1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '+ 1')) equals: 1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '+ + 1')) equals: 1.
	self assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '+ (1+2)')) equals: 3
]

{ #category : #'tests-expressions' }
ViennaVDM2SmalltalkTranslatorTest >> testUndefinedExpression [
	self
		should: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'undefined') ]
		raise: ViennaUndefinedEvaluationError.
	self
		shouldnt: [ Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression parse: 'if true then 1 else undefined') ]
		raise: ViennaUndefinedEvaluationError
]

{ #category : #'tests-operators' }
ViennaVDM2SmalltalkTranslatorTest >> testUnionAnd [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new expression end parse: '{0,1,2} union {1,2,3}'))
		equals: #(0 1 2 3) asSet
]

{ #category : #'tests-types' }
ViennaVDM2SmalltalkTranslatorTest >> testUnionType [
	self
		assert: (Compiler evaluate: (ViennaVDM2SmalltalkTranslator new type end parse: 'bool | nat | int'))
		equals: ViennaType bool | ViennaType nat | ViennaType int
]

{ #category : #'tests-definitions' }
ViennaVDM2SmalltalkTranslatorTest >> testValueDefinition [
	self
		assert:
			(Compiler
				evaluate: '|one|' , (ViennaVDM2SmalltalkTranslator new valueDefinition end parse: 'one = 1') second , '. one + 2')
		equals: 3
]

{ #category : #'tests-patterns' }
ViennaVDM2SmalltalkTranslatorTest >> testValuePattern [
	self
		assert:
			(Compiler
				evaluate:
					(ViennaVDM2SmalltalkTranslator new expression end parse: 'cases {{1}, {1, 2}} : {{a}, ({1,...,2})} -> a end'))
		equals: 1
]
