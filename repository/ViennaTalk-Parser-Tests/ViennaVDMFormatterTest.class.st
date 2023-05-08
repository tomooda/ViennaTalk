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
ViennaVDMFormatterTest >> testFormatAssignmentDefinition [

	self
		assertParseFormattedSource: 'x : nat := y + z'
		with: parser assignmentDefinition end
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
