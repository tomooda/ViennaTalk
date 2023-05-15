Class {
	#name : #ViennaVDMFormatterTest,
	#superclass : #TestCase,
	#instVars : [
		'parser',
		'formatter'
	],
	#category : #'ViennaTalk-Parser-Tests'
}

{ #category : #asserting }
ViennaVDMFormatterTest >> assertParseFormattedSource: aString with: aPP2Node [

	| ast1 source ast2 |
	ast1 := aPP2Node parse: aString.
	self assert: ast1 isPetit2Success.
	source := formatter format: ast1.
	ast2 := aPP2Node parse: source.
	self assert: (ast1 sameAs: ast2)
]

{ #category : #running }
ViennaVDMFormatterTest >> setUp [

	parser := ViennaVDMParser new.
	formatter := ViennaVDMFormatter new
]

{ #category : #tests }
ViennaVDMFormatterTest >> testComposition [

	self
		assertParseFormattedSource: 'f comp g'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testDefExpression [

	self
		assertParseFormattedSource: 'def x:t1 = v1; y:t2 = v2 in e'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testDistributedMapMerge [

	self
		assertParseFormattedSource: 'merge s'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testDistributedSequenceConcatenation [

	self assertParseFormattedSource: 'conc s' with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testDistributedSetIntersection [

	self assertParseFormattedSource: 'dinter s' with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testDistributedSetUnion [

	self assertParseFormattedSource: 'dunion s' with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testExists1Expression [

	self
		assertParseFormattedSource: 'exists1 x in set xs & x = y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testExistsExpression [

	self
		assertParseFormattedSource: 'exists x in set xs, y in set ys & x = y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFieldSelect [

	self
		assertParseFormattedSource: 'x.f'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFinitePowerSet [

	self
		assertParseFormattedSource: 'power s'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFloor [

	self assertParseFormattedSource: 'floor x' with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testForallExpression [

	self
		assertParseFormattedSource: 'forall x in set xs, y in set ys & x <> y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatAnd [

	self
		assertParseFormattedSource: 'p and q'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatApply [

	self assertParseFormattedSource: 'f()' with: parser expression end.
	self assertParseFormattedSource: 'f(x)' with: parser expression end.
	self
		assertParseFormattedSource: 'f(x, y)'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatArithmeticAbs [

	self assertParseFormattedSource: 'abs x' with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatArithmeticDivide [

	self assertParseFormattedSource: 'x / y' with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatArithmeticIntegerDivision [

	self
		assertParseFormattedSource: 'x div y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatArithmeticMinus [

	self
		assertParseFormattedSource: 'x - y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatArithmeticMod [

	self
		assertParseFormattedSource: 'x mod y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatArithmeticMultiplication [
	self
		assertParseFormattedSource: 'x * y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatArithmeticPlus [
	self
		assertParseFormattedSource: 'x + y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatArithmeticRem [
	self
		assertParseFormattedSource: 'x rem y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatAssignmentDefinition [

	self
		assertParseFormattedSource: 'x : nat := y + z'
		with: parser assignmentDefinition end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatCasesExpression [

	self
		assertParseFormattedSource: 'cases e:
	x^xs, {y} -> e1,
	others -> e2
	end'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatEqual [

	self
		assertParseFormattedSource: 'x = y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatEqualDefinition [

	self
		assertParseFormattedSource: 'n = x + y'
		with: parser equalDefinition end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatEqualDefinitionList [

	self
		assertParseFormattedSource: 'n1 = x + y; n2 = z'
		with: parser equalDefinitionList end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatError [

	self
		assertParseFormattedSource: 'e:<ERR> -> x + y'
		with: parser error end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatErrorList [

	self
		assertParseFormattedSource: 'e1:<ERR1> -> x + y e2:<ERR2> -> z'
		with: parser errorList end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatExplicitFunctionDefinition [

	self
		assertParseFormattedSource: 'f : nat -> nat
	f(x) == n
	pre true
	post true'
		with: parser explicitFunctionDefinition end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatFlatDocument [

	self
		assertParseFormattedSource: 'types n = nat values v1 : n = 0; v2 : n = v1'
		with: parser document end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatFunctionTypeInstantiation [

	self
		assertParseFormattedSource: 'f[nat, nat]'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatGlobalName [

	self
		assertParseFormattedSource: 'm`x'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatGreaterThan [

	self
		assertParseFormattedSource: 'x > y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatGreaterThanOrEqual [

	self
		assertParseFormattedSource: 'x >= y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatIfExpression [

	self
		assertParseFormattedSource:
		'if c1 then e1 elseif c2 then e2 elseif c3 then e3 else e4'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatImply [

	self
		assertParseFormattedSource: 'x = y => z = 0'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatInSet [

	self
		assertParseFormattedSource: 'x in set s'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatIotaExpression [

	self
		assertParseFormattedSource: 'iota x in set s & x = y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatIsBasicExpression [

	self
		assertParseFormattedSource: 'is_nat(x)'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatIsNameExpression [

	self
		assertParseFormattedSource: 'is_T(x)'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatIsNotYetSpecified [

	self
		assertParseFormattedSource: 'is not yet specified'
		with: parser isNotYetSpecified end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatIterate [

	self
		assertParseFormattedSource: 'f ** 3'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatLambdaExpression [

	self
		assertParseFormattedSource: 'lambda x:nat, y:int & x + y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatLessThan [

	self
		assertParseFormattedSource: 'x < y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatLessThanOrEqual [

	self
		assertParseFormattedSource: 'x <= y'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatLetBeExpression [

	self
		assertParseFormattedSource: 'let x, y in set s be st x = y in e'
		with: parser expression end.
	self
		assertParseFormattedSource: 'let x, y in set s in e'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatLetExpression [

	self
		assertParseFormattedSource:
		'let x : nat = 1, y = 2, f : nat -> nat f(x) == x + 1 in e'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatLocalName [

	self assertParseFormattedSource: 'x' with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testFormatLogicalEquivalence [

	self
		assertParseFormattedSource: 'p <=> q'
		with: parser expression end
]

{ #category : #tests }
ViennaVDMFormatterTest >> testIfExpression [

	self
		assertParseFormattedSource:
		'if a > b then e1 elseif c > d then e2 else e3'
		with: parser expression end
]
