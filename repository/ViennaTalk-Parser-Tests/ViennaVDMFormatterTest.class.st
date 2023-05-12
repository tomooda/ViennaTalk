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
ViennaVDMFormatterTest >> testIfExpression [

	self
		assertParseFormattedSource:
		'if a > b then e1 elseif c > d then e2 else e3'
		with: parser expression end
]
