Class {
	#name : 'ViennaVDMFormatterTest',
	#superclass : 'TestCase',
	#instVars : [
		'parser',
		'formatter'
	],
	#category : 'ViennaTalk-Parser-Tests',
	#package : 'ViennaTalk-Parser-Tests'
}

{ #category : 'asserting' }
ViennaVDMFormatterTest >> assertParseFormattedSource: aString with: aPP2Node [

	| ast1 source ast2 |
	ast1 := aPP2Node parse: aString.
	self assert: ast1 isPetit2Success.
	source := formatter format: ast1.
	ast2 := aPP2Node parse: source.
	self assert: ast1 equals: ast2
]

{ #category : 'running' }
ViennaVDMFormatterTest >> setUp [

	parser := ViennaVDMParser new.
	formatter := ViennaVDMFormatter new
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatAnd [

	self
		assertParseFormattedSource: 'p and q'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatApply [

	self assertParseFormattedSource: 'f()' with: parser expression end.
	self assertParseFormattedSource: 'f(x)' with: parser expression end.
	self
		assertParseFormattedSource: 'f(x, y)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatArithmeticAbs [

	self assertParseFormattedSource: 'abs x' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatArithmeticDivide [

	self assertParseFormattedSource: 'x / y' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatArithmeticIntegerDivision [

	self
		assertParseFormattedSource: 'x div y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatArithmeticMinus [

	self
		assertParseFormattedSource: 'x - y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatArithmeticMod [

	self
		assertParseFormattedSource: 'x mod y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatArithmeticMultiplication [
	self
		assertParseFormattedSource: 'x * y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatArithmeticPlus [
	self
		assertParseFormattedSource: 'x + y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatArithmeticRem [
	self
		assertParseFormattedSource: 'x rem y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatAssignmentDefinition [

	self
		assertParseFormattedSource: 'x : nat := y + z'
		with: parser assignmentDefinition end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatCasesExpression [

	self
		assertParseFormattedSource: 'cases e:
	x^xs, {y} -> e1,
	others -> e2
	end'
		with: parser expression end.
	self
		assertParseFormattedSource: 'cases e:
	x^xs, {y} -> e1,
	[z] -> e2
	end'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatComposition [

	self
		assertParseFormattedSource: 'f comp g'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatDefExpression [

	self
		assertParseFormattedSource: 'def x:t1 = v1; y:t2 = v2 in e'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatDistributedMapMerge [

	self
		assertParseFormattedSource: 'merge s'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatDistributedSequenceConcatenation [

	self assertParseFormattedSource: 'conc s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatDistributedSetIntersection [

	self assertParseFormattedSource: 'dinter s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatDistributedSetUnion [

	self assertParseFormattedSource: 'dunion s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatEqual [

	self
		assertParseFormattedSource: 'x = y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatEqualDefinition [

	self
		assertParseFormattedSource: 'n = x + y'
		with: parser equalDefinition end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatEqualDefinitionList [

	self
		assertParseFormattedSource: 'n1 = x + y; n2 = z'
		with: parser equalDefinitionList end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatError [

	self
		assertParseFormattedSource: 'e:<ERR> -> x + y'
		with: parser error end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatErrorList [

	self
		assertParseFormattedSource: 'e1:<ERR1> -> x + y e2:<ERR2> -> z'
		with: parser errorList end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatExists1Expression [

	self
		assertParseFormattedSource: 'exists1 x in set xs & x = y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatExistsExpression [

	self
		assertParseFormattedSource: 'exists x in set xs, y in set ys & x = y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatExplicitFunctionDefinition [

	self
		assertParseFormattedSource: 'f : nat -> nat
	f(x) == n
	pre true
	post true'
		with: parser explicitFunctionDefinition end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatFieldSelect [

	self
		assertParseFormattedSource: 'x.f'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatFinitePowerSet [

	self
		assertParseFormattedSource: 'power s'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatFlatDocument [

	self
		assertParseFormattedSource: 'types n = nat values v1 : n = 0; v2 : n = v1'
		with: parser document end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatFloor [

	self assertParseFormattedSource: 'floor x' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatForallExpression [

	self
		assertParseFormattedSource: 'forall x in set xs, y in set ys & x <> y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatFunctionTypeInstantiation [

	self
		assertParseFormattedSource: 'f[nat, nat]'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatGlobalName [

	self
		assertParseFormattedSource: 'm`x'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatGreaterThan [

	self
		assertParseFormattedSource: 'x > y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatGreaterThanOrEqual [

	self
		assertParseFormattedSource: 'x >= y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatIfExpression [

	self
		assertParseFormattedSource:
		'if a > b then e1 elseif c > d then e2 else e3'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatImply [

	self
		assertParseFormattedSource: 'x = y => z = 0'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatInSet [

	self
		assertParseFormattedSource: 'x in set s'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatIotaExpression [

	self
		assertParseFormattedSource: 'iota x in set s & x = y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatIsBasicExpression [

	self
		assertParseFormattedSource: 'is_nat(x)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatIsNameExpression [

	self
		assertParseFormattedSource: 'is_T(x)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatIsNotYetSpecified [

	self
		assertParseFormattedSource: 'is not yet specified'
		with: parser isNotYetSpecified end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatIterate [

	self
		assertParseFormattedSource: 'f ** 3'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatLambdaExpression [

	self
		assertParseFormattedSource: 'lambda x:nat, y:int & x + y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatLessThan [

	self
		assertParseFormattedSource: 'x < y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatLessThanOrEqual [

	self
		assertParseFormattedSource: 'x <= y'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatLetBeExpression [

	self
		assertParseFormattedSource: 'let x, y in set s be st x = y in e'
		with: parser expression end.
	self
		assertParseFormattedSource: 'let x, y in set s in e'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatLetExpression [

	self
		assertParseFormattedSource:
		'let x : nat = 1, y = 2, f : nat -> nat f(x) == x + 1 in e'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatLocalName [

	self assertParseFormattedSource: 'x' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatLogicalEquivalence [

	self
		assertParseFormattedSource: 'p <=> q'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapComprehension [

	self
		assertParseFormattedSource:
		'{k |-> v | mk_(k, v) in set s & k <> nil}'
		with: parser expression end.
	self
		assertParseFormattedSource: '{k |-> v | mk_(k, v) in set s}'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapDomain [

	self
		assertParseFormattedSource: '{dom m}'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapDomainRestrictedBy [

	self
		assertParseFormattedSource: 's <-: m'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapDomainRestrictedTo [

	self
		assertParseFormattedSource: 's <: m'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapEnumeration [

	self
		assertParseFormattedSource: '{k1 |-> v1, k2 |-> v2}'
		with: parser expression end.
	self
		assertParseFormattedSource: '{k1 |-> v1}'
		with: parser expression end.
	self assertParseFormattedSource: '{|->}' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapInverse [

	self
		assertParseFormattedSource: 'inverse m'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapMerge [

	self
		assertParseFormattedSource: 'm1 munion m2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapOrSequenceModify [

	self
		assertParseFormattedSource: 'm1 ++ m2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapOrSequenceReference [

	self
		assertParseFormattedSource: 'm1(1)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapRange [

	self
		assertParseFormattedSource: 'rng m'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapRangeRestrictedBy [

	self
		assertParseFormattedSource: 'm :-> s'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapRangeRestrictedTo [

	self
		assertParseFormattedSource: 'm :> s'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMaplet [

	self
		assertParseFormattedSource: 'k |-> v'
		with: parser maplet end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatMapletList [

	self
		assertParseFormattedSource: 'k1 |-> v1, k2 |-> v2, k3 |-> v3'
		with: parser mapletList end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatNot [

	self assertParseFormattedSource: 'not e' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatNotEqual [

	self
		assertParseFormattedSource: 'e1 <> e2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatNotInSet [

	self
		assertParseFormattedSource: 'v not in set s'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatOldName [

	self assertParseFormattedSource: 'v~' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatOr [

	self
		assertParseFormattedSource: 'e1 or e2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatPreconditionExpression [

	self
		assertParseFormattedSource: 'pre_(f, e1, e2)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatProperSubset [

	self
		assertParseFormattedSource: 's1 psubset s2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatRecordConstructor [

	self
		assertParseFormattedSource: 'mk_r(e1, e2, e3)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatRecordModifier [

	self
		assertParseFormattedSource: 'mu(e, f1 |-> v1, f2 |-> v2)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatResult [

	self assertParseFormattedSource: 'RESULT' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceComprehension [

	self
		assertParseFormattedSource: '[x | x in set s & x = y]'
		with: parser expression end.
	self
		assertParseFormattedSource: '[x | x in set s]'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceConcatenate [

	self
		assertParseFormattedSource: 's1 ^ s2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceElements [

	self
		assertParseFormattedSource: 'elems s'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceEnumeration [

	self
		assertParseFormattedSource: '[v1, v2, v3]'
		with: parser expression end.
	self assertParseFormattedSource: '[v1]' with: parser expression end.
	self assertParseFormattedSource: '[]' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceHead [

	self assertParseFormattedSource: 'hd s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceIndices [

	self assertParseFormattedSource: 'inds s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceLength [

	self assertParseFormattedSource: 'len s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceReverse [

	self assertParseFormattedSource: 'reverse s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSequenceTail [

	self assertParseFormattedSource: 'tl s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSetCardinality [

	self assertParseFormattedSource: 'card s' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSetComprehension [

	self
		assertParseFormattedSource: '{f(v) | v in set s & p(v)}'
		with: parser expression end.
	self
		assertParseFormattedSource: '{f(v) | v in set s}'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSetDifference [

	self
		assertParseFormattedSource: 's1 \ s2'
		with: parser expression end.

]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSetEnumeration [

	self
		assertParseFormattedSource: '{v1, v2, v3}'
		with: parser expression end.
	self assertParseFormattedSource: '{v1}' with: parser expression end.
	self assertParseFormattedSource: '{}' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSetIntersection [

	self
		assertParseFormattedSource: 's1 inter s2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSetRangeExpression [

	self
		assertParseFormattedSource: '{v1, ..., v2}'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSetUnion [

	self
		assertParseFormattedSource: 's1 union s2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSubsequence [

	self
		assertParseFormattedSource: 's1(v1,...,v2)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSubset [

	self
		assertParseFormattedSource: 's1 subset s2'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatSymbolicLiteral [

	self assertParseFormattedSource: 'true' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatTokenConstructor [

	self
		assertParseFormattedSource: 'mk_token(v)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatTupleConstructor [

	self
		assertParseFormattedSource: 'mk_(v1, v2, v3)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatTupleSelect [

	self assertParseFormattedSource: 'v.#1' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatTypeJudgement [

	self
		assertParseFormattedSource: 'is_(v, t)'
		with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatUnaryMinus [

	self assertParseFormattedSource: '-v' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatUnaryPlus [

	self assertParseFormattedSource: '+v' with: parser expression end
]

{ #category : 'tests' }
ViennaVDMFormatterTest >> testFormatUndefined [

	self
		assertParseFormattedSource: 'undefined'
		with: parser expression end
]
