Class {
	#name : #ViennaVDMGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'expression',
		'expressionExceptEquality',
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
		'tupleSelect',
		'lambdaExpression',
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
		'symbolicLiteral',
		'pattern',
		'type',
		'functionDefinition',
		'type1',
		'type2',
		'type3',
		'basicType',
		'compositeType',
		'productType',
		'unionType',
		'optionalType',
		'setType',
		'seqType',
		'seq1Type',
		'mapType',
		'inmapType',
		'typeName',
		'typeVariable',
		'quoteType',
		'quoteLiteral',
		'identifier',
		'partialFunctionType',
		'totalFunctionType',
		'numericLiteral',
		'booleanLiteral',
		'nilLiteral',
		'characterLiteral',
		'textLiteral',
		'identifiedField',
		'equalityAbstractionField',
		'anonymousField',
		'followingLetter',
		'initialLetter',
		'typeVariableIdentifier',
		'pattern1',
		'patternIdentifier',
		'matchValue',
		'setEnumPattern',
		'setUnionPattern',
		'seqEnumPattern',
		'seqConcPattern',
		'mapEnumerationPattern',
		'mapMunionPattern',
		'tuplePattern',
		'objectPattern',
		'recordPattern',
		'multipleBind',
		'valueDefinition',
		'multipleSetBind',
		'multipleTypeBind',
		'patternList',
		'patternBind',
		'bind',
		'setBind',
		'typeBind'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> abs: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> actExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> activeExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> and: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> anonymousField [
	^ type
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> apply: func args: args [
	^ {func.
	args}
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

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> booleanLiteral [
	^ self reserved: 'true' asParser / 'false' asParser
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> buildApplicatorParserOn: anExpressionParser [
	| applyArgs subsequenceArgs functionTypeInstantiationArgs fieldSelector actions |
	applyArgs := ((self operator: $()
		, ((expression separatedBy: (self operator: $,)) withoutSeparators optional ==> [ :args | args ifNil: [ Array new ] ])
		, (self operator: $)))
		==> [ :triple | 
			{#apply.
			(triple second)} ].
	subsequenceArgs := ((self operator: $() , expression , (self operator: $,) , (self operator: '...')
		, (self operator: ',') , expression , (self operator: $)))
		==> [ :array | 
			{#subsequence.
			(array second).
			(array sixth)} ].
	functionTypeInstantiationArgs := ((self operator: $[) , (type separatedBy: (self operator: $,)) withoutSeparators
		, (self operator: $]))
		==> [ :triple | 
			{#instantiation.
			(triple second)} ].
	fieldSelector := ((self operator: $.) , identifier)
		==> [ :pair | 
			{#field.
			(pair second)} ].
	actions := Dictionary new
		at: #apply put: [ :left :right | self apply: left args: right second ];
		at: #subsequence put: [ :left :right | self subsequence: left from: right second to: right third ];
		at: #instantiation put: [ :left :right | self functionTypeInstantiation: left args: right second ];
		at: #field put: [ :left :right | self fieldSelect: left with: right second ];
		yourself.
	anExpressionParser
		precedence: [ :expr | 'mk_' asParser not , expr , (applyArgs / subsequenceArgs / functionTypeInstantiationArgs / fieldSelector) plus ]
		do: [ :triple | triple third inject: triple second into: [ :left :right | (actions at: right first) value: left value: right ] ]
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
					p5 left: (self operator: ':>') do: [ :arg1 :op :arg2 | self map: arg1 rangeRestrictTo: arg2 ].
					p5 left: (self operator: ':->') do: [ :arg1 :op :arg2 | self map: arg1 rangeRestrictBy: arg2 ] ];
		group: [ :p4 | 
					p4 right: (self operator: '<:') do: [ :arg1 :op :arg2 | self map: arg1 domainRestrictTo: arg2 ].
					p4 right: (self operator: '<-:') do: [ :arg1 :op :arg2 | self map: arg1 domainRestrictBy: arg2 ] ];
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
						left: (self operator: $+) do: [ :arg1 :op :arg2 | self plus: arg1 and: arg2 ];
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> card: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> casesExpression [
	| others end |
	others := self reserved: 'others'.
	end := self reserved: 'end'.
	^ (((self reserved: 'cases') , expression , (self operator: $:)) ==> #second
		,
			(((others / end) not and , patternList , (self operator: '->') , expression)
				==> [ :quatro | 
					{(quatro second).
					(quatro fourth)} ] separatedBy: (self operator: $,)) withoutSeparators
		, (((self operator: $,) , others , (self operator: '->') , expression) ==> #fourth) optional , end)
		==> [ :quatro | 
			{(quatro first).
			(quatro second).
			(quatro third)} ]
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> characterLiteral [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> compositeType [
	| fieldList |
	fieldList := ((('end' asParser , followingLetter not) not and
		, (identifiedField / equalityAbstractionField / anonymousField) trim) ==> #second) star.
	^ ((self reserved: 'compose' asParser) , identifier , (self reserved: 'of') , fieldList , (self reserved: 'end'))
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> compositionExpression: expr1 and: expr2 [
	^ {expr1.
	expr2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> conc: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> concat: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> defExpression [
	^ ((self reserved: 'def')
		,
			((patternBind , (self operator: $=) , expression)
				==> [ :triple | 
					{(triple first).
					(triple third)} ] delimitedBy: (self operator: $;)) withoutSeparators , (self reserved: 'in') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> diff: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> dinter: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> div: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> dom: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> dunion: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> elems: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> equiv: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> expression [
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			letExpression / letBeExpression / defExpression / ifExpression / casesExpression / quantifiedExpression / iotaExpression
				/ setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration / sequenceComprehension
				/ mapEnumeration / mapComprehension / tupleConstructor / recordConstructor / recordModifier / tupleSelect
				/ lambdaExpression / newExpression / selfExpression / threadidExpression / generalIsExpr / undefinedExpression
				/ preconditionExpression / isofbaseclassExpression / isofclassExpression / samebaseclassExpression
				/ sameclassExpression / actExpression / finExpression / activeExpression / reqExpression / waitingExpression
				/ timeExpression / name / oldName / symbolicLiteral
				/ (((self operator: $() , expression , (self operator: $))) ==> [ :triple | triple second ]).
	self buildCombinatorParserOn: expressionParser.
	self buildApplicatorParserOn: expressionParser.
	self buildEvaluatorParserOn: expressionParser.
	self buildRelationParserOn: expressionParser.
	self buildConnectiveParserOn: expressionParser.
	^ expressionParser
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> expressionExceptEquality [
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			letExpression / letBeExpression / defExpression / ifExpression / casesExpression / quantifiedExpression / iotaExpression
				/ setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration / sequenceComprehension
				/ mapEnumeration / mapComprehension / tupleConstructor / recordConstructor / recordModifier / tupleSelect
				/ lambdaExpression / newExpression / selfExpression / threadidExpression / generalIsExpr / undefinedExpression
				/ preconditionExpression / isofbaseclassExpression / isofclassExpression / samebaseclassExpression
				/ sameclassExpression / actExpression / finExpression / activeExpression / reqExpression / waitingExpression
				/ timeExpression / name / oldName / symbolicLiteral
				/ (((self operator: $() , expression , (self operator: $))) ==> [ :triple | triple second ]).
	self buildCombinatorParserOn: expressionParser.
	self buildApplicatorParserOn: expressionParser.
	self buildEvaluatorParserOn: expressionParser.
	self buildRelationParserExceptEqualityOn: expressionParser.
	self buildConnectiveParserOn: expressionParser.
	^ expressionParser
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> fieldSelect: record with: field [
	^ {record.
	field}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> finExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> floor: arg [
	^ arg
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> followingLetter [
	^ PPPredicateObjectParser on: [ :char | ViennaUnicode isFollowingLetter: char ] message: 'identifier expected'
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> fraction: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> functionDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> functionTypeInstantiation: func args: args [
	^ {func.
	args}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> generalIsExpr [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> greater: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> greaterEq: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> hd: arg [
	^ arg
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> identifiedField [
	^ (identifier , (self operator: $:) , type)
		==> [ :triple | 
			Transcript
				cr;
				show: triple printString.
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> identifier [
	^ (initialLetter , followingLetter star) flatten
]

{ #category : #'parsers-expressions' }
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> imp: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> inSet: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> inds: arg [
	^ arg
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> initialLetter [
	^ PPPredicateObjectParser on: [ :char | ViennaUnicode isInitialLetter: char ] message: 'identifier expected'
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> inmapType [
	^ ((self reserved: 'inmap') , type3 , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> inter: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> inverse: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> iotaExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> isofbaseclassExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> isofclassExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> iterateExpression: expr1 and: expr2 [
	^ {expr1.
	expr2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> lambdaExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> len: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> less: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> lessEq: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> letBeExpression [
	^ ((self reserved: 'let') , multipleBind
		, (((self reserved: 'be') , (self reserved: 'st') , expression) ==> #third) optional , (self reserved: 'in')
		, expression)
		==> [ :quin | 
			{(quin second).
			(quin third).
			(quin fifth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> letExpression [
	| localDefinition |
	localDefinition := valueDefinition / functionDefinition.
	^ ((self reserved: 'let') , (localDefinition separatedBy: (self operator: $,)) withoutSeparators
		, (self reserved: 'in') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> map: arg1 domainRestrictBy: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> map: arg1 domainRestrictTo: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> map: arg1 rangeRestrictBy: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> map: arg1 rangeRestrictTo: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> mapComprehension [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> mapEnumeration [
	^ PPFailingParser new
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> mapEnumerationPattern [
	| mapletPattern |
	mapletPattern := (pattern , (self operator: '|->') , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ].
	^ ((self operator: ${)
		,
			(((self operator: '|->') ==> [ :single | Array new ])
				/ (mapletPattern separatedBy: (self operator: $,)) withoutSeparators) , (self operator: $})) ==> #second
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

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> matchValue [
	^ (((self operator: $() , expression , (self operator: $))) ==> #second) / symbolicLiteral
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> mconcat: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> merge: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> minus: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> mod: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
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
	^ (patternList , (self operator: $:) , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> munion: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> name [
	^ (identifier , ((self operator: $`) , identifier) optional)
		==> [ :pair | 
			pair second
				ifNil: [ pair first ]
				ifNotNil: [ 
					{(pair first).
					(pair second second)} ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> newExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> nilLiteral [
	^ self reserved: 'nil'
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> not: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> notEqual: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> notInSet: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> numericLiteral [
	^ PPFailingParser new
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> objectPattern [
	| fieldPattern |
	fieldPattern := (identifier , (self operator: '|->') , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ].
	^ ('obj_' asParser , identifier , (self operator: $()
		,
			((fieldPattern separatedBy: (self operator: $,)) withoutSeparators optional
				==> [ :single | single ifNil: [ Array new ] ]) , (self operator: $)))
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> oldName [
	^ PPFailingParser new
]

{ #category : #utilities }
ViennaVDMGrammar >> operator: aStringOrCharacterOrParser [
	^ aStringOrCharacterOrParser asParser trim
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> optionalType [
	^ ((self operator: $[) , type , (self operator: $])) ==> [ :triple | triple second ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> or: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> partialFunctionType [
	^ (type1 , (self operator: '->') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> pattern [
	^ setUnionPattern / seqConcPattern / mapMunionPattern / pattern1
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> pattern1 [
	^ matchValue / setEnumPattern / seqEnumPattern / mapEnumerationPattern / tuplePattern / objectPattern / recordPattern
		/ patternIdentifier
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
	^ (pattern , ((self operator: ',') , pattern) star)
		==> [ :pair | 
			Array
				new: pair second size + 1
				streamContents: [ :stream | 
					stream nextPut: pair first.
					pair second do: [ :p | stream nextPut: p second ] ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> plus: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> power: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> preconditionExpression [
	^ PPFailingParser new
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> psubset: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> quantifiedExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> quoteLiteral [
	^ self operator: ($< asParser , identifier , $> asParser) flatten
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> quoteType [
	^ quoteLiteral
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> recordConstructor [
	^ ('mk_' asParser , name , (self operator: $()
		, ((expression delimitedBy: (self operator: $,)) withoutSeparators optional ==> [ :args | args ifNil: [ Array new ] ])
		, (self operator: $)))
		==> [ :array | 
			{(array second).
			(array fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> recordModifier [
	^ PPFailingParser new
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> recordPattern [
	^ (('mk_' asParser , identifier , (self operator: $()) ==> #second
		,
			((pattern separatedBy: (self operator: $,)) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ])
		, (self operator: $)))
		==> [ :triple | 
			{(triple first).
			(triple second)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> rem: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> reqExpression [
	^ PPFailingParser new
]

{ #category : #utilities }
ViennaVDMGrammar >> reserved: aStringOrParser [
	^ (aStringOrParser asParser , followingLetter not) trim ==> [ :pair | pair first ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> rng: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> samebaseclassExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> sameclassExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> selfExpression [
	^ PPFailingParser new
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
	^ ((self operator: $[)
		,
			((pattern separatedBy: (self operator: $,)) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ])
		, (self operator: $])) ==> #second
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> seqType [
	^ ((self reserved: 'seq') , (self reserved: 'of') , type3) ==> #third
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> sequenceComprehension [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> sequenceEnumeration [
	^ PPFailingParser new
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> setBind [
	^ (pattern , (self reserved: 'in') , (self reserved: 'set') , expressionExceptEquality)
		==> [ :quatro | 
			{(quatro first).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> setComprehension [
	^ PPFailingParser new
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> setEnumPattern [
	^ ((self operator: ${)
		,
			((pattern separatedBy: (self operator: $,)) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ])
		, (self operator: $})) ==> #second
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> setEnumeration [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> setRangeExpression [
	^ PPFailingParser new
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> subsequence: sequence from: start to: end [
	^ {sequence.
	start.
	end}
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> subset: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> symbolicLiteral [
	^ numericLiteral / booleanLiteral / nilLiteral / characterLiteral / textLiteral / quoteLiteral
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> textLiteral [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> threadidExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> timeExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> tl: arg [
	^ arg
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> totalFunctionType [
	^ (type1 , (self operator: '+>') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> tupleConstructor [
	^ ((self reserved: 'mk_') , (self operator: $() , expression , (self operator: $,)
		, (expression delimitedBy: (self operator: $,)) withoutSeparators , (self operator: $)))
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
	^ (((self reserved: 'mk_') , (self operator: $()) ==> [ :pair |  ]
		,
			((pattern , (self operator: $,)
				, ((pattern separatedBy: (self operator: $,)) withoutSeparators ==> [ :single | single ifNil: [ Array new ] ]))
				==> [ :triple | 
					Array
						new: triple third size + 1
						streamContents: [ :stream | 
							stream
								nextPut: triple first;
								nextPutAll: triple third ] ]) , (self operator: $))) ==> #second
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> tupleSelect [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type [
	^ partialFunctionType / totalFunctionType / type1
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type1 [
	^ unionType / type2
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type2 [
	^ productType / type3
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type3 [
	^ mapType / inmapType / setType / seqType / seq1Type / basicType / quoteType / compositeType / optionalType / typeName
		/ typeVariable / (($( asParser trim , type , $) asParser trim) ==> [ :triple | triple second ])
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> typeBind [
	^ (pattern , (self operator: $:) , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> typeName [
	^ name
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> typeVariable [
	^ typeVariableIdentifier
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> unaryMinus: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> unaryPlus: arg [
	^ arg
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> undefinedExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> union: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> unionType [
	^ (type2 , (self operator: $|) , (type2 separatedBy: (self operator: $|)) withoutSeparators)
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
	^ (pattern , ((self operator: $:) , type) optional , (self operator: $=) , expression)
		==> [ :quatro | 
			{(quatro first).
			(quatro second ifNotNil: [ :second | second second ]).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> waitingExpression [
	^ PPFailingParser new
]
