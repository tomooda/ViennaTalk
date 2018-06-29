Class {
	#name : #ViennaVDMFormatter,
	#superclass : #Object,
	#instVars : [
		'maxSizePerLine',
		'indent'
	],
	#classVars : [
		'OperatorGrouping',
		'OperatorPrecedence'
	],
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'class initialization' }
ViennaVDMFormatter class >> initialize [
	super initialize.
	self initializeOperatorPrecedence.
	self initializeOperatorGrouping
]

{ #category : #'class initialization' }
ViennaVDMFormatter class >> initializeOperatorGrouping [
	OperatorGrouping := Dictionary new
		at: 'Iterate' put: #right;
		at: 'Composition' put: #right;
		at: 'Subsequence' put: #left;
		at: 'Apply' put: #left;
		at: 'FunctionTypeInstantiation' put: #left;
		at: 'FieldSelect' put: #left;
		at: 'MapRangeRestrictedBy' put: #left;
		at: 'MapRangeRestrictedTo' put: #left;
		at: 'MapDomainRestrictedBy' put: #right;
		at: 'MapDomainRestrictedTo' put: #right;
		at: 'ArithmeticDivide' put: #left;
		at: 'ArithmeticRem' put: #left;
		at: 'ArithmeticMod' put: #left;
		at: 'ArithmeticIntegerDivision' put: #left;
		at: 'ArithmeticMinus' put: #left;
		at: 'SetDifference' put: #left;
		at: 'MapMerge' put: #left;
		at: 'MapOrSequenceModify' put: #left;
		at: 'SequenceConcatenate' put: #left;
		at: 'Imply' put: #right;
		at: 'PartialFunctionType' put: #right;
		at: 'TotalFunctionType' put: #right;
		yourself
]

{ #category : #'class initialization' }
ViennaVDMFormatter class >> initializeOperatorPrecedence [
	OperatorPrecedence := Dictionary new
		at: 'Iterate' put: 52;
		at: 'Composition' put: 51;
		at: 'Subsequence' put: 40;
		at: 'Apply' put: 40;
		at: 'FunctionTypeInstantiation' put: 40;
		at: 'FieldSelect' put: 40;
		at: 'UnaryPlus' put: 36;
		at: 'UnaryMinus' put: 36;
		at: 'ArithmeticAbs' put: 36;
		at: 'Floor' put: 36;
		at: 'SetCardinality' put: 36;
		at: 'FinitePowerSet' put: 36;
		at: 'DistributedSetIntersection' put: 36;
		at: 'DistributedSetUnion' put: 36;
		at: 'MapDomain' put: 36;
		at: 'MapRange' put: 36;
		at: 'DistributedMapMerge' put: 36;
		at: 'SequenceLength' put: 36;
		at: 'SequenceElements' put: 36;
		at: 'SequenceHead' put: 36;
		at: 'SequenceTail' put: 36;
		at: 'DistributedSequenceConcatenation' put: 36;
		at: 'SequenceIndices' put: 36;
		at: 'MapRangeRestrictedBy' put: 35;
		at: 'MapRangeRestrictedTo' put: 35;
		at: 'MapDomainRestrictedBy' put: 34;
		at: 'MapDomainRestrictedTo' put: 34;
		at: 'MapInverse' put: 33;
		at: 'ArithmeticMultiplication' put: 32;
		at: 'ArithmeticDivide' put: 32;
		at: 'ArithmeticRem' put: 32;
		at: 'ArithmeticMod' put: 32;
		at: 'ArithmeticIntegerDivision' put: 32;
		at: 'SetIntersection' put: 32;
		at: 'ArithmeticPlus' put: 31;
		at: 'ArithmeticMinus' put: 31;
		at: 'SetUnion' put: 31;
		at: 'SetDifference' put: 31;
		at: 'MapMerge' put: 31;
		at: 'MapOrSequenceModify' put: 31;
		at: 'SequenceConcatenate' put: 31;
		at: 'IotaExpression' put: 30;
		at: 'LessThanOrEqual' put: 21;
		at: 'LessThan' put: 21;
		at: 'GreaterThanOrEqual' put: 21;
		at: 'GreaterThan' put: 21;
		at: 'Equal' put: 21;
		at: 'NotEqual' put: 21;
		at: 'Subset' put: 21;
		at: 'ProperSubset' put: 21;
		at: 'InSet' put: 21;
		at: 'NotInSet' put: 21;
		at: 'ForallExpression' put: 10;
		at: 'ExistsExpression' put: 10;
		at: 'Exists1Expression' put: 10;
		at: 'Not' put: 15;
		at: 'And' put: 14;
		at: 'Or' put: 13;
		at: 'Imply' put: 12;
		at: 'LogicalEquivalence' put: 11;
		at: 'LetExpression' put: 10;
		at: 'LetBeExpression' put: 10;
		at: 'DefExpression' put: 10;
		at: 'ForallExpression' put: 10;
		at: 'ExistsExpression' put: 10;
		at: 'Exists1Expression' put: 10;
		at: 'IfExpression' put: 10;
		at: 'IotaExpression' put: 10;
		at: 'SetType' put: 5;
		at: 'SeqType' put: 5;
		at: 'Seq1Type' put: 5;
		at: 'MapType' put: 4;
		at: 'InmapType' put: 4;
		at: 'ProductType' put: 3;
		at: 'UnionType' put: 2;
		at: 'PartialFunctionType' put: 1;
		at: 'TotalFunctionType' put: 1;
		yourself
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> access: aViennaNode [
	^ ' ' join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> accessFunctionDefinition: aViennaNode [
	^ ' ' join: ((self formatAll: aViennaNode) reject: #isEmpty)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> accessOperationDefinition: aViennaNode [
	^ ' ' join: ((self formatAll: aViennaNode) reject: #isEmpty)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> accessTypeDefinition: aViennaNode [
	^ ' ' join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> accessValueDefinition: aViennaNode [
	^ ' ' join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> actExpression: aViennaNode [
	^ '#act(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> activeExpression: aViennaNode [
	^ '#active(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> and: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'and' arg: (self format: aViennaNode second)
]

{ #category : #private }
ViennaVDMFormatter >> anyNeedsIndent: anArrayOfString [
	^ (anArrayOfString contains: [ :string | string includes: Character cr ])
		or: [ (anArrayOfString collect: #size) sum > self maxSizePerLine ]
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> apply: aViennaNode [
	| expression args |
	expression := self format: aViennaNode first.
	args := self format: aViennaNode second.
	^ expression , '('
		,
			((self needsIndent: expression , args)
				ifTrue: [ String cr , indent , (self indentString: args) ]
				ifFalse: [ args ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticAbs: aViennaNode [
	^ 'abs ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticDivide: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '/' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticIntegerDivision: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'div' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticMinus: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '-' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticMod: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'mod' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticMultiplication: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '*' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticPlus: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '+' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticRem: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'rem' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> assignStatement: aViennaNode [
	^ self print: (self format: aViennaNode first) withChildren: {(':= ' , (self format: aViennaNode second))}
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> assignmentDefinition: aViennaNode [
	^ aViennaNode first , ':' , (self format: aViennaNode second)
		, (aViennaNode third ifNotNil: [ ' := ' , (self format: aViennaNode third) ] ifNil: [ '' ])
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> basicType: aViennaNode [
	^ aViennaNode first
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> bindList: aViennaNode [
	| binds |
	binds := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: binds)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: binds
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> blockStatement: aViennaNode [
	^ '(' , (';' , String cr join: (self formatAll: aViennaNode)) , ')'
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> callStatement: aViennaNode [
	| args |
	args := self format: aViennaNode second.
	^ (self format: aViennaNode first) , '('
		,
			((self needsIndent: args)
				ifTrue: [ self newlineIndentString: args ]
				ifFalse: [ args ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> casesExpression: aViennaNode [
	^ 'cases ' , (self format: aViennaNode first) , ':' , (self newlineIndentString: (self format: aViennaNode second))
		, (aViennaNode third ifNotNil: [ ',' , (self newlineIndentString: (self format: aViennaNode third)) ] ifNil: [ '' ])
		, String cr , 'end'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> casesExpressionAlternative: aViennaNode [
	| patternList expression |
	patternList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ patternList , ' ->'
		,
			((self needsIndent: patternList , expression)
				ifTrue: [ self newlineIndentString: expression ]
				ifFalse: [ String space , expression ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> casesExpressionAlternatives: aViennaNode [
	^ ',' , String cr join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> casesStatement: aViennaNode [
	^ 'cases ' , (self format: aViennaNode first) , ':' , (self newlineIndentString: (self format: aViennaNode second))
		, (aViennaNode third ifNotNil: [ ',' , (self newlineIndentString: (self format: aViennaNode third)) ] ifNil: [ '' ])
		, String cr , 'end'
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> casesStatementAlternative: aViennaNode [
	| patternList expression |
	patternList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ patternList , ' ->'
		,
			((self needsIndent: patternList , expression)
				ifTrue: [ self newlineIndentString: expression ]
				ifFalse: [ String space , expression ])
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> casesStatementAlternatives: aViennaNode [
	^ ',' , String cr join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> compositeType: aViennaNode [
	| constructor fields |
	constructor := self format: aViennaNode first.
	fields := self format: aViennaNode second.
	^ 'compose ' , constructor , ' of'
		,
			((self needsIndent: constructor , fields)
				ifTrue: [ (self newlineIndentString: fields) , String cr ]
				ifFalse: [ String space , fields , String space ]) , 'end'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> composition: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'comp' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> dclStatement: aViennaNode [
	| assigns |
	assigns := self formatAll: aViennaNode.
	^ 'dcl'
		,
			((self anyNeedsIndent: assigns)
				ifTrue: [ 
					String cr , indent
						, (self indentAllStrings: assigns withSeparator: ',') ]
				ifFalse: [ String space , (', ' join: assigns) ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> defExpression: aViennaNode [
	| defs expression |
	defs := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'def ' , String cr , indent , (self indentString: defs) , String cr , 'in' , String cr , indent , expression
]

{ #category : #defaults }
ViennaVDMFormatter >> defaultIndent [
	^ '    '
]

{ #category : #defaults }
ViennaVDMFormatter >> defaultMaxSizePerLine [
	^ 30
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> definitionBlock: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> distributedMapMerge: aViennaNode [
	^ 'merge ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> distributedSequenceConcatenation: aViennaNode [
	^ 'conc' arg: (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> distributedSetIntersection: aViennaNode [
	^ self print: 'dinter ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> distributedSetUnion: aViennaNode [
	^ 'dunion ' , (self format: aViennaNode first)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> document: aViennaNode [
	^ String cr join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> elseifExpression: aViennaNode [
	^ 'elseif ' , (self format: aViennaNode first) , ' then ' , (self indentString: (self format: aViennaNode second))
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> elseifStatement: aViennaNode [
	^ 'elseif ' , (self format: aViennaNode first) , ' then ' , (self indentString: (self format: aViennaNode second))
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> equal: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '=' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> equalDefinition: aViennaNode [
	| patternBind expression |
	patternBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ patternBind
		,
			((self needsIndent: patternBind , expression)
				ifTrue: [ String cr , indent ]
				ifFalse: [ String space ]) , '= ' , expression
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> equalDefinitionList: aViennaNode [
	| defs |
	defs := self formatAll: aViennaNode.
	^ ';' , String cr join: defs
]

{ #category : #private }
ViennaVDMFormatter >> escapeString: aString [
	^ aString
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> exists1Expression: aViennaNode [
	| bind expression |
	bind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'exists1 ' , bind , ' &'
		,
			((self needsIndent: bind , expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> existsExpression: aViennaNode [
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	(self needsIndent: bindList)
		ifTrue: [ 
			^ 'exists' , String cr , indent , (self indentString: bindList) , String cr , '&' , String cr , indent
				, (self indentString: expression) ].
	(self needsIndent: bindList , expression)
		ifTrue: [ ^ 'exists ' , bindList , ' &' , String cr , indent , (self indentString: expression) ].
	^ 'exists ' , bindList , ' & ' , expression
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> explicitFunctionDefinition: aViennaNode [
	| identifier1 typeVariableList functionType identifier2 parametersList expression pre post measure |
	identifier1 := self format: aViennaNode first.
	typeVariableList := self format: aViennaNode second.
	functionType := self format: aViennaNode third.
	identifier2 := self format: aViennaNode fourth.
	parametersList := self format: aViennaNode fifth.
	expression := self format: aViennaNode sixth.
	pre := aViennaNode seventh ifNotNil: [ self format: aViennaNode seventh ] ifNil: [ '' ].
	post := aViennaNode eighth ifNotNil: [ self format: aViennaNode eighth ] ifNil: [ '' ].
	measure := aViennaNode ninth ifNotNil: [ self format: aViennaNode ninth ] ifNil: [ '' ].
	^ identifier1 , typeVariableList , ' : ' , functionType , String cr , identifier2 , parametersList , ' =='
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , (pre ifNotEmpty: [ String cr , 'pre ' , pre ])
		, (post ifNotEmpty: [ String cr , 'post ' , post ]) , (measure ifNotEmpty: [ String cr , 'measure ' , measure ])
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> explicitOperationDefinition: aViennaNode [
	| identifier1 operationType identifier2 parameters expression pre post  |
	identifier1 := self format: aViennaNode first.
	operationType := self format: aViennaNode second.
	identifier2 := self format: aViennaNode third.
	parameters := self format: aViennaNode fourth.
	expression := self format: aViennaNode fifth.
	pre := aViennaNode sixth ifNotNil: [ self format: aViennaNode sixth ] ifNil: [ '' ].
	post := aViennaNode seventh ifNotNil: [ self format: aViennaNode seventh ] ifNil: [ '' ].
	^ identifier1 , ' : ' , operationType , String cr , identifier2 , parameters , ' =='
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , (pre ifNotEmpty: [ String cr , 'pre ' , pre ])
		, (post ifNotEmpty: [ String cr , 'post ' , post ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> expressionList: aViennaNode [
	| expressions |
	expressions := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: expressions)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: expressions
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> field: aViennaNode [
	| name equalityAbstraction type |
	name := aViennaNode first.
	equalityAbstraction := aViennaNode second.
	type := self format: aViennaNode third.
	^ (name
		ifNil: [ '' ]
		ifNotNil: [ 
			name
				,
					(equalityAbstraction
						ifTrue: [ ' :- ' ]
						ifFalse: [ ' : ' ]) ]) , type
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> fieldList: aViennaNode [
	| fields |
	fields := self formatAll: aViennaNode.
	^ ((self anyNeedsIndent: fields)
		ifTrue: [ String cr ]
		ifFalse: [ String space ]) join: fields
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> fieldPattern: aViennaNode [
	| identifier pattern |
	identifier := self format: aViennaNode first.
	pattern := self format: aViennaNode second.
	^ identifier , ' |-> ' , pattern
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> fieldPatternList: aViennaNode [
	| fieldPatterns |
	fieldPatterns := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: fieldPatterns)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: fieldPatterns
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> fieldReference: aViennaNode [
	| stateDesignator field |
	stateDesignator := self format: aViennaNode first.
	field := self format: aViennaNode second.
	^ stateDesignator , '.' , field
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> fieldSelect: aViennaNode [
	| record field |
	record := self format: aViennaNode first.
	field := self format: aViennaNode second.
	^ record , '.' , field
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> finExpression: aViennaNode [
	^ '#fin(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> finitePowerSet: aViennaNode [
	^ 'power ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> floor: aViennaNode [
	^ 'floor ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> forallExpression: aViennaNode [
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	(self needsIndent: bindList)
		ifTrue: [ 
			^ 'forall' , String cr , indent , (self indentString: bindList) , String cr , '&' , String cr , indent
				, (self indentString: expression) ].
	(self needsIndent: bindList , expression)
		ifTrue: [ ^ 'forall ' , bindList , ' &' , String cr , indent , (self indentString: expression) ].
	^ 'forall ' , bindList , ' & ' , expression
]

{ #category : #formatting }
ViennaVDMFormatter >> format: aViennaNode [
	| string |
	aViennaNode isString
		ifTrue: [ ^ aViennaNode ].
	string := self perform: (aViennaNode label uncapitalized , ':') asSymbol with: aViennaNode.
	self needsParen
		ifTrue: [ string := '(' , (self indentString: string) , ')' ].
	^ string
]

{ #category : #formatting }
ViennaVDMFormatter >> formatAll: aViennaNodeOrArray [
	| array |
	array := Array new: aViennaNodeOrArray size.
	1 to: array size do: [ :i | array at: i put: (self format: (aViennaNodeOrArray at: i)) ].
	^ array
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> functionDefinition: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> functionDefinitions: aViennaNode [
	^ 'functions' , String cr , indent
		, (self indentAllStrings: (self formatAll: aViennaNode) withTerminator: ';' , String cr)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> functionTypeArgs: aViennaNode [
	^ '[' , (', ' join: (self formatAll: aViennaNode)) , ']'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> functionTypeInstantiation: aViennaNode [
	| function typeArgs |
	function := self format: aViennaNode first.
	typeArgs := self format: aViennaNode second.
	^ function , typeArgs
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> greaterThan: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '>' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> greaterThanOrEqual: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '>=' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> identityStatement: aViennaNode [
	^ 'skip'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> ifExpression: aViennaNode [
	| cond expr default |
	cond := self format: aViennaNode first first first.
	expr := self format: aViennaNode first first second.
	default := self format: aViennaNode second.
	(aViennaNode first size = 1 and: [ (self needsIndent: cond , expr , default) not ])
		ifTrue: [ ^ 'if ' , cond , ' then ' , expr , ' else ' , default ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: 'if'.
			(self needsIndent: cond)
				ifTrue: [ 
					stream
						nextPut: Character cr;
						nextPutAll: indent , (self indentString: cond) ]
				ifFalse: [ 
					stream
						nextPut: Character space;
						nextPutAll: cond ].
			stream
				nextPutAll: ' then';
				nextPut: Character cr;
				nextPutAll: indent;
				nextPutAll: (self indentString: expr).
			2 to: aViennaNode first size do: [ :index | 
				cond := self format: (aViennaNode first at: index) first.
				expr := self format: (aViennaNode first at: index) second.
				stream
					nextPut: Character cr;
					nextPutAll: 'elseif'.
				(self needsIndent: cond)
					ifTrue: [ 
						stream
							nextPut: Character cr;
							nextPutAll: indent , (self indentString: cond) ]
					ifFalse: [ 
						stream
							nextPut: Character space;
							nextPutAll: cond ].
				stream
					nextPutAll: ' then';
					nextPut: Character cr;
					nextPutAll: indent;
					nextPutAll: (self indentString: expr) ].
			stream
				nextPut: Character cr;
				nextPutAll: 'else';
				nextPut: Character cr;
				nextPutAll: indent , (self indentString: default) ]
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> ifStatement: aViennaNode [
	| cond expr default |
	cond := self format: aViennaNode first first first.
	expr := self format: aViennaNode first first second.
	default := aViennaNode second ifNil: [ '' ] ifNotNil: [ self format: aViennaNode second ].
	(aViennaNode first size = 1 and: [ (self needsIndent: cond , expr , default) not ])
		ifTrue: [ ^ 'if ' , cond , ' then ' , expr , (default ifNotEmpty: [ ' else ' , default ]) ].
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: 'if'.
			(self needsIndent: cond)
				ifTrue: [ 
					stream
						nextPut: Character cr;
						nextPutAll: indent , (self indentString: cond) ]
				ifFalse: [ 
					stream
						nextPut: Character space;
						nextPutAll: cond ].
			stream
				nextPutAll: ' then';
				nextPut: Character cr;
				nextPutAll: indent;
				nextPutAll: (self indentString: expr).
			2 to: aViennaNode first size do: [ :index | 
				cond := self format: (aViennaNode first at: index) first.
				expr := self format: (aViennaNode first at: index) second.
				stream
					nextPut: Character cr;
					nextPutAll: 'elseif'.
				(self needsIndent: cond)
					ifTrue: [ 
						stream
							nextPut: Character cr;
							nextPutAll: indent , (self indentString: cond) ]
					ifFalse: [ 
						stream
							nextPut: Character space;
							nextPutAll: cond ].
				stream
					nextPutAll: ' then';
					nextPut: Character cr;
					nextPutAll: indent;
					nextPutAll: (self indentString: expr) ].
			default
				ifNotEmpty: [ 
					stream
						nextPut: Character cr;
						nextPutAll: 'else';
						nextPut: Character cr;
						nextPutAll: indent , (self indentString: default) ] ]
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> imply: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '=>' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> inSet: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'in set' arg: (self format: aViennaNode second)
]

{ #category : #accessing }
ViennaVDMFormatter >> indent [
	^ indent
]

{ #category : #accessing }
ViennaVDMFormatter >> indent: aString [
	indent := aString
]

{ #category : #private }
ViennaVDMFormatter >> indentAllStrings: anArrayOfString [
	^ String cr , indent join: (anArrayOfString collect: [ :string | self indentString: string ])
]

{ #category : #private }
ViennaVDMFormatter >> indentAllStrings: anArrayOfString withSeparator: separator [
	^ separator , String cr , indent join: (anArrayOfString collect: [ :string | self indentString: string ])
]

{ #category : #private }
ViennaVDMFormatter >> indentAllStrings: anArrayOfString withTerminator: terminator [
	^ (self indentAllStrings: anArrayOfString withSeparator: terminator) , terminator
]

{ #category : #private }
ViennaVDMFormatter >> indentString: aString [
	^ String cr , indent join: aString lines
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> indexForLoop: aViennaNode [
	| identifier start end step statement |
	identifier := self format: aViennaNode first.
	start := self format: aViennaNode second.
	end := self format: aViennaNode third.
	step := aViennaNode fourth ifNotNil: [ self format: aViennaNode fourth ] ifNil: [ '' ].
	statement := self format: aViennaNode fifth.
	(self needsIndent: identifier , start , end , step , statement)
		ifFalse: [ ^ 'for ' , identifier , ' = ' , start , ' to ' , end , (step ifNotEmpty: [ ' by ' , step ]) , ' do ' , statement ].
	(self needsIndent: identifier , start , end , step)
		ifFalse: [ 
			^ 'for ' , identifier , ' = ' , start , ' to ' , end , (step ifNotEmpty: [ ' by ' , step ]) , String cr , ' do '
				, (self indentString: statement) ].
	^ 'for ' , identifier , ' = ' , (self indentString: start) , String cr , 'to ' , (self indentString: end)
		, (step ifNotEmpty: [ String cr , 'by ' , (self indent: step) ]) , String cr , 'do ' , (self indentString: statement)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> initialisation: aViennaNode [
	^ 'init ' , (self format: aViennaNode first)
]

{ #category : #'initialize-release' }
ViennaVDMFormatter >> initialize [
	super initialize.
	maxSizePerLine := self defaultMaxSizePerLine.
	indent := self defaultIndent
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> inmapType: aViennaNode [
	^ 'inmap ' , (self format: aViennaNode first) , ' to ' , (self format: aViennaNode second)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> invariant: aViennaNode [
	^ 'inv ' , (self format: aViennaNode first)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> invariantInitialFunction: aViennaNode [
	| pattern expression |
	pattern := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ (self needsIndent: pattern , expression)
		ifTrue: [ pattern , ' ==' , String cr , indent , (self indentString: expression) ]
		ifFalse: [ pattern , ' == ' , expression ]
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> iotaExpression: aViennaNode [
	| bind expression |
	bind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'iota ' , bind , ' &'
		,
			((self needsIndent: bind , expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> isBasicExpression: aViennaNode [
	| name expression |
	name := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'is_' , name , '('
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ expression ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> isNameExpression: aViennaNode [
	| name expression |
	name := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'is_' , name , '('
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ expression ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> isNotYetSpecified: aViennaNode [
	^ 'is not yet specified'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> isSubclassResponsibility: aViennaNode [
	^ 'is subclass responsibility'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> isofbaseclassExpression: aViennaNode [
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'isofbaseclass(' , cls , ','
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> isofclassExpression: aViennaNode [
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'isofclass(' , cls , ','
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> iterate: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '**' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> lambdaExpression: aViennaNode [
	| typeBind expression |
	typeBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'lambda ' , typeBind , ' &'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indent: expression) ]
				ifFalse: [ String space , expression ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> lessThan: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '<' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> lessThanOrEqual: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '<=' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> letBeExpression: aViennaNode [
	| multipleBind guard expression |
	multipleBind := self format: aViennaNode first.
	guard := self format: aViennaNode second.
	expression := self format: aViennaNode third.
	(self needsIndent: multipleBind , guard , expression)
		ifFalse: [ ^ 'let ' , multipleBind , ' be st ' , guard , ' in ' , expression ].
	(self needsIndent: multipleBind , guard)
		ifFalse: [ 
			^ 'let ' , multipleBind , ' be st ' , guard , String cr , 'in'
				,
					((self needsIndent: expression)
						ifTrue: [ String cr , indent , (self indentString: expression) ]
						ifFalse: [ String space , expression ]) ].
	^ 'let'
		,
			((self needsIndent: multipleBind)
				ifTrue: [ String cr , indent , (self indentString: multipleBind) ]
				ifFalse: [ String space , multipleBind ]) , String cr , 'be st'
		,
			((self needsIndent: guard)
				ifTrue: [ String cr , indent , (self indentString: guard) ]
				ifFalse: [ String space , guard ]) , String cr , 'in'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ])
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> letBeStatement: aViennaNode [
	| multipleBind guard statement |
	multipleBind := self format: aViennaNode first.
	guard := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	(self needsIndent: multipleBind , guard , statement)
		ifFalse: [ ^ 'let ' , multipleBind , ' be st ' , guard , ' in ' , statement ].
	(self needsIndent: multipleBind , guard)
		ifFalse: [ 
			^ 'let ' , multipleBind , ' be st ' , guard , String cr , 'in'
				,
					((self needsIndent: statement)
						ifTrue: [ String cr , indent , (self indentString: statement) ]
						ifFalse: [ String space , statement ]) ].
	^ 'let'
		,
			((self needsIndent: multipleBind)
				ifTrue: [ String cr , indent , (self indentString: multipleBind) ]
				ifFalse: [ String space , multipleBind ]) , String cr , 'be st'
		,
			((self needsIndent: guard)
				ifTrue: [ String cr , indent , (self indentString: guard) ]
				ifFalse: [ String space , guard ]) , String cr , 'in'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent , (self indentString: statement) ]
				ifFalse: [ String space , statement ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> letExpression: aViennaNode [
	| localDefinitionList expression |
	localDefinitionList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ (self needsIndent: localDefinitionList , expression)
		ifTrue: [ 
			'let'
				,
					((self needsIndent: localDefinitionList)
						ifTrue: [ String cr , indent , (self indentString: localDefinitionList) ]
						ifFalse: [ String space , localDefinitionList ]) , String cr , 'in'
				,
					((self needsIndent: expression)
						ifTrue: [ String cr , indent , (self indentString: expression) ]
						ifFalse: [ String space , expression ]) ]
		ifFalse: [ 'let ' , localDefinitionList , ' in ' , expression ]
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> letStatement: aViennaNode [
	| localDefinitionList statement |
	localDefinitionList := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ (self needsIndent: localDefinitionList , statement)
		ifTrue: [ 
			'let'
				,
					((self needsIndent: localDefinitionList)
						ifTrue: [ String cr , indent , (self indentString: localDefinitionList) ]
						ifFalse: [ String space , localDefinitionList ]) , String cr , 'in'
				,
					((self needsIndent: statement)
						ifTrue: [ String cr , indent , (self indentString: statement) ]
						ifFalse: [ String space , statement ]) ]
		ifFalse: [ 'let ' , localDefinitionList , ' in ' , statement ]
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> localDefinition: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> localDefinitionList: aViennaNode [
	| localDefinitions |
	localDefinitions := self formatAll: aViennaNode.
	^ (self anyNeedsIndent: localDefinitions)
		ifTrue: [ ',' , String cr join: localDefinitions ]
		ifFalse: [ ', ' join: localDefinitions ]
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> localName: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> logicalEquivalence: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '<=>' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapComprehension: aViennaNode [
	| keyExpression valueExpression bindList guard |
	keyExpression := self format: aViennaNode first.
	valueExpression := self format: aViennaNode second.
	bindList := self format: aViennaNode third.
	guard := aViennaNode fourth ifNotNil: [ self format: aViennaNode fourth ] ifNil: [ '' ].
	(self needsIndent: keyExpression , valueExpression , bindList , guard)
		ifFalse: [ ^ '{' , keyExpression , ' |-> ' , valueExpression , ' | ' , bindList , ' & ' , guard , '}' ].
	^ '{'
		,
			((self needsIndent: keyExpression , valueExpression)
				ifTrue: [ keyExpression , String cr , '|-> ' , (self indentString: valueExpression) ]
				ifFalse: [ keyExpression , ' |-> ' , valueExpression ]) , String cr , indent , '| '
		,
			((self needsIndent: bindList , guard)
				ifTrue: [ (self indentString: bindList) , (guard ifNotEmpty: [ String cr , indent , '& ' , (self indentString: guard) ]) ]
				ifFalse: [ (self indentString: bindList) , (guard ifNotEmpty: [ ' & ' , guard ]) ]) , '}'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapDomain: aViennaNode [
	^ 'dom ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapDomainRestrictedBy: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '<-:' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapDomainRestrictedTo: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '<:' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapEnumeration: aViennaNode [
	| lines |
	aViennaNode size = 0
		ifTrue: [ ^ '{|->}' ].
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| line |
			line := self format: aViennaNode first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: aViennaNode size do: [ :index | 
				| element |
				element := self format: (aViennaNode at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ', ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ '{' , (',' , String cr join: lines) , '}'
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> mapEnumerationPattern: aViennaNode [
	| lines |
	aViennaNode first size = 0
		ifTrue: [ ^ '{|->}' ].
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| node line |
			node := aViennaNode first.
			line := self format: node first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: node size do: [ :index | 
				| element |
				element := self format: (node at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ', ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ '{' , (',' , String cr join: lines) , '}'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapInverse: aViennaNode [
	^ 'inverse ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapMerge: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'munion' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> mapMunionPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'munion' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapOrSequenceModify: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '++' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapOrSequenceReference: aViennaNode [
	^ (self print: (self format: aViennaNode first) , '(' withChildren: {(self format: aViennaNode second)}) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapRange: aViennaNode [
	^ 'rng ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapRangeRestrictedBy: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: ':->' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapRangeRestrictedTo: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: ':>' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> mapType: aViennaNode [
	^ 'map ' , (self format: aViennaNode first) , ' to ' , (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> maplet: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '|->' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> mapletList: aViennaNode [
	| maplets |
	maplets := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: maplets)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: maplets
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> mapletPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '|->' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> matchValue: aViennaNode [
	| value |
	value := self format: aViennaNode first.
	^ aViennaNode first label = 'SymbolicLiteral'
		ifTrue: [ value ]
		ifFalse: [ '(' , value , ')' ]
]

{ #category : #accessing }
ViennaVDMFormatter >> maxSizePerLine [
	^ maxSizePerLine
]

{ #category : #accessing }
ViennaVDMFormatter >> maxSizePerLine: anInteger [
	maxSizePerLine := anInteger
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> multipleSetBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'in set' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> multipleTypeBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: ':' arg: (self format: aViennaNode second)
]

{ #category : #private }
ViennaVDMFormatter >> needsIndent: aString [
	^ (aString includes: Character cr) or: [ aString size > self maxSizePerLine ]
]

{ #category : #private }
ViennaVDMFormatter >> needsParen [
	| childContext childNode childPrecedence parentContext parentNode parentPrecedence |
	childContext := thisContext sender.
	[ childContext notNil and: [ childContext selector ~= #format: ] ] whileTrue: [ childContext := childContext sender ].
	childContext ifNil: [ ^ false ].
	childNode := childContext arguments first.
	childPrecedence := OperatorPrecedence at: childNode label ifAbsent: [ ^ false ].
	parentContext := childContext sender.
	[ parentContext notNil and: [ parentContext selector ~= #format: ] ]
		whileTrue: [ parentContext := parentContext sender ].
	parentContext ifNil: [ ^ false ].
	parentNode := parentContext arguments first.
	parentPrecedence := OperatorPrecedence at: parentNode label ifAbsent: [ ^ false ].
	childPrecedence < parentPrecedence
		ifTrue: [ ^ true ].
	parentPrecedence < childPrecedence
		ifTrue: [ ^ false ].
	^ OperatorGrouping
		at: parentNode label
		ifPresent: [ :grouping | 
			(grouping = #left and: [ parentNode first ~= childNode ])
				or: [ grouping = #right and: [ parentNode second ~= childNode ] ] ]
		ifAbsent: [ false ]
]

{ #category : #private }
ViennaVDMFormatter >> newlineIndentAllStrings: anArrayOfString [
	^ String new join: (anArrayOfString collect: [ :string | self newlineIndentString: string ])
]

{ #category : #private }
ViennaVDMFormatter >> newlineIndentString: aString [
	^ String cr , indent , (self indentString: aString)
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> nondeterministicStatement: aViennaNode [
	| statements |
	statements := self formatAll: aViennaNode.
	^ '||('
		,
			((self anyNeedsIndent: statements)
				ifTrue: [ ',' , String cr , indent join: (statements collect: [ :statement | self indentString: statement ]) ]
				ifFalse: [ ', ' join: statements ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> not: aViennaNode [
	^ 'not ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> notEqual: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '<>' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> notInSet: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'not in set' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> objectPattern: aViennaNode [
	| identifier fieldPatternList |
	identifier := self format: aViennaNode first.
	fieldPatternList := self format: aViennaNode second.
	^ 'obj_' , identifier , '('
		,
			((self needsIndent: fieldPatternList)
				ifTrue: [ String cr , indent , (self indentString: fieldPatternList) ]
				ifFalse: [ fieldPatternList ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> oldName: aViennaNode [
	^ (self format: aViennaNode first) , '~'
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> operationBody: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> operationDefinition: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> operationDefinitions: aViennaNode [
	^ 'operations' , String cr , indent
		, (self indentAllStrings: (self formatAll: aViennaNode) withTerminator: ';' , String cr)
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> operationType: aViennaNode [
	^ (self format: aViennaNode first) , ' ==> ' , (self format: aViennaNode second)
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> optionalType: aViennaNode [
	^ '[' , (self format: aViennaNode first) , ']'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> or: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'or' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> othersExpression: aViennaNode [
	| expression |
	expression := self format: aViennaNode first.
	^ 'others ->'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent ]
				ifFalse: [ String space ]) , expression
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> othersStatement: aViennaNode [
	| statement |
	statement := self format: aViennaNode first.
	^ 'others ->'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent ]
				ifFalse: [ String space ]) , statement
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> parameters: aViennaNode [
	^ '(' , (', ' join: (self formatAll: aViennaNode)) , ')'
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> parametersList: aViennaNode [
	^ '' join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> partialFunctionType: aViennaNode [
	^ (self format: aViennaNode first) , ' -> ' , (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> patternIdentifier: aViennaNode [
	^ aViennaNode first ifNil: ['-'] ifNotNil: [:identifier | self format:identifier]
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> patternList: aViennaNode [
	| patterns |
	patterns := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: patterns)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: patterns
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> preconditionExpression: aViennaNode [
	| expressions |
	expressions := self formatAll: aViennaNode.
	^ 'pre_('
		,
			((self anyNeedsIndent: expressions)
				ifTrue: [ ',' , String cr , indent join: (expressions collect: [ :expression | self indentString: expression ]) ]
				ifFalse: [ ', ' join: expressions ]) , ')'
]

{ #category : #private }
ViennaVDMFormatter >> print: argString1 infix: opString arg: argString2 [
	^ (self needsIndent: argString1 , argString2)
		ifTrue: [ argString1 , String cr , opString , String space , argString2 ]
		ifFalse: [ argString1 , String space , opString , String space , argString2 ]
]

{ #category : #private }
ViennaVDMFormatter >> print: aString withChildren: anArrayOfString [
	^ (self anyNeedsIndent: (anArrayOfString copyWith: aString))
		ifTrue: [ aString , (self newlineIndentAllStrings: anArrayOfString) ]
		ifFalse: [ aString , String space , (String space join: anArrayOfString) ]
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> productType: aViennaNode [
	| lines |
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| line |
			line := self format: aViennaNode first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: aViennaNode size do: [ :index | 
				| element |
				element := self format: (aViennaNode at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ' * ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ ' *' , String cr join: lines
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> properSubset: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'psubset' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> quoteType: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> recordConstructor: aViennaNode [
	| constructor expressionList |
	constructor := self format: aViennaNode first.
	expressionList := self format: aViennaNode second.
	^ 'mk_' , constructor , '('
		,
			((self needsIndent: expressionList)
				ifTrue: [ String cr , indent , (self indentString: expressionList) ]
				ifFalse: [ expressionList ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> recordModifier: aViennaNode [
	| record mapletList |
	record := self format: aViennaNode first.
	mapletList := self format: aViennaNode second.
	^ 'mu(' , record , ','
		,
			((self needsIndent: record , mapletList)
				ifTrue: [ String cr , indent , (self indentString: mapletList) ]
				ifFalse: [ mapletList ]) , ')'
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> recordPattern: aViennaNode [
	| constructor expressionList |
	constructor := self format: aViennaNode first.
	expressionList := self format: aViennaNode second.
	^ 'mk_' , constructor , '('
		,
			((self needsIndent: constructor , expressionList)
				ifTrue: [ String cr , indent , (self indentString: expressionList) ]
				ifFalse: [ expressionList ]) , ')'
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> recordTypeDefinition: aViennaNode [
	| identifier fieldList invariant |
	identifier := self format: aViennaNode first.
	fieldList := self format: aViennaNode second.
	invariant := aViennaNode third
		ifNotNil: [ String cr , indent , (self indentString: (self format: aViennaNode third)) ]
		ifNil: [ '' ].
	^ identifier , ' ::'
		,
			((self needsIndent: identifier , fieldList)
				ifTrue: [ String cr , indent , (self indentString: fieldList) ]
				ifFalse: [ String space , fieldList ]) , invariant
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> reqExpression: aViennaNode [
	^ '#req(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> resultExpression: aViennaNode [
	^ 'RESULT'
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> returnStatement: aViennaNode [
	^ 'return ' , (self indentString: (self format: aViennaNode first))
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> samebaseclassExpression: aViennaNode [
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'samebaseclass(' , cls , ','
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sameclassExpression: aViennaNode [
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'sameclass(' , cls , ','
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> selfExpression: aViennaNode [
	^ 'self'
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> seq1Type: aViennaNode [
	^ 'seq1 of ' , (self format: aViennaNode first)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> seqConcPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '^' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> seqEnumPattern: aViennaNode [
	| lines |
	aViennaNode first size = 0
		ifTrue: [ ^ '[]' ].
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| line node |
			node := aViennaNode first.
			line := self format: node first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: node size do: [ :index | 
				| element |
				element := self format: (node at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ', ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ '[' , (',' , String cr join: lines) , ']'
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> seqType: aViennaNode [
	^ 'seq of ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceComprehension: aViennaNode [
	| expression setBind guard |
	expression := self format: aViennaNode first.
	setBind := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ self format: aViennaNode fourth ] ifNil: [ '' ].
	(self needsIndent: expression , setBind , guard)
		ifFalse: [ ^ '[' , expression , ' | ' , setBind , ' & ' , guard , ']' ].
	^ '[' , expression , String cr , indent , '| '
		,
			((self needsIndent: setBind , guard)
				ifTrue: [ (self indentString: setBind) , (guard ifNotEmpty: [ String cr , indent , '& ' , (self indentString: guard) ]) ]
				ifFalse: [ (self indentString: setBind) , (guard ifNotEmpty: [ ' & ' , guard ]) ]) , ']'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceConcatenate: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '^' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceElements: aViennaNode [
	^ 'elems ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceEnumeration: aViennaNode [
	|  lines |
	aViennaNode first size = 0
		ifTrue: [ ^ '[]' ].
		
	lines := Array
		new: aViennaNode first size
		streamContents: [ :stream | 
			| node line |
			node := aViennaNode first.
			line := self format: node first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: node size do: [ :index | 
				| element |
				element := self format: (node at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ', ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ '[' , (',' , String cr join: lines) , ']'
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> sequenceForLoop: aViennaNode [
	| patternBind expression statement |
	patternBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	(self needsIndent: patternBind , expression , statement)
		ifFalse: [ ^ 'for ' , patternBind , ' in ' , expression , ' do ' , statement ].
	(self needsIndent: patternBind , expression)
		ifFalse: [ ^ 'for ' , patternBind , ' in ' , expression , ' do' , String cr , indent , (self indentString: statement) ].
	^ 'for'
		,
			((self needsIndent: patternBind)
				ifTrue: [ String cr , indent , (self indentString: patternBind) ]
				ifFalse: [ String space , patternBind ]) , String cr , 'in'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , String cr , 'do'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent , (self indentString: statement) ]
				ifFalse: [ String space , statement ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceHead: aViennaNode [
	^ 'hd ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceIndices: aViennaNode [
	^ 'inds ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceLength: aViennaNode [
	^ 'len ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceReverse: aViennaNode [
	^ 'reverse ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceTail: aViennaNode [
	^ 'tl ' , (self format: aViennaNode first)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> setBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'in set' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> setCardinality: aViennaNode [
	^ self print: 'card' withChildren: (self formatAll: aViennaNode)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> setComprehension: aViennaNode [
	| expression bindList guard |
	expression := self format: aViennaNode first.
	bindList := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ self format: aViennaNode third ] ifNil: [ '' ].
	(self needsIndent: expression , bindList , guard)
		ifFalse: [ ^ '{' , expression , ' | ' , bindList , ' & ' , guard , '}' ].
	^ '{' , expression , String cr , indent , '| '
		,
			((self needsIndent: bindList , guard)
				ifTrue: [ (self indentString: bindList) , (guard ifNotEmpty: [ String cr , indent , '& ' , (self indentString: guard) ]) ]
				ifFalse: [ (self indentString: bindList) , (guard ifNotEmpty: [ ' & ' , guard ]) ]) , '}'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> setDifference: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '\' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> setEnumPattern: aViennaNode [
	| lines |
	aViennaNode first size = 0
		ifTrue: [ ^ '{}' ].
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| node line |
			node := aViennaNode first.
			line := self format: node first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: node size do: [ :index | 
				| element |
				element := self format: (node at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ', ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ '{' , (',' , String cr join: lines) , '}'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> setEnumeration: aViennaNode [
	| lines |
	aViennaNode first size = 0
		ifTrue: [ ^ '{}' ].
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| node line |
			node := aViennaNode first.
			line := self format: node first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: node size do: [ :index | 
				| element |
				element := self format: (node at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ', ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ '{' , (',' , String cr join: lines) , '}'
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> setForLoop: aViennaNode [
	| pattern expression statement |
	pattern := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	(self needsIndent: pattern , expression , statement)
		ifFalse: [ ^ 'for all ' , pattern , ' in set ' , expression , ' do ' , statement ].
	(self needsIndent: pattern , expression)
		ifFalse: [ ^ 'for all ' , pattern , ' in set ' , expression , ' do' , String cr , indent , (self indentString: statement) ].
	^ 'for all'
		,
			((self needsIndent: pattern)
				ifTrue: [ String cr , indent , (self indentString: pattern) ]
				ifFalse: [ String space , pattern ]) , String cr , 'in set'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , String cr , 'do'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent , (self indentString: statement) ]
				ifFalse: [ String space , statement ])
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> setIntersection: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'inter' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> setRangeExpression: aViennaNode [
	| start end |
	start := self format: aViennaNode first.
	end := self format: aViennaNode second.
	^ '{' , start
		,
			((self needsIndent: start , end)
				ifTrue: [ ',' , String cr , indent , '..., ' , (self indentString: end) ]
				ifFalse: [ ',..., ' , end ]) , '}'
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> setType: aViennaNode [
	^ 'set of ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> setUnion: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'union' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> setUnionPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'union' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> stateDefinition: aViennaNode [
	| identifier stateFieldList invariant initialisation |
	identifier := self format: aViennaNode first.
	stateFieldList := self format: aViennaNode second.
	invariant := aViennaNode third ifNotNil: [ self format: aViennaNode third ].
	initialisation := aViennaNode fourth ifNotNil: [ self format: aViennaNode fourth ].
	^ 'state ' , identifier , ' of' , String cr , indent , (self indentString: stateFieldList)
		, (invariant ifNil: [ '' ] ifNotNil: [ String cr , indent , (self indentString: invariant) ])
		, (initialisation ifNil: [ '' ] ifNotNil: [ String cr , indent , (self indentString: initialisation) ]) , String cr
		, 'end'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> subsequence: aViennaNode [
	| sequence start end |
	sequence := self format: aViennaNode first.
	start := self format: aViennaNode second.
	end := self format: aViennaNode third.
	(self needsIndent: sequence , start , end)
		ifFalse: [ ^ sequence , '(' , start , ',...,' , end , ')' ].
	(self needsIndent: start , end)
		ifFalse: [ ^ sequence , '(' , String cr , indent , (self indentString: start , ',..., ' , end , ')') ].
	^ sequence , '(' , String cr , indent
		, (self indentString: start , ',' , String cr , indent , '..., ' , (self indentString: end , ')'))
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> subset: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'subset' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> symbolicLiteral: aViennaNode [
	| literal |
	literal := aViennaNode first trim.
	^ literal
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> threadidExpression: aViennaNode [
	^ 'threadid'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> timeExpression: aViennaNode [
	^ 'time'
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> totalFunctionType: aViennaNode [
	^ (self format: aViennaNode first) , ' +> ' , (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> tupleConstructor: aViennaNode [
	| expressionList |
	expressionList := self format: aViennaNode first.
	^ 'mk_('
		,
			((self needsIndent: expressionList)
				ifTrue: [ String cr , indent , (self indentString: expressionList) ]
				ifFalse: [ expressionList ]) , ')'
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> tuplePattern: aViennaNode [
	| expressionList |
	expressionList := self format: aViennaNode first.
	^ 'mk_('
		,
			((self needsIndent: expressionList)
				ifTrue: [ String cr , indent , (self indentString: expressionList) ]
				ifFalse: [ expressionList ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> tupleSelect: aViennaNode [
	| tuple int |
	tuple := self format: aViennaNode first.
	int := self format: aViennaNode second.
	^ self print: tuple infix: '.#' arg: int
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> typeBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: ':' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> typeDefinition: aViennaNode [
	| typeName baseType invariant |
	typeName := self format: aViennaNode first.
	baseType := self format: aViennaNode second.
	invariant := aViennaNode third ifNotNil: [ self format: aViennaNode third ].
	^ typeName , ' = '
		,
			((self needsIndent: typeName , baseType)
				ifTrue: [ self indentString: baseType ]
				ifFalse: [ baseType ])
		,
			(invariant
				ifNil: [ '' ]
				ifNotNil: [ 
					(self needsIndent: typeName , baseType , invariant)
						ifTrue: [ String cr , indent , (self indentString: invariant) ]
						ifFalse: [ String space , invariant ] ])
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> typeDefinitions: aViennaNode [
	^ 'types' , String cr , indent , (self indentAllStrings: (self formatAll: aViennaNode) withTerminator: ';')
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> typeJudgement: aViennaNode [
	| type expression |
	expression := self format: aViennaNode first.
	type := self format: aViennaNode second.
	(self needsIndent: expression , type)
		ifFalse: [ ^ 'is_(' , expression , ', ' , type , ')' ].
	^ 'is_('
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ expression ]) , ',' , String cr , indent , (self indentString: type) , ')'
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> typeName: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> typeVariable: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> typeVariableIdentifier: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> typeVariableList: aViennaNode [
	^ aViennaNode size > 0
		ifTrue: [ '[' , (String space join: (self formatAll: aViennaNode)) , ']' ]
		ifFalse: [ '' ]
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> unaryMinus: aViennaNode [
	^ '-' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> unaryPlus: aViennaNode [
	^ '+' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> undefinedExpression: aViennaNode [
	^ 'undefined'
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> unionType: aViennaNode [
	| lines |
	lines := Array
		new: aViennaNode size
		streamContents: [ :stream | 
			| line |
			line := self format: aViennaNode first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: aViennaNode size do: [ :index | 
				| element |
				element := self format: (aViennaNode at: index).
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ ' | ' ]) , element.
						(self needsIndent: line)
							ifTrue: [ 
								origLine
									ifEmpty: [ 
										stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ 
										stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ ' |' , String cr join: lines
]

{ #category : #'formatting-types' }
ViennaVDMFormatter >> unitType: aViennaNode [
	^ '()'
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> valueDefinition: aViennaNode [
	| identifier type expression |
	identifier := self format: aViennaNode first.
	type := aViennaNode second ifNotNil: [ self format: aViennaNode second ].
	expression := self format: aViennaNode third.
	^ identifier , (type ifNil: [ '' ] ifNotNil: [ ' : ' , type ]) , ' ='
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ])
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> valueDefinitions: aViennaNode [
	^ 'values' , String cr , indent , (self indentAllStrings: (self formatAll: aViennaNode) withTerminator: ';')
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> waitingExpression: aViennaNode [
	^ '#waiting(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-statements' }
ViennaVDMFormatter >> whileLoop: aViennaNode [
	| expression statement |
	expression := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	(self needsIndent: expression , statement)
		ifFalse: [ ^ 'while ' , expression , ' do ' , statement ].
	^ 'while'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , String cr , 'do'
		,
			((self needsIndent: statement)
				ifTrue: [ String cr , indent , (self indentString: statement) ]
				ifFalse: [ String space , statement ])
]
