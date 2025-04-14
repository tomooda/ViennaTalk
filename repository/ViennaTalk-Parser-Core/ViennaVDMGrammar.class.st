Class {
	#name : 'ViennaVDMGrammar',
	#superclass : 'PP2CompositeNode',
	#traits : 'TViennaVDMLiteralParser @ {#basicSymbolicLiteral->#symbolicLiteral}',
	#classTraits : 'TViennaVDMLiteralParser classTrait',
	#instVars : [
		'default',
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
		'seqBind',
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
		'comment',
		'traceDefinition',
		'traceDefinitionList'
	],
	#classInstVars : [
		'current'
	],
	#category : 'ViennaTalk-Parser-Core',
	#package : 'ViennaTalk-Parser-Core'
}

{ #category : 'accessing - method dictionary' }
ViennaVDMGrammar class >> addSelectorSilently: selector withMethod: compiledMethod [

	self flushCurrent.
	^ super addSelectorSilently: selector withMethod: compiledMethod
]

{ #category : 'accessing' }
ViennaVDMGrammar class >> basicFlushCurrent [

	current := nil
]

{ #category : 'accessing' }
ViennaVDMGrammar class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : 'accessing' }
ViennaVDMGrammar class >> flushCurrent [

	self basicFlushCurrent.
	self allSubclassesDo: [ :class |
		class isAbstract ifFalse: [ class basicFlushCurrent ] ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> abs [
	^ self reserved: 'abs'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> abs: arg [
	^ arg
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> access [
	^ (self reserved: 'public') / (self reserved: 'protected') / (self reserved: 'private')
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> accessFunctionDefinition [

	^ comment star
	  , (access optional , self functionDefinition ==> [ :pair | 
		   { 
			   ({ pair first } reject: #isNil).
			   pair second } ]) ==> #second
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> accessOperationDefinition [

	| pure async static |
	pure := self reserved: 'pure'.
	async := self reserved: 'async'.
	static := self reserved: 'static'.
	^ comment star
	  , (pure optional , async optional , (static , access optional
		    / (access optional , static optional ==> [ :pair | 
			     { 
				     pair second.
				     pair first } ])) , self operationDefinition ==> [ :quatro | 
		   { 
			   ({ 
				    quatro first.
				    quatro second.
				    quatro third first.
				    quatro third second } reject: #isNil).
			   quatro fourth } ]) ==> #second
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> accessTypeDefinition [

	| static |
	static := self reserved: 'static'.
	^ comment star , (access , static optional ==> [ :pair | 
	   { 
		   pair second.
		   pair first } ] / (static optional , access optional)
	   , self typeDefinition ==> [ :pair | 
	   { 
		   (pair first reject: #isNil).
		   pair second } ]) ==> #second
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> accessValueDefinition [

	^ comment star
	  , (access optional , self valueDefinition ==> [ :pair | 
		   { 
			   ({ pair first } reject: #isNil).
			   pair second } ]) ==> #second
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> act [

	^ self reserved: 'act'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> actExpression [

	^ self sharp , self act , lparen , nameList , rparen ==> #fourth
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> all [
	^ self reserved: 'all'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> always [
	^ self reserved: 'always'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> alwaysStatement [
	^ (self always , statement , self in , statement)
		==> [ :quatro | 
			{quatro second.
			quatro fourth} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> amp [
	^ self operator: $&
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> and: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> andOp [
	^ self reserved: 'and'
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> anonymousField [

	^ self type: type
]

{ #category : 'parsers-expressions' }
ViennaVDMGrammar >> applicatorExpression [
	^ (self combinatorExpression
		,
			(((lparen , expression , comma , self dots , comma , expression , rparen)
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
					(((self operator: '.#') , #digit asPParser plus flatten trim)
						==> [ :array | 
							{#tupleSelect:with:.
							(array second)} ])) starA)
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

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> apply: func args: args [
	^ {func.
	args}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> arrow [
	^ self operator: '->'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> assignStatement [
	^ ((self basicStateDesignator , colonEq) and , self stateDesignator , colonEq , expression)
		==> [ :triple | 
			{(triple second).
			(triple fourth)} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> assignmentDefinition [
	^ ((self decl: identifier) trim , colon , type , (colonEq , expression) optional)
		==> [ :quatro | 
			| ident varType initialValue |
			ident := quatro first.
			varType := quatro third.
			initialValue := quatro fourth ifNotNil: #second.
			{ident.
			varType.
			initialValue} ]
]

{ #category : 'parsers-expressions' }
ViennaVDMGrammar >> atomicExpression [

	^ self letExpression / self letBeExpression / self defExpression
	  / self ifExpression / self casesExpression
	  / self quantifiedExpression / self iotaExpression
	  / self mapEnumeration / self mapComprehension / self setEnumeration
	  / self setComprehension / self setRangeExpression
	  / self sequenceEnumeration / self sequenceComprehension
	  / self tupleConstructor / self recordConstructor
	  / self tokenConstructor / self recordModifier
	  / self lambdaExpression / self resultExpression
	  / self generalIsExpr / self undefinedExpression
	  / self preconditionExpression / self historyExpression
	  / self oldName / name / symbolicLiteral
	  / (lparen , expression , rparen ==> [ :triple | triple second ])
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> bar [
	^ self operator: $|
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> basicStateDesignator [
	^ (( name) , (self fieldReferenceArg / self mapOrSequenceReferenceArg) starA)
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

{ #category : 'parsers-types' }
ViennaVDMGrammar >> basicType [
	^ self reserved: self basicTypeName
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> basicTypeName [

	^ self type: 'bool' asPParser / 'nat1' asPParser / 'nat' asPParser
		  / 'int' asPParser / 'real' asPParser / 'char' asPParser
		  / 'token' asPParser
		  / ('?' asPParser ==> [ :questionMark | 'any' ])
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> best [
	^ ((self reserved: 'be') , (self reserved: 'st')) ==> #yourself
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> bind [
	^ self setSeqBind / typeBind
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> bindList [
	^ (multipleBind separatedBy: comma) withoutSeparators
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> blockStatement [
	^ (lparen , self dclStatement starA , (statement separatedBy: semicolon) withoutSeparators , semicolon optional , rparen)
		==> [ :quin | 
			| decls statements |
			decls := quin second asArray.
			statements := quin third asArray.
			{decls.
			statements} ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> by [
	^ self reserved: 'by'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> callStatement [
	^ (name , lparen , expressionList , rparen)
		==> [ :quatro | 
			{(quatro first).
			(quatro third)} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> card [
	^ self reserved: 'card'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> card: arg [
	^ arg
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> cases [
	^ self reserved: 'cases'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> casesExpression [
	^ ((self cases , expression , colon) ==> #second , self casesExpressionAlternatives
		, ((comma , self othersExpression) ==> #second) optional , self endKeyword)
		==> [ :quatro | 
			| expr alternatives othersExpr |
			expr := quatro first.
			alternatives := quatro second.
			othersExpr := quatro third.
			{expr.
			alternatives.
			othersExpr} ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> casesExpressionAlternative [
	^ (((self reserved: 'others') / (self reserved: 'end')) not and , patternList , self arrow , expression)
		==> [ :quatro | 
			| patlist expr |
			patlist := quatro second.
			expr := quatro fourth.
			{patlist.
			expr} ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> casesExpressionAlternatives [
	^ (self casesExpressionAlternative separatedBy: comma) withoutSeparators
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> casesStatement [
	^ ((self cases , expression , colon) ==> #second , self casesStatementAlternatives
		, ((comma , self othersStatement) ==> #second) optional , self endKeyword)
		==> [ :quatro | 
			| expr alternatives othersExpr |
			expr := quatro first.
			alternatives := quatro second.
			othersExpr := quatro third.
			{expr.
			alternatives.
			othersExpr} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> casesStatementAlternative [
	^ (((self reserved: 'others') / (self reserved: 'end')) not and , patternList , self arrow , statement)
		==> [ :quatro | 
			| patlist expr |
			patlist := quatro second.
			expr := quatro fourth.
			{patlist.
			expr} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> casesStatementAlternatives [
	^ (self casesStatementAlternative separatedBy: comma) withoutSeparators
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> colon [
	^ self operator: $:
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> colonEq [
	^ self operator: ':='
]

{ #category : 'parsers-expressions' }
ViennaVDMGrammar >> combinatorExpression [
	| atomicExpr precedence2 precedence1 |
	atomicExpr := self atomicExpression.
	precedence2 := (atomicExpr , (self enumerate , atomicExpr) starA)
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
	precedence1 := (precedence2 , (self comp , precedence2) starA)
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

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> comma [
	^ self operator: $,
]

{ #category : 'parsers-comments' }
ViennaVDMGrammar >> comment [

	^ self singleLineAnnotation / self multiLineComment
	  / self singleLineComment
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> comp [
	^ self reserved: 'comp'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> compose [
	^ self reserved: 'compose'
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> compositeType [
	^ ((self reserved: 'compose') , self typeIdentifier trim , (self reserved: 'of') , fieldList , (self reserved: 'end'))
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> compositionExpression: expr1 and: expr2 [
	^ {expr1.
	expr2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> conc [
	^ self reserved: 'conc'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> conc: arg [
	^ arg
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> concat: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions' }
ViennaVDMGrammar >> connectiveExpression [
	| precedence5 precedence4 precedence3 precedence2 precedence1 |
	precedence5 := (self notOp starA , relationExpression)
		==> [ :pair | pair first inject: pair second into: [ :expr :op | self not: expr ] ].
	precedence4 := (precedence5 , (self andOp , precedence5) starA)
		==> [ :pair | pair second inject: pair first into: [ :expr :and | self and: expr and: and second ] ].
	precedence3 := (precedence4 , (self orOp , precedence4) starA)
		==> [ :pair | pair second inject: pair first into: [ :expr :or | self or: expr and: or second ] ].
	precedence2 := (precedence3 , (self impOp , precedence3) starA)
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
	precedence1 := (precedence2 , (self equivOp , precedence2) starA)
		==> [ :pair | pair second inject: pair first into: [ :expr :bool | self equiv: expr and: bool second ] ].
	^ precedence1
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> dclStatement [
	^ ((self reserved: 'dcl') , (self assignmentDefinition separatedBy: comma) withoutSeparators , semicolon) ==> #second
]

{ #category : 'utilities' }
ViennaVDMGrammar >> decl: aParser [
	^ aParser
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> def [
	^ self reserved: 'def'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> defExpression [
	^ (self def , (self equalDefinition delimitedBy: semicolon) withoutSeparators , (self reserved: 'in') , expression)
		==> [ :quatro | 
			| defs bodyExpr |
			defs := quatro second.
			bodyExpr := quatro fourth.
			{defs.
			bodyExpr} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> defStatement [
	^ (self def , self equalDefinitionList , (self reserved: 'in') , statement)
		==> [ :quatro | 
			| defs bodyStatement |
			defs := quatro second.
			bodyStatement := quatro fourth.
			{defs.
			bodyStatement} ]
]

{ #category : 'parsing' }
ViennaVDMGrammar >> default [
	^ document end
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> definitionBlock [
	^ (self typeDefinitions / self valueDefinitions / self functionDefinitions / self operationDefinitions / self stateDefinition / self tracesDefinitions) trim
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> definitions [
	^ self reserved: 'definitions'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> diff: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> diffOp [
	^ self operator: $\
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> digits [

	^ ($0 asPParser not , #digit asPParser plus) flatten
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> dinter [
	^ self reserved: 'dinter'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> dinter: arg [
	^ arg
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> discretionaryType [
	^ type / self unitType
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> discretionaryType1 [
	^ type1 / self unitType
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> div [
	^ self reserved: 'div'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> div: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> do [
	^ self reserved: 'do'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> document [

	^ comment trim star , (self flatDocument / self moduledDocument)
	  , comment trim star ==> #second
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> dom [
	^ self reserved: 'dom'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> dom: arg [
	^ arg
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> dots [
	^ self operator: '...'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> doublebar [
	^ self operator: '||'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> dunion [
	^ self reserved: 'dunion'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> dunion: arg [
	^ arg
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> elems [
	^ self reserved: 'elems'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> elems: arg [
	^ arg
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> else [
	^ self reserved: 'else'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> elseif [
	^ self reserved: 'elseif'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> elseifExpression [
	^ (self elseif , expression , self then , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> elseifStatement [
	^ (self elseif , expression , self then , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> endKeyword [
	^ self reserved: 'end'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> enumerate [
	^ self operator: '**'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> eq [
	^ self operator: $=
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> eqOp [
	^ self operator: $=
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> equal: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> equalDefinition [
	^ (patternBind , eq , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> equalDefinitionList [
	^ (self equalDefinition delimitedBy: semicolon) withoutSeparators
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> equalityAbstractionField [

	^ (self decl: identifier) trim , (self operator: ':-')
	  , (self type: type) ==> [ :triple |
	  {
		  triple first.
		  triple third } ]
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> equiv: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> equivOp [
	^ self operator: '<=>'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> error [
	^ (identifier trim , colon , expression , self arrow , expression)
		==> [ :quin | 
			{quin first.
			quin third.
			quin fifth} ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> errorList [
	^ self error plusA
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> errorStatement [
	^ (self reserved: 'error') flatten
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> errs [
	^ self reserved: 'errs'
]

{ #category : 'parsers-expressions' }
ViennaVDMGrammar >> evaluatorExpression [
	| precedence6 precedence5 precedence4 precedence3 precedence2 precedence1 |
	precedence6 := ((((self operator: $+) ==> [ :plus | 'unaryPlus' ])
		/ ((self operator: $-) ==> [ :minus | 'unaryMinus' ]) / self abs / self floor / self card / self power / self dinter
		/ self dunion / self dom / self rng / self merge / self len / self elems / self hd / self tl / self conc / self inds
		/ self reverse) starA , self applicatorExpression)
		==> [ :pair | pair first reverse inject: pair second into: [ :expr :sel | self perform: (sel , ':') asSymbol with: expr ] ].
	precedence5 := (precedence6
		,
			((self mapRangeRestrictedTo ==> [ :op | #map:rangeRestrictedTo: ])
				/ (self mapRangeRestrictedBy ==> [ :op | #map:rangeRestrictedBy: ]) , precedence6) starA)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	precedence4 := (precedence5
		,
			((self mapDomainRestrictedTo ==> [ :op | #map:domainRestrictedTo: ])
				/ (self mapDomainRestrictedBy ==> [ :op | #map:domainRestrictedBy: ]) , precedence5) starA)
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
	precedence3 := (self inverse starA , precedence4)
		==> [ :pair | pair first inject: pair second into: [ :expr :inv | self inverse: expr ] ].
	precedence2 := (precedence3
		,
			(((self starOp , precedence3)
				==> [ :pair | 
					{#mul:and:.
					(pair second)} ])
				/
					((self slash , precedence3)
						==> [ :pair | 
							{#fraction:and:.
							(pair second)} ])
				/
					((self rem , precedence3)
						==> [ :pair | 
							{#rem:and:.
							(pair second)} ])
				/
					((self mod , precedence3)
						==> [ :pair | 
							{#mod:and:.
							(pair second)} ])
				/
					((self div , precedence3)
						==> [ :pair | 
							{#div:and:.
							(pair second)} ])
				/
					((self inter , precedence3)
						==> [ :pair | 
							{#inter:and:.
							(pair second)} ])) starA)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	precedence1 := (precedence2
		,
			(((self plusOp , precedence2)
				==> [ :pair | 
					{#plus:and:.
					(pair second)} ])
				/
					((self minusOp , precedence2)
						==> [ :pair | 
							{#minus:and:.
							(pair second)} ])
				/
					((self union , precedence2)
						==> [ :pair | 
							{#union:and:.
							(pair second)} ])
				/
					((self diffOp , precedence2)
						==> [ :pair | 
							{#diff:and:.
							(pair second)} ])
				/
					((self munion , precedence2)
						==> [ :pair | 
							{#munion:and:.
							(pair second)} ])
				/
					((self plusPlusOp , precedence2)
						==> [ :pair | 
							{#mconcat:and:.
							(pair second)} ])
				/
					((self hatOp , precedence2)
						==> [ :pair | 
							{#concat:and:.
							(pair second)} ])) starA)
		==> [ :pair | 
			pair second
				inject: pair first
				into: [ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ].
	^ precedence1
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> exceptions [
	^ (self errs), self errorList ==> #second
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> exists [
	^ self reserved: 'exists'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> exists1 [
	^ self reserved: 'exists1'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> exists1Expression [
	^ (self exists1 , bind , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> existsExpression [
	^ (self exists , bindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> exit [
	^ self reserved: 'exit'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> exitStatement [
	^ (self exit , expression) ==> #second
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> explicitFunctionDefinition [

	^ identifier trim , self typeVariableList , colon
	  , self functionType trim , (self decl: identifier) trim
	  , self parametersList , (self operator: '==')
	  , (expression / self isNotYetSpecified)
	  , (self pre , self prePostFunctionDefinition ==> #second) optional
	  , (self post , self prePostFunctionDefinition ==> #second) optional
	  , (self measure , expression ==> #second) optional ==> [ :array |
	  array first = array fifth
		  ifTrue: [
			  {
				  array first.
				  array second.
				  array fourth.
				  array fifth.
				  array sixth.
				  array eighth.
				  array ninth.
				  (array at: 10).
				  (array at: 11) } ]
		  ifFalse: [
			  PP2Failure message:
				  'function name mismatch: ' , array first , ', ' , array fifth ] ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> explicitOperationDefinition [

	^ identifier trim , colon , self operationType
	  , (self decl: identifier) trim , self parameters
	  , (self operator: '==') , self operationBody
	  , (self pre , self prePostFunctionDefinition ==> #second) optional
	  , (self post , self prePostFunctionDefinition ==> #second) optional
	  ==> [ :array |
		  array first = array fourth
			  ifTrue: [
				  {
					  array first.
					  array third.
					  array fourth.
					  array fifth.
					  array seventh.
					  array eighth.
					  array ninth } ]
			  ifFalse: [
				  PP2Failure message:
					  'operation name mismatch : ' , array first , ',' , array fourth ] ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> exportDefinition [
	^ (self exports , self exportModuleSignature) ==> #second
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> exportFunctionsSignature [
	^ (self functions , (self functionExport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> exportModuleSignature [
	^ self all / self exportSignature plusA
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> exportOperationsSignature [
	^ (self operations , (self operationExport separatedBy: semicolon) withoutSeparators , semicolon optional)
		==> #second
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> exportSignature [
	^ self exportTypesSignature / self exportValuesSignature / self exportFunctionsSignature / self exportOperationsSignature
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> exportTypesSignature [
	^ (self types , (self typeExport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> exportValuesSignature [
	^ (self values , (self valueExport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> exports [
	^ self reserved: 'exports'
]

{ #category : 'parsers-expressions' }
ViennaVDMGrammar >> expression [

	^ connectiveExpression
]

{ #category : 'parsers-expressions' }
ViennaVDMGrammar >> expressionExceptEquality [
	^ evaluatorExpression
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> expressionList [
	^ (expression separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> ext [
	^ self reserved: 'ext'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> extendedExplicitFunctionDefinition [

	^ identifier trim , self typeVariableList , self parameterTypes
	  , self identifierTypePairList
	  , ((self operator: '==') , (expression / self isNotYetSpecified)
		   ==> #second)
	  , (self pre , self prePostFunctionDefinition ==> #second) optional
	  , (self post , self prePostFunctionDefinition ==> #second) optional
	  , (self measure , expression ==> #second) optional
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> extendedExplicitOperationDefinition [

	^ identifier trim , self parameterTypes
	  , self identifierTypePairList optional
	  , ((self operator: '==') , self operationBody ==> #second)
	  , self externals optional
	  , (self pre , self prePostFunctionDefinition ==> #second) optional
	  , (self post , self prePostFunctionDefinition ==> #second) optional
	  , self exceptions optional
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> externals [
	^ (self ext , self varInformation plusA) ==> #second
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> field [
	^ (self identifiedField / self equalityAbstractionField / self anonymousField) trim
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> fieldList [
	^ self field starA
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> fieldReference: stateDesig with: ident [
	^ {stateDesig.
	ident}
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> fieldReferenceArg [
	^ ((self operator: $.) , identifier trim)
		==> [ :pair | 
			{#fieldReference:with:.
			(pair second)} ]
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> fieldSelect: record with: field [
	^ {record.
	field}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> fin [

	^ self reserved: 'fin'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> finExpression [

	^ self sharp , self fin , lparen , nameList , rparen ==> #fourth
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> flatDocument [
	^ self definitionBlock plusA trim
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> floor [
	^ self reserved: 'floor'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> floor: arg [
	^ arg
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> followingLetter [
	^ PP2PredicateObjectNode on: [ :c | ViennaUnicode isFollowingLetter: c ] message: 'identifier expected'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> for [
	^ self reserved: 'for'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> forall [
	^ self reserved: 'forall'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> forallExpression [
	^ (self forall , bindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> fraction: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> from [
	^ self reserved: 'from'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> functionDefinition [
	^ self explicitFunctionDefinition / self implicitFunctionDefinition / self extendedExplicitFunctionDefinition
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> functionDefinitions [

	^ self functions
	  , (self accessFunctionDefinition separatedBy: semicolon)
			  withoutSeparators optional , semicolon optional
	  ==> [ :triple | triple second ifNil: [ Array new ] ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> functionExport [
	^ (nameList , self typeVariableList , (self operator: ':') , self functionType)
		==> [ :quatro | 
			{(quatro first).
			(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> functionImport [
	^ (name
		,
			((self typeVariableList , (self operator: ':') , self functionType)
				==> [ :triple | 
					{(triple first).
					(triple third)} ]) optional , ((self renamed , (self decl: name)) ==> #second) optional)
		==> [ :triple | 
			{(triple first).
			(triple second ifNotNil: [ :paramAndType | paramAndType first ]).
			(triple second ifNotNil: [ :paramAndType | paramAndType second ]).
			(triple third)} ]
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> functionType [
	^ self partialFunctionType / self totalFunctionType
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> functionTypeInstantiation: func args: args [
	^ {func.
	args}
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> functions [
	^ self reserved: 'functions'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> generalAssignStatement [
	^ self assignStatement / self multipleAssignStatement
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> generalIsExpr [
	^ self isExpression / self typeJudgement
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> greater [
	^ self operator: '>'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> greater: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> greaterEq: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> greaterOrEqual [
	^ self operator: '>='
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> hatOp [
	^ self operator: $^
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> hd [
	^ self reserved: 'hd'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> hd: arg [
	^ arg
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> historyExpression [

	^ $# asPParser and
	  , (self actExpression / self rdExpression / self wrExpression)
	  ==> #second
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> identifiedField [

	^ (self decl: identifier) trim , colon , (self type: type)
	  ==> [ :triple |
		  {
			  triple first.
			  triple third } ]
]

{ #category : 'accessing' }
ViennaVDMGrammar >> identifier [

	^ comment trim star
	  ,
		  ((self initialLetter , followingLetter starA) flatten
		   ==> [ :str |
			   ((self prefixes anySatisfy: [ :p |
				     str size >= p size and: [
					     (1 to: p size) allSatisfy: [ :i | (str at: i) = (p at: i) ] ] ])
				    or: [ self keywords includes: str ])
				   ifTrue: [
					   PP2Failure message:
						   'a keyword or prefixed word can not be an identifier' ]
				   ifFalse: [ str ] ]) , comment trim star ==> #second
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> identifierTypePairList [

	^ (self patternIdentifier trim , colon , type separatedBy: comma)
		  withoutSeparators optional ==> [ :triples |
	  triples ifNil: [ Array new ] ifNotNil: [
		  | array |
		  array := Array new: triples size * 2.
		  1 to: triples size do: [ :index |
			  array at: index * 2 - 1 put: (triples at: index) first.
			  array at: index * 2 put: (triples at: index) third ].
		  array ] ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> identityStatement [
	^ self skip ==> [ :string | nil ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> if [
	^ self reserved: 'if'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> ifExpression [
	^ ((self if , expression , self then , expression)
		==> [ :quatro | 
			{quatro second.
			quatro fourth} ] , self elseifExpression starA
		, ((self else , expression) ==> #second))
		==> [ :triple | 
			{(Array
				new: triple second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple second ]).
			triple third} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> ifStatement [
	^ ((self if , expression , self then , statement)
		==> [ :quatro | 
			{quatro second.
			quatro fourth} ] , self elseifStatement starA
		, ((self else , statement) ==> #second) optional)
		==> [ :triple | 
			{(Array
				new: triple second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: triple first;
						nextPutAll: triple second ]).
			triple third} ]
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> imp: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> impOp [
	^ self operator: '=>'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> implicitFunctionDefinition [

	^ identifier trim , self typeVariableList , self parameterTypes
	  , self identifierTypePairList
	  , (self pre , self prePostFunctionDefinition ==> #second) optional
	  , (self post , self prePostFunctionDefinition ==> #second)
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> implicitOperationBody [

	^ self externals optional
	  , (self pre , self prePostFunctionDefinition ==> #second) optional
	  , (self post , self prePostFunctionDefinition ==> #second)
	  , self exceptions optional
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> implicitOperationDefinition [
	^ identifier trim , self parameterTypes
		, self identifierTypePairList optional , self implicitOperationBody
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> importDefinition [
	^ (self from , identifier trim , self importModuleSignature)
		==> [ :triple | 
			{(triple second).
			(triple third)} ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> importDefinitionList [
	^ (self imports , (self importDefinition separatedBy: comma) withoutSeparators) ==> #second
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> importFunctionsSignature [
	^ (self functions , (self functionImport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> importModuleSignature [
	^ self all / self importSignature plusA
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> importOperationsSignature [
	^ (self operations , (self operationImport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> importSignature [
	^ self importTypesSignature / self importValuesSignature / self importFunctionsSignature
		/ self importOperationsSignature
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> importTypesSignature [
	^ (self types , (self typeImport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> importValuesSignature [
	^ (self values , (self valueImport separatedBy: semicolon) withoutSeparators , semicolon optional) ==> #second
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> imports [
	^ self reserved: 'imports'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> in [
	^ self reserved: 'in'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> inSet: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> indexForLoop [

	^ self for , self patternIdentifier trim , eq , expression , self to
	  , expression , (self by , expression ==> #second) optional
	  , self do , statement ==> [ :array |
	  {
		  array second.
		  array fourth.
		  array sixth.
		  array seventh.
		  array ninth } ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> inds [
	^ self reserved: 'inds'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> inds: arg [
	^ arg
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> init [
	^ self reserved: 'init'
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> initialFunction [
	^ self invariantInitialFunction
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> initialLetter [
	^ PP2PredicateObjectNode on: [ :c | ViennaUnicode isInitialLetter: c ] message: 'identifier expected'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> initialisation [
	^ (self init , self invariantFunction) ==> #second
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> inmapType [
	^ ((self reserved: 'inmap') , type , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> inseq [

	^ (self reserved: 'in') , (self reserved: 'seq')
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> inset [

	^ (self reserved: 'in') , (self reserved: 'set')
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> inter [
	^ self reserved: 'inter'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> inter: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> interface [
	^ self importDefinitionList optional , self exportDefinition
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> inv [
	^ self reserved: 'inv'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> invariant [
	^ (self inv , self invariantFunction) ==> #second
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> invariantFunction [
	^ self invariantInitialFunction
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> invariantInitialFunction [
	^ (pattern , (self operator: '==') , expression)
		==> [ :triple | 
			| pat expr |
			pat := triple first.
			expr := triple third.
			{pat.
			expr} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> inverse [
	^ self reserved: 'inverse'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> inverse: arg [
	^ arg
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> iota [
	^ self reserved: 'iota'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> iotaExpression [
	^ (self iota , bind , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> isBasicExpression [
	^ ('is_' asPParser , self basicTypeName , lparen , expression , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : 'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> isExpression [
	^ self isBasicExpression / self isNameExpression
]

{ #category : 'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> isNameExpression [

	^ 'is_' asPParser , (self type: name) , lparen , expression , rparen
	  ==> [ :quin |
		  {
			  quin second.
			  quin fourth } ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> isNotYetSpecified [
	^ ((self reserved: 'is') , (self reserved: 'not') , (self reserved: 'yet') , (self reserved: 'specified'))
		==> [ :array | nil ]
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> iterateExpression: expr1 and: expr2 [
	^ {expr1.
	expr2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> keyword [
	^ self keywords inject: (self reserved: 'abs') into: [ :p :t | p / (self reserved: t) ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> keywords [
	^ #('all' 'always' 'and' 'as' 'async' 'atomic' 'be' 'bool' 'by' 'card' 'cases' 'char' 'class' 'comp' 'compose' 'conc' 'cycles' 'dcl' 'def' 'definitions' 'dinter' 'div' 'dlmodule' 'do' 'dom' 'dunion' 'duration' 'elems' 'else' 'elseif' 'end' 'error' 'errs' 'exists' 'exists1' 'exit' 'exports' 'ext' 'false' 'floor' 'for' 'forall' 'from' 'functions' 'hd' 'if' 'in' 'inds' 'inmap' 'instance' 'int' 'inter' 'imports' 'init' 'inv' 'inverse' 'iota' 'is' 'isofbaseclass' 'isofclass' 'lambda' 'len' 'let' 'map' 'measure' 'merge' 'mod' 'module' 'mu' 'munion' 'mutex' 'nat' 'nat1' 'new' 'nil' 'not' 'of' 'operations' 'or' 'others' 'per' 'periodic' 'post' 'power' 'pre' 'pre_' 'private' 'protected' 'psubset' 'public' 'pure' 'rat' 'rd' 'real' 'rem' 'renamed' 'responsibility' 'return' 'reverse' 'rng' 'samebaseclass' 'sameclass' 'self' 'seq' 'seq1' 'set' 'set1' 'skip' 'specified' 'sporadic' 'st' 'start' 'startlist' 'state' 'stop' 'stoplist' 'struct' 'subclass' 'subset' 'sync' 'system' 'then' 'thread' 'threadid' 'time' 'tixe' 'tl' 'to' 'token' 'traces' 'trap' 'true' 'types' 'undefined' 'union' 'uselib' 'values' 'variables' 'while' 'with' 'wr' 'yet' 'RESULT')
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> lambda [
	^ self reserved: 'lambda'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> lambdaExpression [
	^ (self lambda , self typeBindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> lbrace [
	^ self operator: ${
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> lbracket [
	^ self operator: $[
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> len [
	^ self reserved: 'len'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> len: arg [
	^ arg
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> less [
	^ self operator: '<'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> less: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> lessEq: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> lessOrEqual [
	^ self operator: '<='
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> let [
	^ self reserved: 'let'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> letBeExpression [
	^ ((self reserved: 'let') , multipleBind , ((self best , expression) ==> #second) optional , self in , expression)
		==> [ :quin | 
			{(quin second).
			(quin third).
			(quin fifth)} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> letBeStatement [
	^ (self let , multipleBind , ((self best , expression) ==> #second) optional , self in , statement)
		==> [ :quin | 
			| binds guardExpr bodyStatement |
			binds := quin second.
			guardExpr := quin third.
			bodyStatement := quin fifth.
			{binds.
			guardExpr.
			bodyStatement} ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> letExpression [
	^ (self let , self localDefinitionList , self in , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> letStatement [
	^ (self let , self localDefinitionList , self in , statement)
		==> [ :quatro | 
			| localDefs bodyStatement |
			localDefs := quatro second.
			bodyStatement := quatro fourth.
			{localDefs.
			bodyStatement} ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> localDefinition [
	^ self valueDefinition / self functionDefinition
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> localDefinitionList [
	^ (self localDefinition separatedBy: comma) withoutSeparators
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> lparen [
	^ self operator: $(
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> map: arg1 domainRestrictedBy: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> map: arg1 domainRestrictedTo: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> map: arg1 rangeRestrictedBy: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> map: arg1 rangeRestrictedTo: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> mapComprehension [
	^ (lbrace , expression , mapletArrow , expression , bar , bindList , ((amp , expression) ==> #second) optional , rbrace)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth).
			(array seventh)} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> mapDomainRestrictedBy [
	^ self operator: '<-:'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> mapDomainRestrictedTo [
	^ self operator: '<:'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> mapEnumeration [
	^ (lbrace , ((mapletArrow ==> [ :single | Array new ]) / (self maplet separatedBy: comma) withoutSeparators) , rbrace)
		==> #second
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> mapEnumerationPattern [
	^ (lbrace , ((mapletArrow ==> [ :single | Array new ]) / (self mapletPattern separatedBy: comma) withoutSeparators)
		, rbrace) ==> #second
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> mapMunionPattern [
	^ (pattern1 , (self reserved: 'munion') , pattern1)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> mapOrSequenceReference: stateDesig with: expr [
	^ {stateDesig.
	expr}
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> mapOrSequenceReferenceArg [
	^ (lparen , expression , rparen)
		==> [ :triple | 
			{#mapOrSequenceReference:with:.
			(triple second)} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> mapRangeRestrictedBy [
	^ self operator: ':->'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> mapRangeRestrictedTo [
	^ self operator: ':>'
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> mapType [
	^ ((self reserved: 'map') , type , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> maplet [
	^ (expression , mapletArrow , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> mapletArrow [
	^ self operator: '|->'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> mapletList [
	^ (self maplet separatedBy: comma) withoutSeparators
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> mapletPattern [
	^ (pattern , mapletArrow , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> matchValue [
	^ self matchValueExpression / self matchValueLiteral
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> matchValueExpression [
	^ (lparen , expression , rparen) ==> #second
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> matchValueLiteral [
	^ symbolicLiteral
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> mconcat: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> measure [
	^ self reserved: 'measure'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> merge [
	^ self reserved: 'merge'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> merge: arg [
	^ arg
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> minus: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> minusOp [
	^ self operator: $-
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> mod [
	^ self reserved: 'mod'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> mod: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> mode [
	^ self rd / self wr
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> module [
	^ (self moduleKeyword , (self decl: self moduleIdentifier) trim
		, self interface , self moduleBody optional , self endKeyword
		, self moduleIdentifier) trimBlanks
		==> [ :array | 
			array second = array sixth
				ifTrue: [ {array second.
					array third.
					array fourth} ]
				ifFalse: [ PP2Failure
						message:
							'module name (' , array second , ') and end name (' , array sixth
								, ') do not agree.' ] ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> moduleBody [
	^ (self definitions , self definitionBlock starA) ==> #second
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> moduleIdentifier [
	^ identifier
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> moduleKeyword [
	^ self reserved: 'module'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> moduledDocument [

	^ self module starA trim
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> mul: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-comments' }
ViennaVDMGrammar >> multiLineComment [

	^ ('/*' asPParser , ('*/' asPParser not , #any asPParser) starA
	   , '*/' asPParser) flatten
]

{ #category : 'parsers-statements' }
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

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> multipleBind [
	^ self multipleSetBind / self multipleSeqBind / self multipleTypeBind
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> multipleSeqBind [

	^ patternList , self inseq , expressionExceptEquality
	  ==> [ :triple |
		  {
			  triple first.
			  triple third } ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> multipleSetBind [

	^ patternList , self inset , expressionExceptEquality
	  ==> [ :triple |
		  {
			  triple first.
			  triple third } ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> multipleTypeBind [
	^ (patternList , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> munion [
	^ self reserved: 'munion'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> munion: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> name [
	^ ((self moduleIdentifier , (self operator: $`) , identifier trim)
		==> [ :pair | 
			{(pair first).
			(pair third)} ]) / ((identifier , '' asPParser trim) ==> #first)
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> nameList [
	^ (name separatedBy: comma) withoutSeparators
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> namedTrace [

	^ comment trim star
	  ,
	  (self initialLetter , (followingLetter / '/' asPParser) starA)
		  flatten , self colon , traceDefinitionList ==> [ :array |
	  {
		  array second.
		  array fourth } ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> nondeterministicStatement [
	^ (self doublebar , lparen , (statement separatedBy: comma) withoutSeparators , rparen) ==> #third
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> not: arg [
	^ arg
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> notEq [
	^ self operator: '<>'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> notEqual: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> notInSet: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> notOp [
	^ self reserved: 'not'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> of [
	^ self reserved: 'of'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> oldName [

	^ identifier , (self operator: '~') ==> [ :pair | pair first ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> operationBody [

	^ statement / self isNotYetSpecified
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> operationDefinition [
	^ self explicitOperationDefinition / self implicitOperationDefinition / self extendedExplicitOperationDefinition
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> operationDefinitions [

	^ self operations
	  , (self accessOperationDefinition separatedBy: semicolon)
			  withoutSeparators optional , semicolon optional
	  ==> [ :triple | triple second ifNil: [ Array new ] ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> operationExport [
	^ (nameList , (self operator: ':') , self operationType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> operationImport [
	^ name , (((self operator: ':') , self operationType) ==> #second) optional
		, ((self renamed , (self decl: name)) ==> #second) optional
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> operationType [
	| discretionaryType |
	discretionaryType := self discretionaryType.
	^ (discretionaryType , (self operator: '==>') , discretionaryType)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> operations [
	^ self reserved: 'operations'
]

{ #category : 'utilities' }
ViennaVDMGrammar >> operator: aStringOrCharacterOrParser [

	^ comment trim star , aStringOrCharacterOrParser asPParser trim
	  , comment trim star ==> #second
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> optionalPatternList [
	^ (pattern separatedBy: comma) withoutSeparators optional ==> [ :opt | opt ifNil: [ Array new ] ]
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> optionalType [
	^ (lbracket , type , rbracket) ==> #second
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> or: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> orOp [
	^ self reserved: 'or'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> others [
	^ self reserved: 'others'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> othersExpression [
	^ (self others , self arrow , expression) ==> #third
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> othersStatement [
	^ (self others , self arrow , statement) ==> #third
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> parameterTypes [
	^ (lparen , self patternTypePairList , rparen)
		==> [ :triple | triple second ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> parameters [
	^ (lparen , optionalPatternList , rparen) ==> #second
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> parametersList [
	^ self parameters plusA
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> partialFunctionType [
	^ (self discretionaryType1 , (self operator: '->') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> pattern [
	^ self setUnionPattern / self seqConcPattern / self mapMunionPattern / pattern1
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> pattern1 [

	^ self matchValue / self setEnumPattern / self seqEnumPattern
	  / self mapEnumerationPattern / self tuplePattern
	  / self recordPattern / self patternIdentifier
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> patternBind [
	^ bind / pattern
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> patternIdentifier [
	^ (self decl: identifier) trim / ((self operator: $-) ==> [ :op | nil ])
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> patternList [
	^ (pattern separatedBy: comma) withoutSeparators
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> patternTypePairList [
	^ (self patternList , colon , type separatedBy: comma)
		withoutSeparators optional
		==> [ :triples | 
			triples
				ifNil: [ #() ]
				ifNotNil: [ | array |
					array := Array new: triples size * 2.
					1 to: triples size do: [ :index | 
						array at: index * 2 - 1 put: (triples at: index) first.
						array at: index * 2 put: (triples at: index) third ].
					array ] ]
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> plus: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> plusOp [
	^ ($+ asPParser , $+ asPParser not) trim
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> plusPlusOp [
	^ self operator: '++'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> post [
	^ self reserved: 'post'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> power [
	^ self reserved: 'power'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> power: arg [
	^ arg
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> pre [
	^ self reserved: 'pre'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> prePostFunctionDefinition [

	^ expression
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> preconditionExpression [
	^ ((self reserved: 'pre_') , lparen , (expression separatedBy: comma) withoutSeparators , rparen) ==> #third
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> prefixes [
	^ #('mk_' 'is_' 'obj_' 'narrow_')
]

{ #category : 'printing' }
ViennaVDMGrammar >> printOn: aStream [
	aStream
		nextPutAll: 'a ';
		nextPutAll: self class name
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> private [
	^ self reserved: 'private'
]

{ #category : 'parsers-types' }
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

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> protected [
	^ self reserved: 'protected'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> psubset [
	^ self reserved: 'psubset'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> psubset: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> public [
	^ self reserved: 'public'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> quantifiedExpression [
	^ self forallExpression / self existsExpression / self exists1Expression
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> quoteType [
	^ self type: self quoteLiteral
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> rbrace [
	^ self operator: $}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> rbracket [
	^ self operator: $]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> rd [
	^ self reserved: 'rd'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> rdExpression [

	^ self sharp , self rd , lparen , nameList , rparen ==> #fourth
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> recordConstructor [

	^ 'mk_' asPParser , (self type: name) , lparen , expressionList
	  , rparen ==> [ :array |
	  {
		  array second.
		  array fourth } ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> recordModifier [
	^ ((self reserved: 'mu') , lparen , expression , comma , self mapletList , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> recordPattern [

	^ 'mk_' asPParser , (self type: name) , lparen ==> #second
	  ,
	  (patternList optional ==> [ :single | single ifNil: [ Array new ] ])
	  , rparen ==> [ :triple |
	  {
		  triple first.
		  triple second } ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> recordTypeDefinition [
	^ ((self decl: self typeIdentifier) trim , (self operator: '::') , fieldList , invariant optional)
		==> [ :quatro | 
			| ident flist inv |
			ident := quatro first.
			flist := quatro third.
			inv := quatro fourth.
			{ident.
			flist.
			inv} ]
]

{ #category : 'parsers-expressions' }
ViennaVDMGrammar >> relationExpression [
	^ (evaluatorExpression
		,
			(((self eqOp , evaluatorExpression)
				==> [ :pair | 
					{#equal:and:.
					pair second} ])
				/
					((self notEq , evaluatorExpression)
						==> [ :pair | 
							{#notEqual:and:.
							pair second} ])
				/
					((self lessOrEqual , evaluatorExpression)
						==> [ :pair | 
							{#lessEq:and:.
							pair second} ])
				/
					((self less , evaluatorExpression)
						==> [ :pair | 
							{#less:and:.
							pair second} ])
				/
					((self greaterOrEqual , evaluatorExpression)
						==> [ :pair | 
							{#greaterEq:and:.
							pair second} ])
				/
					((self greater , evaluatorExpression)
						==> [ :pair | 
							{#greater:and:.
							pair second} ])
				/
					((self subset , evaluatorExpression)
						==> [ :pair | 
							{#subset:and:.
							pair second} ])
				/
					((self psubset , evaluatorExpression)
						==> [ :pair | 
							{#psubset:and:.
							pair second} ])
				/
					((self inset ==> [ :op |  ] , evaluatorExpression)
						==> [ :pair | 
							{#inSet:and:.
							pair second} ])
				/
					(((self notOp , (self reserved: 'in') , (self reserved: 'set'))
						==> [ :op |  ] , evaluatorExpression)
						==> [ :pair | 
							{#notInSet:and:.
							pair second} ])) starA)
		==> [ :pair | 
			pair second
				inject: pair first
				into:
					[ :expr :selAndArg | self perform: selAndArg first with: expr with: selAndArg second ] ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> rem [
	^ self reserved: 'rem'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> rem: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> renamed [
	^ self reserved: 'renamed'
]

{ #category : 'utilities' }
ViennaVDMGrammar >> reserved: aStringOrParser [

	^ comment trim star
	  , (aStringOrParser asPParser , followingLetter not) trim
	  , comment trim star ==> [ :triple | triple second first ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> resultExpression [
	^ (self reserved: 'RESULT') ==> [ :t |  ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> return [
	^ self reserved: 'return'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> returnStatement [
	^ (self return , expression optional) ==> #second
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> reverse [
	^ self reserved: 'reverse'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> reverse: arg [
	^ arg
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> rng [
	^ self reserved: 'rng'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> rng: arg [
	^ arg
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> rparen [
	^ self operator: $)
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> semicolon [
	^ self operator: $;
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> seq1Type [
	^ ((self reserved: 'seq1') , (self reserved: 'of') , type3) ==> #third
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> seqBind [

	^ pattern , self inseq , expressionExceptEquality ==> [ :triple |
	  {
		  triple first.
		  triple third } ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> seqConcPattern [
	^ (pattern1 , (self operator: '^')
		, (pattern1 separatedBy: (self operator: '^')) withoutSeparators)
		==> [ :triple | triple third copyWithFirst: triple first ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> seqEnumPattern [
	^ (lbracket , optionalPatternList , rbracket) ==> #second
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> seqType [
	^ ((self reserved: 'seq') , (self reserved: 'of') , type3) ==> #third
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> sequenceComprehension [
	^ (lbracket , expression , bar , self setSeqBind , ((amp , expression) ==> #second) optional , rbracket)
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> sequenceEnumeration [
	^ (lbracket , expressionList , rbracket) ==> #second
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> sequenceForLoop [
	^ (self for , patternBind , self in , expression , self do , statement)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth)} ]
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> set1Type [
	^ ((self reserved: 'set1') , (self reserved: 'of') , type3) ==> #third
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> setBind [

	^ pattern , self inset , expressionExceptEquality ==> [ :triple |
	  {
		  triple first.
		  triple third } ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> setComprehension [
	^ (lbrace , expression , bar , bindList , ((amp , expression) ==> #second) optional , rbrace)
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> setEnumPattern [
	^ (lbrace , optionalPatternList , rbrace) ==> #second
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> setEnumeration [
	^ (lbrace , expressionList , rbrace) ==> #second
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> setForLoop [
	^ (self for , self all , pattern , self inset , expression , self do , statement)
		==> [ :array | 
			{(array third).
			(array fifth).
			(array seventh)} ]
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> setRangeExpression [
	^ (lbrace , expression , comma , (self operator: '...') , comma , expression , rbrace)
		==> [ :array | 
			{(array second).
			(array sixth)} ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> setSeqBind [
	^ setBind / seqBind
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> setType [
	^ ((self reserved: 'set') , (self reserved: 'of') , type3) ==> #third
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> setUnionPattern [
	^ (pattern1 , (self reserved: 'union') , pattern1)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> sharp [

	^ comment trim star , '#' asPParser ==> #second
]

{ #category : 'parsers-comments' }
ViennaVDMGrammar >> singleLineAnnotation [

	^ '--@' asPParser
	  , (Character cr asPParser not , #any asPParser) starA flatten
	  ==> #second
]

{ #category : 'parsers-comments' }
ViennaVDMGrammar >> singleLineComment [

	^ ('--' asPParser
	   , (Character cr asPParser not , #any asPParser) starA) flatten
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> skip [
	^ self reserved: 'skip'
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> slash [
	^ self operator: $/
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> specificationStatement [
	^ (lbracket , self implicitOperationBody , rbracket) ==> #second
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> starOp [
	^ self operator: $*
]

{ #category : 'parsing' }
ViennaVDMGrammar >> start [
	^ default
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> state [
	^ self reserved: 'state'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> stateDefinition [
	^ (self state , (self decl: self typeIdentifier) trim , self of , self stateFieldList , invariant optional
		, self initialisation optional , self endKeyword , semicolon optional)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array fifth).
			(array sixth)} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> stateDesignator [
	^ ((self decl: name)
		, (self fieldReferenceArg / self mapOrSequenceReferenceArg) starA)
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

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> stateField [

	^ (self decl: identifier) trim , colon , (self type: type) trim
	  ==> [ :triple |
		  {
			  triple first.
			  triple third } ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> stateFieldList [
	^ self stateField starA
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> statement [
	^ self letStatement / self letBeStatement / self defStatement / self identityStatement / self blockStatement
		/ self generalAssignStatement / self callStatement / self ifStatement / self casesStatement / self sequenceForLoop
		/ self setForLoop / self indexForLoop / self whileLoop / self nondeterministicStatement / self returnStatement / self alwaysStatement / self exitStatement / self errorStatement / self trapStatement / self tixeStatement
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> struct [
	^ self reserved: 'struct'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> subsequence: sequence from: start to: end [
	^ {sequence.
	start.
	end}
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> subset [
	^ self reserved: 'subset'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> subset: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-literals' }
ViennaVDMGrammar >> symbolicLiteral [
	^ self basicSymbolicLiteral 
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> then [
	^ self reserved: 'then'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> tixe [
	^ self reserved: 'tixe'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> tixeStatement [
	^ (self tixe , self traps , self in , statement)
		==> [ :quatro | 
			{quatro second.
			quatro fourth} ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> tl [
	^ self reserved: 'tl'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> tl: arg [
	^ arg
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> to [
	^ self reserved: 'to'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> tokenConstructor [
	^ ((self reserved: 'mk_token' asPParser) , lparen , expression , rparen) ==> #third
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> topLevelDefinition [

	^ self accessTypeDefinition / self accessValueDefinition
	  / self accessFunctionDefinition / self stateDefinition
	  / self accessOperationDefinition
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> topLevelDefinitionList [

	^ (self topLevelDefinition separatedBy: semicolon) withoutSeparators
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> totalFunctionType [
	^ (self discretionaryType1 , (self operator: '+>') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceApplyExpression [

	^ self callStatement
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceBindingDefinition [

	^ self traceLetDefBinding / self traceLetBestBinding
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceBracketedExpression [

	^ lparen , traceDefinitionList , rparen ==> #second
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceConcurrentExpression [

	^ (self operator: '||') , lparen , traceDefinition , comma
	  , (traceDefinition separatedBy: comma) withoutSeparators , rparen
	  ==> [ :array | { array third } , array fourth ]
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceCoreDefinition [

	^ self traceApplyExpression / self traceConcurrentExpression
	  / self traceBracketedExpression
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceDefinition [

	^ self traceBindingDefinition / self traceRepeatDefinition
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceDefinitionList [

	^ (self traceDefinitionTerm separatedBy: self semicolon)
		  withoutSeparators
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceDefinitionTerm [

	^ (traceDefinition separatedBy: self bar) withoutSeparators
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceLetBestBinding [

	^ self let , self multipleBind
	  , (self best , self expression ==> #second) optional , self in
	  , traceDefinition ==> [ :array |
	  {
		  array second.
		  array third.
		  array fifth } ]
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceLetDefBinding [

	^ self let , self localDefinitionList , self in , traceDefinition
	  ==> [ :array |
		  {
			  array second.
			  array fourth } ]
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceRepeatDefinition [

	^ self traceCoreDefinition , self traceRepeatPattern optional
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceRepeatOptionalPattern [

	^ self operator: '?'
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceRepeatPattern [

	^ self traceRepeatStarPattern / self traceRepeatPlusPattern
	  / self traceRepeatOptionalPattern / self traceRepeatRangePattern
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceRepeatPlusPattern [

	^ self operator: '+'
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceRepeatRangePattern [

	^ self lbrace , self digits , (self comma , self digits) optional
	  , self rbrace
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> traceRepeatStarPattern [

	^ self operator: '*'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> traces [

	^ self reserved: 'traces'
]

{ #category : 'parsers-traces' }
ViennaVDMGrammar >> tracesDefinitions [

	^ self traces
	  , (self namedTrace separatedBy: self semicolon) withoutSeparators
	  , self semicolon trimBlanks star ==> #second
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> trap [
	^ self reserved: 'trap'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> trapStatement [
	^ (self trap , patternBind , self with , statement , self in , statement)
		==> [ :array | 
			{array second.
			array fourth.
			array sixth} ]
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> traps [

	^ lbrace
	  , (patternBind , self mapletArrow , statement ==> [ :triple |
		   {
			   triple first.
			   triple third } ] separatedBy: comma) withoutSeparators , rbrace
	  ==> [ :triple |
		  | array |
		  array := Array new: triple second size * 2.
		  triple second keysAndValuesDo: [ :index :pair |
			  array at: index * 2 - 1 put: pair first.
			  array at: index * 2 put: pair second ].
		  array ]
]

{ #category : 'parsers-expressions-basics' }
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

{ #category : 'parsers-patterns' }
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

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> tupleSelect: tuple with: index [
	^ {tuple.
	index}
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> type [
	^ self partialFunctionType / self totalFunctionType / type1
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> type1 [
	^ self unionType / type2
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> type2 [
	^ self productType / type3
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> type3 [
	^ self mapType / self inmapType / self setType / self set1Type / self seqType / self seq1Type / self basicType / self quoteType / self compositeType / self optionalType / self typeName
		/ self typeVariable / ((lparen , type , rparen) ==> #second)
]

{ #category : 'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> type: aParser [
	^ aParser
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> typeBind [
	^ (pattern , colon , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-patterns' }
ViennaVDMGrammar >> typeBindList [
	^ (typeBind separatedBy: comma) withoutSeparators
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> typeDefinition [
	^ self typeSynonym / self recordTypeDefinition
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> typeDefinitions [

	^ self types
	  ,
		  (self accessTypeDefinition separatedBy: semicolon)
			  withoutSeparators optional , semicolon optional
	  ==> [ :triple | triple second ifNil: [ Array new ] ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> typeExport [

	^ self struct optional , (self type: name)
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> typeIdentifier [

	^ self type: identifier
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> typeImport [

	^ self typeDefinition
	  ,
	  (self renamed , (self type: (self decl: name)) ==> #second)
		  optional / (self typeName
	   ,
	   (self renamed , (self type: (self decl: name)) ==> #second)
		   optional)
]

{ #category : 'parsers-expressions-type discriminations' }
ViennaVDMGrammar >> typeJudgement [
	^ ('is_' asPParser , lparen , expression , comma , type , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> typeName [
	^ ((self moduleIdentifier , (self operator: $`) , self typeIdentifier trim)
		==> [ :pair | 
			{(pair first).
			(pair third)} ]) / self typeIdentifier trim
]

{ #category : 'utilities' }
ViennaVDMGrammar >> typeOrRecordTypeDefinition [

	^ self operationType / self recordTypeDefinition / self type
	  / self unitType
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> typeSynonym [
	^ ((self decl: self typeIdentifier) trim , eq , type , invariant optional)
		==> [ :quatro | 
			{(quatro first).
			(quatro third).
			(quatro fourth)} ]
]

{ #category : 'parsers-types' }
ViennaVDMGrammar >> typeVariable [
	^ self typeVariableIdentifier
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> typeVariableIdentifier [
	^ ((self operator: $@) , self typeIdentifier) trim
		==> [ :pair | 
			String
				new: pair second size + 1
				streamContents: [ :stream | 
					stream
						nextPut: pair first;
						nextPutAll: pair second ] ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> typeVariableList [
	^ (lbracket , ((self decl: self typeVariableIdentifier) separatedBy: comma) withoutSeparators , rbracket) optional
		==> [ :tripleOrNil | tripleOrNil ifNil: [ #() ] ifNotNil: [ tripleOrNil second ] ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> types [
	^ self reserved: 'types'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> unaryMinus: arg [
	^ arg
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> unaryPlus: arg [
	^ arg
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> undefinedExpression [
	^ (self reserved: 'undefined') ==> [ :t | nil ]
]

{ #category : 'parsers-symbols' }
ViennaVDMGrammar >> union [
	^ self reserved: 'union'
]

{ #category : 'parsers-expressions-operators' }
ViennaVDMGrammar >> union: arg1 and: arg2 [
	^ {arg1.
	arg2}
]

{ #category : 'parsers-types' }
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

{ #category : 'parsers-types' }
ViennaVDMGrammar >> unitType [

	^ self type:
		  (self operator: $() , (self operator: $)) ==> [ :pair | nil ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> valueDefinition [
	^ (pattern , (colon , type) optional , eq , expression)
		==> [ :quatro | 
			{(quatro first).
			(quatro second ifNotNil: [ :second | second second ]).
			(quatro fourth)} ]
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> valueDefinitions [

	^ self values
	  ,
		  (self accessValueDefinition separatedBy: semicolon)
			  withoutSeparators optional , semicolon optional
	  ==> [ :triple | triple second ifNil: [ Array new ] ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> valueExport [
	^ (nameList , (self operator: ':') , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : 'parsers-interfaces' }
ViennaVDMGrammar >> valueImport [
	^ name , (((self operator: ':') , type) ==> #second) optional , ((self renamed , (self decl: name)) ==> #second) optional
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> values [
	^ self reserved: 'values'
]

{ #category : 'parsers-definitions' }
ViennaVDMGrammar >> varInformation [
	^ self mode , nameList , ((colon , type) ==> #second) optional
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> while [
	^ self reserved: 'while'
]

{ #category : 'parsers-statements' }
ViennaVDMGrammar >> whileLoop [
	^ (self while , expression , self do , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> with [
	^ self reserved: 'with'
]

{ #category : 'parsers-keywords' }
ViennaVDMGrammar >> wr [
	^ self reserved: 'wr'
]

{ #category : 'parsers-expressions-basics' }
ViennaVDMGrammar >> wrExpression [

	^ self sharp , self wr , lparen , nameList , rparen ==> #fourth
]
