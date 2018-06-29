Class {
	#name : #ViennaVDMGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'document',
		'name',
		'expression',
		'statement',
		'expressionExceptEquality',
		'expressionList',
		'symbolicLiteral',
		'pattern',
		'type',
		'type1',
		'type2',
		'type3',
		'identifier',
		'followingLetter',
		'pattern1',
		'multipleBind',
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
		'colonEq',
		'eq',
		'bar',
		'mapletArrow',
		'invariant',
		'fieldList',
		'access',
		'evaluatorExpression',
		'connectiveExpression',
		'relationExpression',
		'nameList',
		'comment'
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
ViennaVDMGrammar >> accessFunctionDefinition [
	^ (access optional , self functionDefinition)
		==> [ :pair | 
			{({(pair first)} reject: #isNil).
			(pair second)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> accessOperationDefinition [
	| pure async static |
	pure := self reserved: 'pure'.
	async := self reserved: 'async'.
	static := self reserved: 'static'.
	^ (pure optional , async optional
		,
			((static , access optional)
				/
					((access optional , static optional)
						==> [ :pair | 
							{(pair second).
							(pair first)} ])) , self operationDefinition)
		==> [ :quatro | 
			{({(quatro first).
			(quatro second).
			(quatro third first).
			(quatro third second)} reject: #isNil).
			(quatro fourth)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> accessTypeDefinition [
	| static |
	static := self reserved: 'static'.
	^ (((access , static optional)
		==> [ :pair | 
			{(pair second).
			(pair first)} ]) / (static optional , access optional) , self typeDefinition)
		==> [ :pair | 
			{(pair first reject: #isNil).
			(pair second)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> accessValueDefinition [
	^ (access optional , self valueDefinition)
		==> [ :pair | 
			{({(pair first)} reject: #isNil).
			(pair second)} ]
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> applicatorExpression [
	^ (self combinatorExpression
		,
			(((lparen , expression , comma , (self operator: '...') , comma , expression , rparen)
				==> [ :array | 
					{#subsequence:from:to:.
					(array second).
					(array sixth)} ])
				/
					((lparen , expressionList , rparen)
						==> [ :array | 
							{#apply:args:.
							(array second)} ])
				/
					((lbracket , (type separatedBy: comma) withoutSeparators , rbracket)
						==> [ :array | 
							{#functionTypeInstantiation:args:.
							(array second)} ])
				/
					(((self operator: $.) , identifier trim)
						==> [ :array | 
							{#fieldSelect:with:.
							(array second)} ])
				/
					(((self operator: '.#') , #digit asParser plus flatten trim)
						==> [ :array | 
							{#tupleSelect:with:.
							(array second)} ])) star)
		==> [ :pair | 
			| left array |
			left := pair first.
			array := pair second.
			array
				inject: left
				into: [ :expr :selAndArg | 
					self
						perform: selAndArg first
						withArguments:
							(selAndArg copy
								at: 1 put: expr;
								yourself) ] ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> apply: func args: args [
	^ {func.
	args}
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> assignStatement [
	^ (self stateDesignator , colonEq , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> assignmentDefinition [
	^ (identifier trim , colon , type , (colonEq , expression) optional)
		==> [ :quatro | 
			| ident varType initialValue |
			ident := quatro first.
			varType := quatro third.
			initialValue := quatro fourth second.
			{ident.
			varType.
			initialValue} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> atomicExpression [
	^ self letExpression / self letBeExpression / self defExpression / self ifExpression / self casesExpression
		/ self quantifiedExpression / self iotaExpression / self mapEnumeration / self mapComprehension / self setEnumeration
		/ self setComprehension / self setRangeExpression / self sequenceEnumeration / self sequenceComprehension
		/ self tupleConstructor / self recordConstructor / self tokenConstructor / self recordModifier / self lambdaExpression
		/ self resultExpression / self narrowExpression / self newExpression / self selfExpression / self threadidExpression
		/ self generalIsExpr / self undefinedExpression / self preconditionExpression / self isofbaseclassExpression
		/ self isofclassExpression / self samebaseclassExpression / self sameclassExpression / self actExpression
		/ self finExpression / self activeExpression / self reqExpression / self waitingExpression / self timeExpression
		/ name / self oldName / symbolicLiteral / ((lparen , expression , rparen) ==> [ :triple | triple second ])
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

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> blockStatement [
	^ (lparen , self dclStatement star , (statement separatedBy: semicolon) withoutSeparators , semicolon optional , rparen)
		==> [ :quin | 
			| decls statements |
			decls := quin second.
			statements := quin third.
			{decls.
			statements} ]
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> booleanLiteral [
	^ (self reserved: 'true' asParser ==> [ :t | true ]) / ('false' asParser ==> [ :t | false ])
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> callStatement [
	^ (name , lparen , expressionList , rparen)
		==> [ :quatro | 
			{(quatro first).
			(quatro third)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> card: arg [
	^ arg
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> casesExpression [
	^ (((self reserved: 'cases') , expression , colon) ==> #second , self casesExpressionAlternatives
		, ((comma , self othersExpression) ==> #second) optional , (self reserved: 'end'))
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
	^ (((self reserved: 'others') / (self reserved: 'end')) not and , patternList , (self operator: '->') , expression)
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

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> casesStatement [
	^ (((self reserved: 'cases') , expression , colon) ==> #second , self casesStatementAlternatives
		, ((comma , self othersStatement) ==> #second) optional , (self reserved: 'end'))
		==> [ :quatro | 
			| expr alternatives othersExpr |
			expr := quatro first.
			alternatives := quatro second.
			othersExpr := quatro third.
			{expr.
			alternatives.
			othersExpr} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> casesStatementAlternative [
	^ (((self reserved: 'others') / (self reserved: 'end')) not and , patternList , (self operator: '->') , statement)
		==> [ :quatro | 
			| patlist expr |
			patlist := quatro second.
			expr := quatro fourth.
			{patlist.
			expr} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> casesStatementAlternatives [
	^ (self casesStatementAlternative separatedBy: comma) withoutSeparators
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> char [
	^ self escapeSequence / (($" asParser not , $' asParser not , #any asParser) ==> #third)
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> characterLiteral [
	^ (($' asParser , (self char / $" asParser) , $' asParser) ==> #second) trim
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> colon [
	^ self operator: $:
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> colonEq [
	^ self operator: ':='
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> combinatorExpression [
	| atomicExpr precedence2 precedence1 |
	atomicExpr := self atomicExpression.
	precedence2 := (atomicExpr , ((self operator: '**') , atomicExpr) star)
		==> [ :pair | 
			pair second
				ifEmpty: [ pair first ]
				ifNotEmpty: [ 
					self
						iterateExpression: pair first
						and:
							((pair second size to: 2 by: -1)
								inject: pair second last second
								into: [ :expr :index | self iterateExpression: (pair second at: index - 1) second and: expr ]) ] ].
	precedence1 := (precedence2 , ((self reserved: 'comp') , precedence2) star)
		==> [ :pair | 
			pair second
				ifEmpty: [ pair first ]
				ifNotEmpty: [ 
					self
						compositionExpression: pair first
						and:
							((pair second size to: 2 by: -1)
								inject: pair second last second
								into: [ :expr :index | self compositionExpression: (pair second at: index - 1) second and: expr ]) ] ].
	^ precedence1
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> comma [
	^ self operator: $,
]

{ #category : #'parsers-comments' }
ViennaVDMGrammar >> comment [
	^ self multiLineComment / self singleLineComment
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> compositeType [
	^ ((self reserved: 'compose' ) , identifier trim , (self reserved: 'of') , fieldList , (self reserved: 'end'))
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> connectiveExpression [
	| precedence5 precedence4 precedence3 precedence2 precedence1 |
	precedence5 := ((self reserved: 'not') star , relationExpression)
		==> [ :pair | pair first inject: pair second into: [ :expr :op | self not: expr ] ].
	precedence4 := (precedence5 , ((self reserved: 'and') , precedence5) star)
		==> [ :pair | pair second inject: pair first into: [ :expr :and | self and: expr and: and second ] ].
	precedence3 := (precedence4 , ((self reserved: 'or') , precedence4) star)
		==> [ :pair | pair second inject: pair first into: [ :expr :or | self or: expr and: or second ] ].
	precedence2 := (precedence3 , ((self operator: '=>') , precedence3) star)
		==> [ :pair | 
			pair second
				ifEmpty: [ pair first ]
				ifNotEmpty: [ 
					self
						imp: pair first
						and:
							((pair second size to: 2 by: -1)
								inject: pair second last second
								into: [ :expr :index | self imp: (pair second at: index - 1) second and: expr ]) ] ].
	precedence1 := (precedence2 , ((self operator: '<=>') , precedence2) star)
		==> [ :pair | pair second inject: pair first into: [ :expr :bool | self equiv: expr and: bool second ] ].
	^ precedence1
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> dclStatement [
	^ ((self reserved: 'dcl') , (self assignmentDefinition separatedBy: comma) withoutSeparators , semicolon) ==> #second
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> decimalLiteral [
	^ (#digit asParser plus , ((self operator: $.) , #digit asParser plus) optional
		, ($e asParser / $E asParser , ($+ asParser / $- asParser) optional , #digit asParser plus) optional) flatten trim
		==> #asLowercase
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> defExpression [
	^ ((self reserved: 'def') , (self equalDefinition delimitedBy: semicolon) withoutSeparators , (self reserved: 'in')
		, expression)
		==> [ :quatro | 
			| defs bodyExpr |
			defs := quatro second.
			bodyExpr := quatro fourth.
			{defs.
			bodyExpr} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> defStatement [
	^ ((self reserved: 'def') , self equalDefinitionList , (self reserved: 'in') , statement)
		==> [ :quatro | 
			| defs bodyStatement |
			defs := quatro second.
			bodyStatement := quatro fourth.
			{defs.
			bodyStatement} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> definitionBlock [
	^ (self typeDefinitions / self valueDefinitions / self functionDefinitions / self operationDefinitions / self stateDefinition) trim
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
	^ type / self unitType
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> discretionaryType1 [
	^ type1 / self unitType
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> div: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> document [
	^ self moduledDocument / self flatDocument
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

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> elseifExpression [
	^ ((self reserved: 'elseif') , expression , (self reserved: 'then') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> elseifStatement [
	^ ((self reserved: 'elseif') , expression , (self reserved: 'then') , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
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

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> equalDefinition [
	^ (patternBind , eq , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> equalDefinitionList [
	^ (self equalDefinition delimitedBy: semicolon) withoutSeparators
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> equalityAbstractionField [
	^ (identifier trim , (self operator: ':-') , type)
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

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> evaluatorExpression [
	| precedence6 precedence5 precedence4 precedence3 precedence2 precedence1 |
	precedence6 := ((((self operator: $+) ==> [ :plus | 'unaryPlus' ])
		/ ((self operator: $-) ==> [ :minus | 'unaryMinus' ]) / (self reserved: 'abs') / (self reserved: 'floor')
		/ (self reserved: 'card') / (self reserved: 'power') / (self reserved: 'dinter') / (self reserved: 'dunion')
		/ (self reserved: 'dom') / (self reserved: 'rng') / (self reserved: 'merge') / (self reserved: 'len')
		/ (self reserved: 'elems') / (self reserved: 'hd') / (self reserved: 'tl') / (self reserved: 'conc')
		/ (self reserved: 'inds') / (self reserved: 'reverse')) star , self applicatorExpression)
		==> [ :pair | pair first reverse inject: pair second into: [ :expr :sel | self perform: (sel , ':') asSymbol with: expr ] ].
	precedence5 := (precedence6
		,
			(((self operator: ':>') ==> [ :op | #map:rangeRestrictedTo: ])
				/ ((self operator: ':->') ==> [ :op | #map:rangeRestrictedBy: ]) , precedence6) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	precedence4 := (precedence5
		,
			(((self operator: '<:') ==> [ :op | #map:domainRestrictedTo: ])
				/ ((self operator: '<-:') ==> [ :op | #map:domainRestrictedBy: ]) , precedence5) star)
		==> [ :pair | 
			pair second
				ifEmpty: [ pair first ]
				ifNotEmpty: [ 
					self
						perform: pair second first first
						with: pair first
						with:
							((pair second size to: 2 by: -1)
								inject: pair second last second
								into: [ :expr :index | self perform: (pair second at: index) first with: (pair second at: index - 1) second with: expr ]) ] ].
	precedence3 := ((self reserved: 'inverse') star , precedence4)
		==> [ :pair | pair first inject: pair second into: [ :expr :inv | self inverse: expr ] ].
	precedence2 := (precedence3
		,
			((((self operator: $*) , precedence3)
				==> [ :pair | 
					{#mul:and:.
					(pair second)} ])
				/
					(((self operator: $/) , precedence3)
						==> [ :pair | 
							{#fraction:and:.
							(pair second)} ])
				/
					(((self reserved: 'rem') , precedence3)
						==> [ :pair | 
							{#rem:and:.
							(pair second)} ])
				/
					(((self reserved: 'mod') , precedence3)
						==> [ :pair | 
							{#mod:and:.
							(pair second)} ])
				/
					(((self reserved: 'div') , precedence3)
						==> [ :pair | 
							{#div:and:.
							(pair second)} ])
				/
					(((self reserved: 'inter') , precedence3)
						==> [ :pair | 
							{#inter:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	precedence1 := (precedence2
		,
			(((($+ asParser , $+ asParser not) trim , precedence2)
				==> [ :pair | 
					{#plus:and:.
					(pair second)} ])
				/
					(((self operator: $-) , precedence2)
						==> [ :pair | 
							{#minus:and:.
							(pair second)} ])
				/
					(((self reserved: 'union') , precedence2)
						==> [ :pair | 
							{#union:and:.
							(pair second)} ])
				/
					(((self operator: $\) , precedence2)
						==> [ :pair | 
							{#diff:and:.
							(pair second)} ])
				/
					(((self reserved: 'munion') , precedence2)
						==> [ :pair | 
							{#munion:and:.
							(pair second)} ])
				/
					(((self operator: '++') , precedence2)
						==> [ :pair | 
							{#mconcat:and:.
							(pair second)} ])
				/
					(((self operator: $^) , precedence2)
						==> [ :pair | 
							{#concat:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	^ precedence1
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
	^ (identifier trim , self typeVariableList , colon , self functionType trim , identifier trim , self parametersList
		, (self operator: '==') , (expression / self isSubclassResponsibility / self isNotYetSpecified)
		, (((self reserved: 'pre') , expression) ==> #second) optional
		, (((self reserved: 'post') , expression) ==> #second) optional
		, (((self reserved: 'measure') , name) ==> #second) optional)
		==> [ :array | 
			array first = array fifth
				ifTrue: [ 
					{(array first).
					(array second).
					(array fourth).
					(array fifth).
					(array sixth).
					(array eighth).
					(array ninth).
					(array at: 10).
					(array at: 11)} ]
				ifFalse: [ PPFailure message: 'function name mismatch: ' , array first , ', ' , array fifth ] ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> explicitOperationDefinition [
	^ (identifier trim , colon , self operationType , identifier trim , self parameters , (self operator: '==')
		, self operationBody , (((self reserved: 'pre') , expression) ==> #second) optional
		, (((self reserved: 'post') , expression) ==> #second) optional)
		==> [ :array | 
			array first = array fourth
				ifTrue: [ 
					{(array first).
					(array third).
					(array fourth).
					(array fifth).
					(array seventh).
					(array eighth).
					(array ninth)} ]
				ifFalse: [ PPFailure message: 'operation name mismatch : ' , array first , ',' , array fourth ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> exportDefinition [
	^ ((self reserved: 'exports') , self exportModuleSignature) ==> #second
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> exportFunctionsSignature [
	^ ((self reserved: 'functions') , (self functionExport separatedBy: semicolon) withoutSeparators, semicolon optional) ==> #second
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> exportModuleSignature [
	^ (self reserved: 'all') / self exportSignature plus
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> exportSignature [
	^ self exportTypesSignature / self valuesSignature / self exportFunctionsSignature / self operationsSignature
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> exportTypesSignature [
	^ ((self reserved: 'types') , (self typeExport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> expression [
	^ connectiveExpression
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> expressionExceptEquality [
	^ evaluatorExpression
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> expressionList [
	^ (expression separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> extendedExplicitFunctionDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> extendedExplicitOperationDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> field [
	^ (self identifiedField / self equalityAbstractionField / self anonymousField) trim
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> fieldList [
	^ self field star
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> fieldPattern [
	^ (identifier trim , mapletArrow , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> fieldPatternList [
	^ (self fieldPattern separatedBy: comma) withoutSeparators optional ==> [ :single | single ifNil: [ Array new ] ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> fieldReference: stateDesig with: ident [
	^ {stateDesig.
	ident}
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> fieldReferenceArg [
	^ ((self operator: $.) , identifier trim)
		==> [ :pair | 
			{#fieldReference:with:.
			(pair second)} ]
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

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> flatDocument [
	^ self definitionBlock star trim
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

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> functionDefinitions [
	^ ((self reserved: 'functions') , (self accessFunctionDefinition separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> functionExport [
	^ (nameList , self typeVariableList , (self operator: ':') , self functionType)
		==> [ :quatro | 
			{(quatro first).
			(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> functionImport [
	^ name
		,
			((self typeVariableList , (self operator: ':') , self functionType)
				==> [ :triple | 
					{(triple first).
					(triple third)} ]) optional , (((self reserved: 'renamed') , name) ==> #second) optional
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> functionSignature [
	^ (nameList , (self operator: ':') , self functionType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> functionType [
	^ self partialFunctionType / self totalFunctionType
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> functionTypeInstantiation: func args: args [
	^ {func.
	args}
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> functionsSignature [
	^ ((self reserved: 'functions') , (self functionSignature separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> generalAssignStatement [
	^ self assignStatement / self multipleAssignStatement
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
	^ (identifier trim , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> identifier [
	^ (self initialLetter , followingLetter star) flatten
		==> [ :str | 
			((self prefixes
				anySatisfy: [ :p | str size >= p size and: [ (1 to: p size) allSatisfy: [ :i | (str at: i) = (p at: i) ] ] ])
				or: [ self keywords includes: str ])
				ifTrue: [ PPFailure message: 'a keyword or prefixed word can not be an identifier' ]
				ifFalse: [ str ] ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> identityStatement [
	^ (self reserved: 'skip') ==> [ :string | nil ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> ifExpression [
	^ (((self reserved: 'if') , expression , (self reserved: 'then') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ] , self elseifExpression star , (((self reserved: 'else') , expression) ==> #second))
		==> [ :triple | 
			{(Array
				new: triple second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple second ]).
			(triple third)} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> ifStatement [
	^ (((self reserved: 'if') , expression , (self reserved: 'then') , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ] , self elseifStatement star , (((self reserved: 'else') , statement) ==> #second) optional)
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

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> implicitOperationBody [
	^ PPFailingParser new
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> implicitOperationDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> importDefinition [
	^ ((self reserved: 'from') , identifier trim , self importModuleSignature)
		==> [ :triple | 
			{(triple second).
			(triple third)} ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> importDefinitionList [
	^ ((self reserved: 'imports') , (self importDefinition separatedBy: comma) withoutSeparators) ==> #second
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> importFunctionsSignature [
	^ ((self reserved: 'functions') , (self functionImport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> importModuleSignature [
	^ (self reserved: 'all') / self importSignature plus
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> importOperationsSignature [
	^ ((self reserved: 'operations') , (self operationImport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> importSignature [
	^ self importTypesSignature / self importValuesSignature / self importFunctionsSignature
		/ self importOperationsSignature
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> importTypesSignature [
	^ ((self reserved: 'types') , (self typeImport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> importValuesSignature [
	^ ((self reserved: 'values') , (self valueImport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> inSet: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> indexForLoop [
	^ ((self reserved: 'for') , identifier trim , eq , expression , (self reserved: 'to') , expression
		, (((self reserved: 'by') , expression) ==> #second) optional , (self reserved: 'do') , statement)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth).
			(array seventh).
			(array ninth)} ]
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

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> initialisation [
	^ ((self reserved: 'init') , self invariantFunction) ==> #second
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> inmapType [
	^ ((self reserved: 'inmap') , type , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> inter: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> interface [
	^ self importDefinitionList optional , self exportDefinition
]

{ #category : #'parsers-definitions' }
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

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> isNotYetSpecified [
	^ ((self reserved: 'is') , (self reserved: 'not') , (self reserved: 'yet') , (self reserved: 'specified'))
		==> [ :array | nil ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> isSubclassResponsibility [
	^ ((self reserved: 'is') , (self reserved: 'subclass') , (self reserved: 'responsibility')) ==> [ :array | nil ]
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
	^ self keywords inject: (self reserved: 'abs') into: [ :p :t | p / (self reserved: t) ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> keywords [
	^ #('all' 'always' 'and' 'as' 'async' 'atomic' 'be' 'bool' 'by' 'card' 'cases' 'char' 'class' 'comp' 'compose' 'conc' 'cycles' 'dcl' 'def' 'definitions' 'dinter' 'div' 'dlmodule' 'do' 'dom' 'dunion' 'duration' 'elems' 'else' 'elseif' 'end' 'error' 'errs' 'exists' 'exists1' 'exit' 'exports' 'ext' 'false' 'floor' 'for' 'forall' 'from' 'functions' 'hd' 'if' 'in' 'inds' 'inmap' 'instance' 'int' 'inter' 'imports' 'init' 'inv' 'inverse' 'iota' 'is' 'isofbaseclass' 'isofclass' 'lambda' 'len' 'let' 'map' 'measure' 'merge' 'mod' 'module' 'mu' 'munion' 'mutex' 'nat' 'nat1' 'new' 'nil' 'not' 'of' 'operations' 'or' 'others' 'per' 'periodic' 'post' 'power' 'pre' 'private' 'protected' 'psubset' 'public' 'pure' 'rat' 'rd' 'real' 'rem' 'renamed' 'responsibility' 'return' 'reverse' 'rng' 'samebaseclass' 'sameclass' 'self' 'seq' 'seq1' 'set' 'skip' 'specified' 'sporadic' 'st' 'start' 'startlist' 'state' 'stop' 'stoplist' 'struct' 'subclass' 'subset' 'sync' 'system' 'then' 'thread' 'threadid' 'time' 'tixe' 'tl' 'to' 'token' 'traces' 'trap' 'true' 'types' 'undefined' 'union' 'uselib' 'values' 'variables' 'while' 'with' 'wr' 'yet' 'RESULT')
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> lambdaExpression [
	^ ((self reserved: 'lambda') , self typeBindList , amp , expression)
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

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> letBeStatement [
	^ ((self reserved: 'let') , multipleBind
		, (((self reserved: 'be') , (self reserved: 'st') , expression) ==> #third) optional , (self reserved: 'in')
		, statement)
		==> [ :quin | 
			| binds guardExpr bodyStatement |
			binds := quin second.
			guardExpr := quin third.
			bodyStatement := quin fifth.
			{binds.
			guardExpr.
			bodyStatement} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> letExpression [
	^ ((self reserved: 'let') , self localDefinitionList, (self reserved: 'in')
		, expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> letStatement [
	^ ((self reserved: 'let') , self localDefinitionList , (self reserved: 'in') , statement)
		==> [ :quatro | 
			| localDefs bodyStatement |
			localDefs := quatro second.
			bodyStatement := quatro fourth.
			{localDefs.
			bodyStatement} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> localDefinition [
	^ self valueDefinition / self functionDefinition
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> localDefinitionList [
	^ (self localDefinition separatedBy: comma) withoutSeparators
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

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> mapOrSequenceReference: stateDesig with: expr [
	^ {stateDesig.
	expr}
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> mapOrSequenceReferenceArg [
	^ (lparen , expression , rparen)
		==> [ :triple | 
			{#mapOrSequenceReference:with:.
			(triple second)} ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> mapType [
	^ ((self reserved: 'map') , type , (self reserved: 'to') , type3)
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

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> mapletList [
	^ (self maplet separatedBy: comma) withoutSeparators
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

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> module [
	^ ((self reserved: 'module') , identifier trim , self interface , self moduleBody optional , (self reserved: 'end')
		, identifier)
		==> [ :array | 
			array second = array sixth
				ifTrue: [ 
					{(array second).
					(array third).
					(array fourth)} ]
				ifFalse: [ PPFailure message: 'module name (' , array second , ') and end name (' , array sixth , ') do not agree.' ] ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> moduleBody [
	^ ((self reserved: 'definitions') , self definitionBlock plus) ==> #second
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> moduledDocument [
	^ self module plus trim
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> mul: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : #'parsers-comments' }
ViennaVDMGrammar >> multiLineComment [
	^ ('/*' asParser , ('*/' asParser not , #any asParser) star , '*/' asParser) trim plus flatten
		==> [ :str | self trimComment: str ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> multipleAssignStatement [
	| assignStatement |
	assignStatement := self assignStatement.
	^ ((self reserved: 'atomic') , lparen , assignStatement , semicolon
		, (assignStatement separatedBy: semicolon) withoutSeparators , rparen)
		==> [ :array | 
			| assign1 assigns |
			assign1 := array third.
			assigns := array fifth.
			assigns copyWithFirst: assign1 ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> multipleBind [
	^ self multipleSetBind / self multipleTypeBind
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
	^ (identifier trim , ((self operator: $`) , identifier trim) optional)
		==> [ :pair | 
			pair second
				ifNil: [ pair first ]
				ifNotNil: [ 
					{(pair first).
					(pair second second)} ] ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> nameList [
	^ (name separatedBy: comma) withoutSeparators
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

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> nondeterministicStatement [
	^ ((self operator: '||') , lparen , (statement separatedBy: comma) withoutSeparators , rparen) ==> #third
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
	^ ('obj_' asParser , identifier trim , lparen , self fieldPatternList , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> oldName [
	^ (identifier , (self operator: $~)) ==> [ :pair | pair first , pair second ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> operationBody [
	^ statement / self isSubclassResponsibility / self isNotYetSpecified
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> operationDefinition [
	^ self explicitOperationDefinition / self implicitOperationDefinition / self extendedExplicitOperationDefinition
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> operationDefinitions [
	^ ((self reserved: 'operations') , (self accessOperationDefinition separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> operationImport [
	^ name , (((self operator: ':') , self operationType) ==> #second) optional
		, (((self reserved: 'renamed') , name) ==> #second) optional
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> operationSignature [
	^ (nameList , (self operator: ':') , self operationType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> operationType [
	| discretionaryType |
	discretionaryType := self discretionaryType.
	^ (discretionaryType , (self operator: '==>') , discretionaryType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> operationsSignature [
	^ ((self reserved: 'operations') , (self operationSignature separatedBy: semicolon) withoutSeparators
		, semicolon optional) ==> #second
]

{ #category : #utilities }
ViennaVDMGrammar >> operator: aStringOrCharacterOrParser [
	^ (comment star , aStringOrCharacterOrParser asParser trim , comment star) ==> #second
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

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> othersExpression [
	^ ((self reserved: 'others') , (self operator: '->') , expression) ==> #third
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> othersStatement [
	^ ((self reserved: 'others') , (self operator: '->') , statement) ==> #third
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> parameters [
	^ (lparen , optionalPatternList , rparen) ==> #second
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> parametersList [
	^ self parameters plus
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
	^ identifier trim / ((self operator: $-) ==> [ :op |  nil])
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

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> prefixes [
	^ #('mk_' 'pre_' 'post_' 'is_' 'obj_' 'narrow_')
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
	^ ((self reserved: 'mu') , lparen , expression , comma , self mapletList , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> recordPattern [
	^ (('mk_' asParser , name , lparen) ==> #second , (patternList optional ==> [ :single | single ifNil: [ Array new ] ])
		, rparen)
		==> [ :triple | 
			{(triple first).
			(triple second)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> recordTypeDefinition [
	^ (identifier trim , (self operator: '::') , fieldList , invariant optional)
		==> [ :quatro | 
			| ident flist inv |
			ident := quatro first.
			flist := quatro third.
			inv := quatro fourth.
			{ident.
			flist.
			inv} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> relationExpression [
	^ (evaluatorExpression
		,
			((((self operator: '=') , evaluatorExpression)
				==> [ :pair | 
					{#equal:and:.
					(pair second)} ])
				/
					(((self operator: '<>') , evaluatorExpression)
						==> [ :pair | 
							{#notEqual:and:.
							(pair second)} ])
				/
					(((self operator: '<=') , evaluatorExpression)
						==> [ :pair | 
							{#lessEq:and:.
							(pair second)} ])
				/
					(((self operator: '<') , evaluatorExpression)
						==> [ :pair | 
							{#less:and:.
							(pair second)} ])
				/
					(((self operator: '>=') , evaluatorExpression)
						==> [ :pair | 
							{#greaterEq:and:.
							(pair second)} ])
				/
					(((self operator: '>') , evaluatorExpression)
						==> [ :pair | 
							{#greater:and:.
							(pair second)} ])
				/
					(((self reserved: 'subset') , evaluatorExpression)
						==> [ :pair | 
							{#subset:and:.
							(pair second)} ])
				/
					(((self reserved: 'psubset') , evaluatorExpression)
						==> [ :pair | 
							{#psubset:and:.
							(pair second)} ])
				/
					((((self reserved: 'in') , (self reserved: 'set')) ==> [ :op |  ] , evaluatorExpression)
						==> [ :pair | 
							{#inSet:and:.
							(pair second)} ])
				/
					((((self reserved: 'not') , (self reserved: 'in') , (self reserved: 'set')) ==> [ :op |  ] , evaluatorExpression)
						==> [ :pair | 
							{#notInSet:and:.
							(pair second)} ])) star)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ]
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
	^ (comment star , (aStringOrParser asParser , followingLetter not) trim , comment star)
		==> [ :triple | triple second first ]
]

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> resultExpression [
	^ (self reserved: 'RESULT') ==> [ :t |  ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> returnStatement [
	^ ((self reserved: 'return') , expression) ==> #second
]

{ #category : #'parsers-expressions-operators' }
ViennaVDMGrammar >> reverse: arg [
	^ arg
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

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> sequenceForLoop [
	^ ((self reserved: 'for') , patternBind , (self reserved: 'in') , expression , (self reserved: 'do') , statement)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth)} ]
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

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> setForLoop [
	^ ((self reserved: 'for') , (self reserved: 'all') , pattern , (self reserved: 'in') , (self reserved: 'set')
		, expression , (self reserved: 'do') , statement)
		==> [ :array | 
			{(array third).
			(array sixth).
			(array eighth)} ]
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

{ #category : #'parsers-comments' }
ViennaVDMGrammar >> singleLineComment [
	^ ('--' asParser , (Character cr asParser not , #any asParser) star) trim plus flatten
		==> [ :str | self trimComment: str ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> specificationStatement [
	^ (lbracket , self implicitOperationBody , rbracket) ==> #second
]

{ #category : #parsing }
ViennaVDMGrammar >> start [
	^ document end
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> stateDefinition [
	^ ((self reserved: 'state') , identifier trim , (self reserved: 'of') , self stateFieldList , invariant optional
		, self initialisation optional , (self reserved: 'end') , semicolon optional)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array fifth).
			(array sixth)} ]
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> stateDesignator [
	^ (name , (self fieldReferenceArg / self mapOrSequenceReferenceArg) star)
		==> [ :pair | 
			| nameDesig pairs |
			nameDesig := pair first.
			pairs := pair second.
			pairs
				inject: nameDesig
				into: [ :designator :selectorAndArg | 
					| selector refArg |
					selector := selectorAndArg first.
					refArg := selectorAndArg second.
					self perform: selector with: designator with: refArg ] ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> stateField [
	^ (identifier trim , colon , type trim)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> stateFieldList [
	^ self stateField star
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> statement [
	^ self letStatement / self letBeStatement / self defStatement / self identityStatement / self blockStatement
		/ self generalAssignStatement / self ifStatement / self casesStatement / self sequenceForLoop / self setForLoop
		/ self indexForLoop / self whileLoop / self nondeterministicStatement / self callStatement / self returnStatement
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
	^ (comment star
		,
			(self numericLiteral / self booleanLiteral / self nilLiteral / self characterLiteral / self textLiteral
				/ self quoteLiteral) , comment star) ==> #second
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> textLiteral [
	^ (($" asParser , ((self char / $' asParser) star ==> [ :chars | String withAll: chars ]) , $" asParser) ==> #second)
		trim
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

{ #category : #'parsers-expressions-basics' }
ViennaVDMGrammar >> tokenConstructor [
	^ ((self reserved: 'mk_token' asParser) , lparen , expression , rparen) ==> #third
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> totalFunctionType [
	^ (self discretionaryType1 , (self operator: '+>') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-comments' }
ViennaVDMGrammar >> trimComment: aString [
	| start end |
	start := 1.
	[ (aString at: start) isSeparator ] whileTrue: [ start := start + 1 ].
	[ start > 1 and: [ (aString at: start) ~= Character cr ] ] whileTrue: [ start := start - 1 ].
	end := aString size.
	[ (aString at: end) isSeparator ] whileTrue: [ end := end - 1 ].	"[ end < aString size and: [ (aString at: end) ~= Character cr ] ] whileTrue: [ end := end + 1 ]."
	^ aString copyFrom: start to: end
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

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> typeBindList [
	^ (typeBind separatedBy: comma) withoutSeparators
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

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> typeExport [
	^ (self reserved: 'struct') optional , name
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> typeImport [
	^ (self typeDefinition , (((self reserved: 'renamed') , name) ==> #second) optional)
		/ (name , (((self reserved: 'renamed') , name) ==> #second) optional)
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
	^ (identifier trim , eq , type , invariant optional)
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
	^ ((self operator: $@) , identifier) trim
		==> [ :pair | 
			String
				new: pair second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: pair first;
						nextPutAll: pair second ] ]
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> typeVariableList [
	^ (lbracket , (self typeVariableIdentifier separatedBy: comma) withoutSeparators , rbracket) optional ==> [:tripleOrNil | tripleOrNil ifNil: [#()] ifNotNil: [tripleOrNil second]]
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

{ #category : #'parsers-types' }
ViennaVDMGrammar >> unitType [
	^ ((self operator: $() , (self operator: $))) ==> [ :pair | nil ]
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

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> valueImport [
	^ name , (((self operator: ':') , type) ==> #second) optional
		, (((self reserved: 'renamed') , name) ==> #second) optional
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> valueSignature [
	^ (nameList , (self operator: ':') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-interfaces' }
ViennaVDMGrammar >> valuesSignature [
	^ ((self reserved: 'values') , (self valueSignature separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second
]

{ #category : #'parsers-expressions-threads and histories' }
ViennaVDMGrammar >> waitingExpression [
	^ ((self reserved: '#waiting') , lparen , (name separatedBy: comma) withoutSeparators , rparen) ==> #third
]

{ #category : #'parsers-statements' }
ViennaVDMGrammar >> whileLoop [
	^ ((self reserved: 'while') , expression , (self reserved: 'do') , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]
