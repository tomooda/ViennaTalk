Class {
	#name : #ViennaVDMGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'document',
		'definitionBlock',
		'typeDefinitions',
		'valueDefinitions',
		'typeDefinition',
		'valueDefinition',
		'functionDefinition',
		'expression',
		'expressionExceptEquality',
		'expressionList',
		'letExpression',
		'letBeExpression',
		'defExpression',
		'ifExpression',
		'casesExpression',
		'quantifiedExpression',
		'iotaExpression',
		'setEnumeration',
		'setComprehension',
		'setRangeExpression',
		'sequenceEnumeration',
		'sequenceComprehension',
		'mapEnumeration',
		'mapComprehension',
		'tupleConstructor',
		'recordConstructor',
		'recordModifier',
		'lambdaExpression',
		'narrowExpression',
		'newExpression',
		'selfExpression',
		'threadidExpression',
		'generalIsExpr',
		'undefinedExpression',
		'preconditionExpression',
		'isofbaseclassExpression',
		'isofclassExpression',
		'samebaseclassExpression',
		'sameclassExpression',
		'actExpression',
		'finExpression',
		'activeExpression',
		'reqExpression',
		'waitingExpression',
		'timeExpression',
		'name',
		'oldName',
		'resultExpression',
		'symbolicLiteral',
		'pattern',
		'type',
		'discretionaryType',
		'type1',
		'type2',
		'type3',
		'identifier',
		'followingLetter',
		'initialLetter',
		'pattern1',
		'patternIdentifier',
		'matchValue',
		'objectPattern',
		'recordPattern',
		'multipleBind',
		'multipleSetBind',
		'multipleTypeBind',
		'patternList',
		'optionalPatternList',
		'patternBind',
		'bind',
		'bindList',
		'setBind',
		'typeBind',
		'comma',
		'lparen',
		'rparen',
		'lbrace',
		'rbrace',
		'lbracket',
		'rbracket',
		'amp',
		'colon',
		'semicolon',
		'eq',
		'bar',
		'prefix',
		'keyword',
		'char',
		'mapletArrow',
		'invariant',
		'fieldList',
		'access'
	],
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> abs: arg [
	^ arg
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> access [
	^ (self reserved: 'public') / (self reserved: 'protected') / (self reserved: 'private')
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> accessTypeDefinition [
	| static |
	static := self reserved: 'static'.
	^ (access , static optional)
		/
			((static optional , access optional)
				==> [ :pair | 
					{(pair second).
					(pair first)} ]) , typeDefinition
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> accessValueDefinition [
	^ access optional , valueDefinition
]

{ #category : #'parsers-expressions-threads and histories' }
ViennaVDMGrammar >> actExpression [
	^ ((self reserved: '#act') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third
]

{ #category : #'parsers-expressions-threads and histories' }
ViennaVDMGrammar >> activeExpression [
	^ ((self reserved: '#active') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> amp [
	^ self operator: $&
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> and: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> anonymousField [
	^ type
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> apply: func args: args [
	^ {func.
	args}
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> bar [
	^ self operator: $|
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> basicType [
	^ self
		reserved:
			'bool' asParser / 'nat1' asParser / 'nat' asParser / 'int' asParser / 'real' asParser / 'char' asParser
				/ 'token' asParser
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> bind [
	^ setBind / typeBind
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> bindList [
	^ (multipleBind separatedBy: comma) withoutSeparators
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> booleanLiteral [
	^ (self reserved: 'true' asParser ==> [ :t | true ]) / ('false' asParser ==> [ :t | false ])
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> buildApplicatorParserOn: anExpressionParser [
	| applyArgs subsequenceArgs functionTypeInstantiationArgs fieldSelector tupleSelector actions |
	applyArgs := (lparen
		, (expressionList) , rparen)
		==> [ :triple | 
			{#apply.
			(triple second)} ].
	subsequenceArgs := (lparen , expression , comma , (self operator: '...') , comma , expression , rparen)
		==> [ :array | 
			{#subsequence.
			(array second).
			(array sixth)} ].
	functionTypeInstantiationArgs := (lbracket , (type separatedBy: comma) withoutSeparators , rbracket)
		==> [ :triple | 
			{#instantiation.
			(triple second)} ].
	fieldSelector := ((self operator: $.) , identifier)
		==> [ :pair | 
			{#field.
			(pair second)} ].
	tupleSelector := ((self operator: '.#') , #digit asParser plus flatten trim)
		==> [ :pair | 
			{#tuple.
			(pair second)} ].
	actions := Dictionary new
		at: #apply put: [ :left :right | self apply: left args: right second ];
		at: #subsequence put: [ :left :right | self subsequence: left from: right second to: right third ];
		at: #instantiation put: [ :left :right | self functionTypeInstantiation: left args: right second ];
		at: #field put: [ :left :right | self fieldSelect: left with: right second ];
		at: #tuple put: [ :left :right | self tupleSelect: left with: right second ];
		yourself.
	anExpressionParser
		precedence: [ :expr | expr , (applyArgs / subsequenceArgs / functionTypeInstantiationArgs / tupleSelector / fieldSelector) plus ]
		do: [ :pair | pair second inject: pair first into: [ :left :right | (actions at: right first) value: left value: right ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> buildCombinatorParserOn: anExpressionParser [
	anExpressionParser
		group: [ :iterate | iterate right: (self operator: '**') do: [ :expr1 :op :expr2 | self iterateExpression: expr1 and: expr2 ] ];
		group: [ :comp | comp right: (self reserved: 'comp') do: [ :expr1 :op :expr2 | self compositionExpression: expr1 and: expr2 ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> buildConnectiveParserOn: anExpressionParser [
	anExpressionParser
		group: [ :p5 | p5 prefix: (self reserved: 'not') do: [ :op :arg | self not: arg ] ];
		group: [ :p4 | p4 left: (self reserved: 'and') do: [ :arg1 :op :arg2 | self and: arg1 and: arg2 ] ];
		group: [ :p3 | p3 left: (self reserved: 'or') do: [ :arg1 :op :arg2 | self or: arg1 and: arg2 ] ];
		group: [ :p2 | p2 right: (self operator: '=>') do: [ :arg1 :op :arg2 | self imp: arg1 and: arg2 ] ];
		group: [ :p1 | p1 left: (self operator: '<=>') do: [ :arg1 :op :arg2 | self equiv: arg1 and: arg2 ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> buildEvaluatorParserOn: anExpressionParser [
	anExpressionParser
		group: [ :p6 | 
					p6
						prefix: (self operator: $+) do: [ :op :arg | self unaryPlus: arg ];
						prefix: (self operator: $-) do: [ :op :arg | self unaryMinus: arg ].
					#('abs' 'floor' 'card' 'power' 'dinter' 'dunion' 'dom' 'rng' 'merge' 'len' 'elems' 'hd' 'tl' 'conc' 'inds')
						do: [ :operator | p6 prefix: (self reserved: operator) do: [ :op :arg | self perform: (op , ':') asSymbol with: arg ] ] ];
		group: [ :p5 | 
					p5 left: (self operator: ':>') do: [ :arg1 :op :arg2 | self map: arg1 rangeRestrictedTo: arg2 ].
					p5 left: (self operator: ':->') do: [ :arg1 :op :arg2 | self map: arg1 rangeRestrictedBy: arg2 ] ];
		group: [ :p4 | 
					p4 right: (self operator: '<:') do: [ :arg1 :op :arg2 | self map: arg1 domainRestrictedTo: arg2 ].
					p4 right: (self operator: '<-:') do: [ :arg1 :op :arg2 | self map: arg1 domainRestrictedBy: arg2 ] ];
		group: [ :p3 | p3 prefix: (self reserved: 'inverse') do: [ :op :arg | self inverse: arg ] ];
		group: [ :p2 | 
					p2
						left: (self operator: $*) do: [ :arg1 :op :arg2 | self mul: arg1 and: arg2 ];
						left: (self operator: $/) do: [ :arg1 :op :arg2 | self fraction: arg1 and: arg2 ];
						left: (self reserved: 'rem') do: [ :arg1 :op :arg2 | self rem: arg1 and: arg2 ];
						left: (self reserved: 'mod') do: [ :arg1 :op :arg2 | self mod: arg1 and: arg2 ];
						left: (self reserved: 'div') do: [ :arg1 :op :arg2 | self div: arg1 and: arg2 ];
						left: (self reserved: 'inter') do: [ :arg1 :op :arg2 | self inter: arg1 and: arg2 ] ];
		group: [ :p1 | 
					p1
						left: (self operator: $+) , $+ asParser not do: [ :arg1 :op :arg2 | self plus: arg1 and: arg2 ];
						left: (self operator: $-) do: [ :arg1 :op :arg2 | self minus: arg1 and: arg2 ];
						left: (self reserved: 'union') do: [ :arg1 :op :arg2 | self union: arg1 and: arg2 ];
						left: (self operator: $\) do: [ :arg1 :op :arg2 | self diff: arg1 and: arg2 ];
						left: (self reserved: 'munion') do: [ :arg1 :op :arg2 | self munion: arg1 and: arg2 ];
						left: (self operator: '++') do: [ :arg1 :op :arg2 | self mconcat: arg1 and: arg2 ];
						left: (self operator: '^') do: [ :arg1 :op :arg2 | self concat: arg1 and: arg2 ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> buildRelationParserExceptEqualityOn: anExpressionParser [
	anExpressionParser
		group: [ :p1 | 
			p1
				left: (self operator: '<>') do: [ :arg1 :op :arg2 | self notEqual: arg1 and: arg2 ];
				left: (self operator: '<=') do: [ :arg1 :op :arg2 | self lessEq: arg1 and: arg2 ];
				left: (self operator: $< asParser , $= asParser not) do: [ :arg1 :op :arg2 | self less: arg1 and: arg2 ];
				left: (self operator: '>=') do: [ :arg1 :op :arg2 | self greaterEq: arg1 and: arg2 ];
				left: (self operator: $> asParser , $= asParser not) do: [ :arg1 :op :arg2 | self greater: arg1 and: arg2 ];
				left: (self reserved: 'subset') do: [ :arg1 :op :arg2 | self subset: arg1 and: arg2 ];
				left: (self reserved: 'psubset') do: [ :arg1 :op :arg2 | self psubset: arg1 and: arg2 ];
				left: (self reserved: 'in') , (self reserved: 'set') do: [ :arg1 :op :arg2 | self inSet: arg1 and: arg2 ];
				left: (self reserved: 'not') , (self reserved: 'in') , (self reserved: 'set')
					do: [ :arg1 :op :arg2 | self notInSet: arg1 and: arg2 ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> buildRelationParserOn: anExpressionParser [
	anExpressionParser
		group: [ :p1 | 
			p1
				left: (self operator: $=) do: [ :arg1 :op :arg2 | self equal: arg1 and: arg2 ];
				left: (self operator: '<>') do: [ :arg1 :op :arg2 | self notEqual: arg1 and: arg2 ];
				left: (self operator: '<=') do: [ :arg1 :op :arg2 | self lessEq: arg1 and: arg2 ];
				left: (self operator: $< asParser , $= asParser not) do: [ :arg1 :op :arg2 | self less: arg1 and: arg2 ];
				left: (self operator: '>=') do: [ :arg1 :op :arg2 | self greaterEq: arg1 and: arg2 ];
				left: (self operator: $> asParser , $= asParser not) do: [ :arg1 :op :arg2 | self greater: arg1 and: arg2 ];
				left: (self reserved: 'subset') do: [ :arg1 :op :arg2 | self subset: arg1 and: arg2 ];
				left: (self reserved: 'psubset') do: [ :arg1 :op :arg2 | self psubset: arg1 and: arg2 ];
				left: (self reserved: 'in') , (self reserved: 'set') do: [ :arg1 :op :arg2 | self inSet: arg1 and: arg2 ];
				left: (self reserved: 'not') , (self reserved: 'in') , (self reserved: 'set')
					do: [ :arg1 :op :arg2 | self notInSet: arg1 and: arg2 ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> card: arg [
	^ arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> casesExpression [
	| others end |
	others := self reserved: 'others'.
	end := self reserved: 'end'.
	^ (((self reserved: 'cases') , expression , colon) ==> #second , self casesExpressionAlternatives
		, ((comma , others , (self operator: '->') , expression) ==> #fourth) optional , end)
		==> [ :quatro | 
			| expr alternatives othersExpr |
			expr := quatro first.
			alternatives := quatro second.
			othersExpr := quatro third.
			{expr.
			alternatives.
			othersExpr} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> casesExpressionAlternative [
	| others end |
	others := self reserved: 'others'.
	end := self reserved: 'end'.
	^ ((others / end) not and , patternList , (self operator: '->') , expression)
		==> [ :quatro | 
			| patlist expr |
			patlist := quatro second.
			expr := quatro fourth.
			{patlist.
			expr} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> casesExpressionAlternatives [
	^ (self casesExpressionAlternative separatedBy: comma) withoutSeparators
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> char [
	^ self escapeSequence / (($" asParser not , $' asParser not , #any asParser) ==> #third)
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> characterLiteral [
	^ (($' asParser , self char , $' asParser) ==> #second) trim
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> colon [
	^ self operator: $:
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> comma [
	^ self operator: $,
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> compositeType [
	^ ((self reserved: 'compose' asParser) , identifier , (self reserved: 'of') , fieldList , (self reserved: 'end'))
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> compositionExpression: expr1 and: expr2 [
	^ {expr1.
	expr2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> conc: arg [
	^ arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> concat: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> decimalLiteral [
	^ (#digit asParser plus , ((self operator: $.) , #digit asParser plus) optional
		, ($e asParser / $E asParser , ($+ asParser / $- asParser) optional , #digit asParser plus) optional) flatten trim
		==> #asLowercase
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> defExpression [
	^ ((self reserved: 'def')
		,
			((patternBind , eq , expression)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] delimitedBy: semicolon) withoutSeparators , (self reserved: 'in') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> definitionBlock [
	^ typeDefinitions / valueDefinitions
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> diff: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> dinter: arg [
	^ arg
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> discretionaryType [
	^ type / (((self operator: $() , (self operator: $))) ==> [ :pair | nil ])
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> discretionaryType1 [
	^ type1 / (((self operator: $() , (self operator: $))) ==> [ :pair | nil ])
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> div: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> document [
	^ definitionBlock star
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> dom: arg [
	^ arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> dunion: arg [
	^ arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> elems: arg [
	^ arg
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> eq [
	^ self operator: $=
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> equal: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> equalityAbstractionField [
	^ (identifier , (self operator: ':-') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> equiv: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> escapeSequence [
	| octal |
	octal := $0 asParser / $1 asParser / $2 asParser / $3 asParser / $4 asParser / $5 asParser / $6 asParser / $7 asParser.
	^ ($\ asParser
		,
			(($\ asParser ==> [ :c | $\ ]) / ($r asParser ==> [ :c | Character cr ]) / ($n asParser ==> [ :c | Character lf ])
				/ ($t asParser ==> [ :c | Character tab ]) / ($f asParser ==> [ :c | Character newPage ])
				/ ($e asParser ==> [ :c | Character escape ]) / ($a asParser ==> [ :c | Character value: 7 ])
				/
					(($x asParser , #hex asParser , #hex asParser)
						==> [ :triple | Character value: (triple second digitValue << 4) + triple third digitValue ])
				/
					(($u asParser , #hex asParser , #hex asParser , #hex asParser , #hex asParser)
						==> [ :quin | 
							Character
								value:
									(quin second digitValue << 12) + (quin third digitValue << 8) + (quin fourth digitValue << 4) + quin fifth digitValue ])
				/ (($c asParser , #any asParser) ==> [ :pair | Character value: pair second asLowercase charCode - $a + 1 ])
				/
					((octal , octal , octal)
						==> [ :triple | Character value: (triple first digitValue << 6) + (triple second digitValue << 3) + triple third digitValue ])
				/ ($" asParser ==> [ :c | $" ]) / ($' asParser ==> [ :c | $' ]))) ==> #second
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> exists1Expression [
	^ ((self reserved: 'exists1') , bind , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> existsExpression [
	^ ((self reserved: 'exists') , bindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> explicitFunctionDefinition [
	^ (identifier
		,
			(((lbracket , (self typeVariableIdentifier separatedBy: comma) withoutSeparators , rbracket) ==> #second) optional
				==> [ :vars | vars ifNil: [ Array new ] ]) , colon , (self partialFunctionType / self totalFunctionType) trim
		, identifier , ((lparen , (optionalPatternList) , rparen) ==> #second) plus
		, (self operator: '==')
		,
			(expression / ((self reserved: 'is') , (self reserved: 'subclass') , (self reserved: 'responsibility'))
				/ ((self reserved: 'is') / (self reserved: 'not') , (self reserved: 'yet') , (self reserved: 'specified')))
		, (((self reserved: 'pre') , expression) ==> #second) optional
		, (((self reserved: 'post') , expression) ==> #second) optional
		, (((self reserved: 'measure') , name) ==> #second) optional)
		==> [ :array | 
			{(array first).
			(array second).
			(array fourth).
			(array fifth).
			(array sixth).
			(array eighth).
			(array ninth).
			(array at: 10).
			(array at: 11)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> expression [
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			letExpression / letBeExpression / defExpression / ifExpression / casesExpression / quantifiedExpression / iotaExpression
				/ mapEnumeration / mapComprehension / setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration
				/ sequenceComprehension / tupleConstructor / recordConstructor / recordModifier / lambdaExpression
				/ narrowExpression / newExpression / selfExpression / threadidExpression / generalIsExpr / undefinedExpression
				/ preconditionExpression / isofbaseclassExpression / isofclassExpression / samebaseclassExpression
				/ sameclassExpression / actExpression / finExpression / activeExpression / reqExpression / waitingExpression
				/ timeExpression / name / oldName / symbolicLiteral
				/ ((lparen , expression , rparen) ==> [ :triple | triple second ]).
	self buildCombinatorParserOn: expressionParser.
	self buildApplicatorParserOn: expressionParser.
	self buildEvaluatorParserOn: expressionParser.
	self buildRelationParserOn: expressionParser.
	self buildConnectiveParserOn: expressionParser.
	^ expressionParser
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> expressionExceptEquality [
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			letExpression / letBeExpression / defExpression / ifExpression / casesExpression / quantifiedExpression / iotaExpression
				/ setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration / sequenceComprehension
				/ mapEnumeration / mapComprehension / tupleConstructor / recordConstructor / recordModifier / lambdaExpression
				/ narrowExpression / newExpression / selfExpression / threadidExpression / generalIsExpr / undefinedExpression
				/ preconditionExpression / isofbaseclassExpression / isofclassExpression / samebaseclassExpression
				/ sameclassExpression / actExpression / finExpression / activeExpression / reqExpression / waitingExpression
				/ timeExpression / name / oldName / symbolicLiteral
				/ ((lparen , expression , rparen) ==> [ :triple | triple second ]).
	self buildCombinatorParserOn: expressionParser.
	self buildApplicatorParserOn: expressionParser.
	self buildEvaluatorParserOn: expressionParser.
	self buildRelationParserExceptEqualityOn: expressionParser.
	self buildConnectiveParserOn: expressionParser.
	^ expressionParser
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> expressionList [
	^ (expression separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> extendedExplicitFunctionDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> field [
	^ (self identifiedField / self equalityAbstractionField / self anonymousField) trim
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> fieldList [
	^ ((('end' asParser , followingLetter not) not and , self field) ==> #second) star
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> fieldPattern [
	^ (identifier , mapletArrow , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> fieldPatternList [
	^ (self fieldPattern separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> fieldSelect: record with: field [
	^ {record.
	field}
]

{ #category : #'parsers-expressions-threads and histories' }
ViennaVDMGrammar >> finExpression [
	^ ((self reserved: '#fin') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> floor: arg [
	^ arg
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> followingLetter [
	^ PPPredicateObjectParser on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected'
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> forallExpression [
	^ ((self reserved: 'forall') , bindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> fraction: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> functionDefinition [
	^ self explicitFunctionDefinition / self implicitFunctionDefinition / self extendedExplicitFunctionDefinition
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> functionTypeInstantiation: func args: args [
	^ {func.
	args}
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> generalIsExpr [
	^ self isExpression / self typeJudgement
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> greater: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> greaterEq: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> hd: arg [
	^ arg
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> hexadecimalLiteral [
	^ (('0x' asParser / '0X' asParser , #hex asParser plus flatten) ==> #second) trim
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> identifiedField [
	^ (identifier , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> identifier [
	^ (prefix not , keyword not , initialLetter , followingLetter star) flatten
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> ifExpression [
	^ (((self reserved: 'if') , expression , (self reserved: 'then') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
		,
			(((self reserved: 'elseif') , expression , (self reserved: 'then') , expression)
				==> [ :quatro | 
					{(quatro second).
					(quatro fourth)} ]) star , (((self reserved: 'else') , expression) ==> #second))
		==> [ :triple | 
			{(Array
				new: triple second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple second ]).
			(triple third)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> imp: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> implicitFunctionDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> inSet: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> inds: arg [
	^ arg
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> initialFunction [
	^ self invariantInitialFunction
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> initialLetter [
	^ PPPredicateObjectParser on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected'
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> inmapType [
	^ ((self reserved: 'inmap') , type3 , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> inter: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> invariant [
	^ ((self reserved: 'inv') , self invariantFunction) ==> #second
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> invariantFunction [
	^ self invariantInitialFunction
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> invariantInitialFunction [
	^ (pattern , (self operator: '==') , expression)
		==> [ :triple | 
			| pat expr |
			pat := triple first.
			expr := triple third.
			{pat.
			expr} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> inverse: arg [
	^ arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> iotaExpression [
	^ ((self reserved: 'iota') , bind , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> isBasicExpression [
	^ ('is_bool' asParser / 'is_nat' asParser / 'is_nat1' asParser / 'is_int' asParser / 'is_rat' asParser
		/ 'is_real' asParser / 'is_char' asParser / 'is_token' asParser , lparen , expression , rparen)
		==> [ :quatro | 
			{(quatro first copyFrom: 4 to: quatro first size).
			(quatro third)} ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> isExpression [
	^ self isBasicExpression / self isNameExpression
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> isNameExpression [
	^ ('is_' asParser , name , lparen , expression , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> isofbaseclassExpression [
	^ ((self reserved: 'isofbaseclass') , lparen , name , comma , expression , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> isofclassExpression [
	^ ((self reserved: 'isofclass') , lparen , name , comma , expression , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> iterateExpression: expr1 and: expr2 [
	^ {expr1.
	expr2}
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> keyword [
	^ #('all' 'always' 'and' 'as' 'async' 'atomic' 'be' 'bool' 'by' 'card' 'cases' 'char' 'class' 'comp' 'compose' 'conc' 'cycles' 'dcl' 'def' 'definitions' 'dinter' 'div' 'dlmodule' 'do' 'dom' 'dunion' 'duration' 'elems' 'else' 'elseif' 'end' 'error' 'errs' 'exists' 'exists1' 'exit' 'exports' 'ext' 'false' 'floor' 'for' 'forall' 'from' 'functions' 'hd' 'if' 'in' 'inds' 'inmap' 'instance' 'int' 'inter' 'imports' 'init' 'inv' 'inverse' 'iota' 'is' 'isofbaseclass' 'isofclass' 'lambda' 'len' 'let' 'map' 'measure' 'merge' 'mod' 'module' 'mu' 'munion' 'mutex' 'nat' 'nat1' 'new' 'nil' 'not' 'of' 'operations' 'or' 'others' 'per' 'periodic' 'post' 'power' 'pre' 'private' 'protected' 'psubset' 'public' 'pure' 'rat' 'rd' 'real' 'rem' 'renamed' 'responsibility' 'return' 'reverse' 'rng' 'samebaseclass' 'sameclass' 'self' 'seq' 'seq1' 'set' 'skip' 'specified' 'sporadic' 'st' 'start' 'startlist' 'state' 'stop' 'stoplist' 'struct' 'subclass' 'subset' 'sync' 'system' 'then' 'thread' 'threadid' 'time' 'tixe' 'tl' 'to' 'token' 'traces' 'trap' 'true' 'types' 'undefined' 'union' 'uselib' 'values' 'variables' 'while' 'with' 'wr' 'yet' 'RESULT')
		inject: (self reserved: 'abs')
		into: [ :p :t | p / (self reserved: t) ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> lambdaExpression [
	^ ((self reserved: 'lambda') , (typeBind separatedBy: comma) withoutSeparators , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> lbrace [
	^ self operator: ${
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> lbracket [
	^ self operator: $[
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> len: arg [
	^ arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> less: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> lessEq: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> letBeExpression [
	^ ((self reserved: 'let') , multipleBind
		, (((self reserved: 'be') , (self reserved: 'st') , expression) ==> #third) optional , (self reserved: 'in')
		, expression)
		==> [ :quin | 
			{(quin second).
			(quin third).
			(quin fifth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> letExpression [
	| localDefinition |
	localDefinition := valueDefinition / functionDefinition.
	^ ((self reserved: 'let') , (localDefinition separatedBy: comma) withoutSeparators , (self reserved: 'in') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> lparen [
	^ self operator: $(
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> map: arg1 domainRestrictedBy: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> map: arg1 domainRestrictedTo: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> map: arg1 rangeRestrictedBy: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> map: arg1 rangeRestrictedTo: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> mapComprehension [
	^ (lbrace , expression , mapletArrow , expression , bar , bindList , ((amp , expression) ==> #second) optional , rbrace)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth).
			(array seventh)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> mapEnumeration [
	^ (lbrace , ((mapletArrow ==> [ :single | Array new ]) / (self maplet separatedBy: comma) withoutSeparators) , rbrace)
		==> #second
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> mapEnumerationPattern [
	^ (lbrace , ((mapletArrow ==> [ :single | Array new ]) / (self mapletPattern separatedBy: comma) withoutSeparators)
		, rbrace) ==> #second
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> mapMunionPattern [
	^ (pattern1 , (self reserved: 'munion') , pattern1)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> mapType [
	^ ((self reserved: 'map') , type3 , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> maplet [
	^ (expression , mapletArrow , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> mapletArrow [
	^ self operator: '|->'
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> mapletPattern [
	^ (pattern , mapletArrow , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> matchValue [
	^ self matchValueExpression / self matchValueLiteral
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> matchValueExpression [
	^ (lparen , expression , rparen) ==> #second
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> matchValueLiteral [
	^ symbolicLiteral
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> mconcat: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> merge: arg [
	^ arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> minus: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> mod: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> mul: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> multipleBind [
	^ multipleSetBind / multipleTypeBind
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> multipleSetBind [
	^ (patternList , (self reserved: 'in') , (self reserved: 'set') , expressionExceptEquality)
		==> [ :quatro | 
			{(quatro first).
			(quatro fourth)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> multipleTypeBind [
	^ (patternList , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> munion: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> name [
	^ (identifier , ((self operator: $`) , identifier) optional)
		==> [ :pair | 
			pair second
				ifNil: [ pair first ]
				ifNotNil: [ 
					{(pair first).
					(pair second second)} ] ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> narrowExpression [
	^ ((self reserved: 'narrow_') , lparen , expression , comma , type , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> newExpression [
	^ ((self reserved: 'new') , name , lparen
		, ((expression separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ]) , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> nilLiteral [
	^ (self reserved: 'nil') ==> [ :t |  ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> not: arg [
	^ arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> notEqual: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> notInSet: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> numericLiteral [
	^ self hexadecimalLiteral / self decimalLiteral
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> objectPattern [
	^ ('obj_' asParser , identifier , lparen , self fieldPatternList , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> oldName [
	^ (identifier , (self operator: $~)) ==> [ :pair | pair first , pair second ]
]

{ #category : #utilities }
ViennaVDMGrammar >> operator: aStringOrCharacterOrParser [
	^ aStringOrCharacterOrParser asParser trim
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> optionalPatternList [
	^ (pattern separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> optionalType [
	^ (lbracket , type , rbracket) ==> #second
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> or: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> partialFunctionType [
	^ (self discretionaryType1 , (self operator: '->') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> pattern [
	^ self setUnionPattern / self seqConcPattern / self mapMunionPattern / pattern1
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> pattern1 [
	^ self matchValue / self setEnumPattern / self seqEnumPattern / self mapEnumerationPattern / self tuplePattern / self objectPattern / self recordPattern
		/ self patternIdentifier
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> patternBind [
	^ bind / pattern
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> patternIdentifier [
	^ identifier / ((self operator: $-) ==> [ :op |  ])
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> patternList [
	^ (pattern separatedBy: comma) withoutSeparators
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> plus: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> power: arg [
	^ arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> preconditionExpression [
	^ ((self reserved: 'pre_') , lparen , (expression separatedBy: comma) withoutSeparators , rparen) ==> #third
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> prefix [
	^ 'mk_' asParser / 'pre_' asParser / 'post_' asParser / 'is_' asParser / 'obj_' asParser / 'narrow_' asParser
]

{ #category : #printing }
ViennaVDMGrammar >> printOn: aStream [
	aStream
		nextPutAll: 'a ';
		nextPutAll: self class name
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> productType [
	^ (type3 , (self operator: $*) , (type3 separatedBy: (self operator: $*)) withoutSeparators)
		==> [ :triple | 
			Array
				new: triple third size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple third ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> psubset: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> quantifiedExpression [
	^ self forallExpression / self existsExpression / self exists1Expression
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> quoteLiteral [
	^ self operator: ($< asParser , identifier , $> asParser) flatten
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> quoteType [
	^ self quoteLiteral
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> rbrace [
	^ self operator: $}
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> rbracket [
	^ self operator: $]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> recordConstructor [
	^ ('mk_' asParser , name , lparen , expressionList , rparen)
		==> [ :array | 
			{(array second).
			(array fourth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> recordModifier [
	^ ((self reserved: 'mu') , lparen , expression , comma
		,
			((identifier , mapletArrow , expression)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] separatedBy: comma) withoutSeparators , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> recordPattern [
	^ (('mk_' asParser , identifier , lparen) ==> #second
		, ((pattern separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ]) , rparen)
		==> [ :triple | 
			{(triple first).
			(triple second)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> recordTypeDefinition [
	^ (identifier , (self operator: '::') , fieldList , invariant optional)
		==> [ :quatro | 
			| ident flist inv |
			ident := quatro first.
			flist := quatro third.
			inv := quatro fourth.
			{ident.
			flist.
			inv} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> rem: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions-threads and histories' }
ViennaVDMGrammar >> reqExpression [
	^ ((self reserved: '#req') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third
]

{ #category : #utilities }
ViennaVDMGrammar >> reserved: aStringOrParser [
	^ (aStringOrParser asParser , followingLetter not) trim ==> [ :pair | pair first ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> resultExpression [
	^ (self reserved: 'RESULT') ==> [ :t |  ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> rng: arg [
	^ arg
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> rparen [
	^ self operator: $)
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> samebaseclassExpression [
	^ ((self reserved: 'samebaseclass') , lparen , expression , comma , expression , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> sameclassExpression [
	^ ((self reserved: 'sameclass') , lparen , expression , comma , expression , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> selfExpression [
	^ (self reserved: 'self') ==> [ :s |  ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> semicolon [
	^ self operator: $;
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> seq1Type [
	^ ((self reserved: 'seq1') , (self reserved: 'of') , type3) ==> #third
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> seqConcPattern [
	^ (pattern1 , (self operator: '^') , pattern1)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> seqEnumPattern [
	^ (lbracket , optionalPatternList , rbracket) ==> #second
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> seqType [
	^ ((self reserved: 'seq') , (self reserved: 'of') , type3) ==> #third
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> sequenceComprehension [
	^ (lbracket , expression , bar , setBind , ((amp , expression) ==> #second) optional , rbracket)
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> sequenceEnumeration [
	^ (lbracket , expressionList , rbracket) ==> #second
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> setBind [
	^ (pattern , (self reserved: 'in') , (self reserved: 'set') , expressionExceptEquality)
		==> [ :quatro | 
			{(quatro first).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> setComprehension [
	^ (lbrace , expression , bar , bindList , ((amp , expression) ==> #second) optional , rbrace)
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> setEnumPattern [
	^ (lbrace , optionalPatternList , rbrace) ==> #second
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> setEnumeration [
	^ (lbrace , expressionList , rbrace) ==> #second
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> setRangeExpression [
	^ (lbrace , expression , comma , (self operator: '...') , comma , expression , rbrace)
		==> [ :array | 
			{(array second).
			(array sixth)} ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> setType [
	^ ((self reserved: 'set') , (self reserved: 'of') , type3) ==> #third
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> setUnionPattern [
	^ (pattern1 , (self reserved: 'union') , pattern1)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #parsing }
ViennaVDMGrammar >> start [
	^ expression end
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> subsequence: sequence from: start to: end [
	^ {sequence.
	start.
	end}
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> subset: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> symbolicLiteral [
	^ self numericLiteral / self booleanLiteral / self nilLiteral / self characterLiteral / self textLiteral / self quoteLiteral
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> textLiteral [
	^ (($" asParser , (char star ==> [ :chars | String withAll: chars ]) , $" asParser) ==> #second) trim
]

{ #category : #'parsers-expressions-threads and histories' }
ViennaVDMGrammar >> threadidExpression [
	^ self reserved: 'threadid'
]

{ #category : #'parsers-expressions-threads and histories' }
ViennaVDMGrammar >> timeExpression [
	^ (self reserved: 'time') ==> [ :t |  ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> tl: arg [
	^ arg
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> totalFunctionType [
	^ (self discretionaryType1 , (self operator: '+>') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> tupleConstructor [
	^ ((self reserved: 'mk_') , lparen , expression , comma , (expression delimitedBy: comma) withoutSeparators , rparen)
		==> [ :array | 
			Array
				new: array fifth size + 1
				streamContents: [ :stream | 
					stream
						nextPut: array third;
						nextPutAll: array fifth ] ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> tuplePattern [
	^ ((self reserved: 'mk_') , lparen , pattern , comma , (pattern separatedBy: comma) withoutSeparators , rparen)
		==> [ :array | 
			Array
				new: array fifth size + 1
				streamContents: [ :stream | 
					stream
						nextPut: array third;
						nextPutAll: array fifth ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> tupleSelect: tuple with: index [
	^ {tuple.
	index}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type [
	^ self partialFunctionType / self totalFunctionType / type1
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type1 [
	^ self unionType / type2
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type2 [
	^ self productType / type3
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type3 [
	^ self mapType / self inmapType / self setType / self seqType / self seq1Type / self basicType / self quoteType / self compositeType / self optionalType / self typeName
		/ self typeVariable / ((lparen , type , rparen) ==> #second)
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> typeBind [
	^ (pattern , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> typeDefinition [
	^ self typeSynonym / self recordTypeDefinition
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> typeDefinitions [
	^ ((self reserved: 'types') , (self accessTypeDefinition separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second
]

{ #category : #'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> typeJudgement [
	^ ((self reserved: 'is_') , lparen , expression , comma , type , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> typeName [
	^ name
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> typeSynonym [
	^ (identifier , eq , type , invariant optional)
		==> [ :quatro | 
			{(quatro first).
			(quatro third).
			(quatro fourth)} ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> typeVariable [
	^ self typeVariableIdentifier
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> typeVariableIdentifier [
	^ ((self operator: $@) , identifier)
		==> [ :pair | 
			String
				new: pair second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: pair first;
						nextPutAll: pair second ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> unaryMinus: arg [
	^ arg
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> unaryPlus: arg [
	^ arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> undefinedExpression [
	^ (self reserved: 'undefined') ==> [ :t | nil ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> union: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> unionType [
	^ (type2 , bar , (type2 separatedBy: bar) withoutSeparators)
		==> [ :triple | 
			Array
				new: triple third size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple third ] ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> valueDefinition [
	^ (pattern , (colon , type) optional , eq , expression)
		==> [ :quatro | 
			{(quatro first).
			(quatro second ifNotNil: [ :second | second second ]).
			(quatro fourth)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> valueDefinitions [
	^ ((self reserved: 'values') , (self accessValueDefinition separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second
]

{ #category : #'parsers-expressions-threads and histories' }
ViennaVDMGrammar >> waitingExpression [
	^ ((self reserved: '#waiting') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third
]
