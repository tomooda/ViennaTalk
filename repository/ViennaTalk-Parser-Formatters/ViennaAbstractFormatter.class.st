Class {
	#name : #ViennaAbstractFormatter,
	#superclass : #Object,
	#instVars : [
		'maxSizePerLine',
		'indent'
	],
	#classVars : [
		'DefaultMaxSizePerLine',
		'OperatorGrouping',
		'OperatorPrecedence'
	],
	#category : 'ViennaTalk-Parser-Formatters'
}

{ #category : #accessing }
ViennaAbstractFormatter class >> defaultMaxSizePerLine [
	^ DefaultMaxSizePerLine ifNil: [ DefaultMaxSizePerLine := 65 ]
]

{ #category : #accessing }
ViennaAbstractFormatter class >> defaultMaxSizePerLine: anInteger [
	DefaultMaxSizePerLine := anInteger asInteger
]

{ #category : #utilities }
ViennaAbstractFormatter class >> format: aViennaNode [
	^ self new format: aViennaNode
]

{ #category : #utilities }
ViennaAbstractFormatter class >> formatSource: aString ifError: errorBlock [
	| ast |
	ast := ViennaVDMParser new parse: aString asString.
	ast isPetitFailure
		ifTrue: [ ^ errorBlock value ].
	^ self format: ast
]

{ #category : #'class initialization' }
ViennaAbstractFormatter class >> initialize [
	super initialize.
	self initializeOperatorPrecedence.
	self initializeOperatorGrouping
]

{ #category : #'class initialization' }
ViennaAbstractFormatter class >> initializeOperatorGrouping [
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
		at: 'ArithmeticMultiplication' put: #left;
		at: 'ArithmeticDivide' put: #left;
		at: 'ArithmeticRem' put: #left;
		at: 'ArithmeticMod' put: #left;
		at: 'ArithmeticIntegerDivision' put: #left;
		at: 'ArithmeticMinus' put: #left;
		at: 'ArithmeticPlus' put: #left;
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
ViennaAbstractFormatter class >> initializeOperatorPrecedence [
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
		at: 'SequenceReverse' put: 36;
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
		at: 'LambdaExpression' put: 10;
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

{ #category : #settings }
ViennaAbstractFormatter class >> viennaSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder setting: #defaultFormatWidth)
		parent: #ViennaTalkAppearances;
		target: self;
		getSelector: #defaultMaxSizePerLine;
		setSelector: #defaultMaxSizePerLine:;
		description: 'The default width to format VDM sources.';
		label: 'Format width';
		order: 0.51
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> access: aViennaNode [
	^ ' ' join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> accessFunctionDefinition: aViennaNode [
	^ ' ' join: ((self formatAll: aViennaNode) reject: #isEmpty)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> accessOperationDefinition: aViennaNode [
	^ ' ' join: ((self formatAll: aViennaNode) reject: #isEmpty)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> accessTypeDefinition: aViennaNode [
	^ ' ' join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> accessValueDefinition: aViennaNode [
	^ ' ' join: (self formatAll: aViennaNode)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> act [
	^ '#act'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> actExpression: aViennaNode [
	^ self act, '(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> activeExpression: aViennaNode [
	^ '#active(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> alwaysStatement: aViennaNode [
	| handler statement |
	handler := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ (self needsIndent: handler)
		ifTrue: [ (self indentString: 'always' insertCr: handler) , String cr
				, (self indentString: 'in' insertCr: statement) ]
		ifFalse: [ self indentString: 'always ' , handler , ' in' insertCrIfNeeded: statement ]
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> and [
	^ 'and'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> and: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self and arg: (self format: aViennaNode second)
]

{ #category : #private }
ViennaAbstractFormatter >> anyNeedsIndent: anArrayOfString [
	^ (anArrayOfString contains: [ :string | string includes: Character cr ])
		or: [ (anArrayOfString inject: 0 into: [ :len :str | len + (self strlen: str) ]) > self maxSizePerLine ]
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> anyType [
	^ '?'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> apply: aViennaNode [
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
ViennaAbstractFormatter >> arithmeticAbs: aViennaNode [
	^ 'abs ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> arithmeticDivide: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '/' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> arithmeticIntegerDivision: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'div' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> arithmeticMinus: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '-' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> arithmeticMod: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'mod' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> arithmeticMultiplication: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self mul arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> arithmeticPlus: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '+' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> arithmeticRem: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'rem' arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> arrow [
	^ '->'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> assignStatement: aViennaNode [
	^ self indentString: (self format: aViennaNode first) insertCrIfNeeded: ':= ' , (self format: aViennaNode second)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> assignmentDefinition: aViennaNode [
	^ aViennaNode first , ':' , (self format: aViennaNode second)
		, (aViennaNode third ifNotNil: [ ' := ' , (self format: aViennaNode third) ] ifNil: [ '' ])
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> basicType: aViennaNode [
	| type |
	type := aViennaNode first.
	type = 'bool'
		ifTrue: [ ^ self bool ].
	type = 'nat'
		ifTrue: [ ^ self nat ].
	type = 'nat1'
		ifTrue: [ ^ self nat1 ].
	type = 'int'
		ifTrue: [ ^ self int ].
	type = 'real'
		ifTrue: [ ^ self real ].
	type = 'any'
		ifTrue: [ ^ self anyType ].
	^ type
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> bindList: aViennaNode [
	| binds |
	binds := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: binds)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: binds
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> blockStatement: aViennaNode [
	^ '(' , (';' , String cr join: (self formatAll: aViennaNode)) , ')'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> bool [
	^ 'bool'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> callStatement: aViennaNode [
	| args |
	args := self format: aViennaNode second.
	^ (self format: aViennaNode first) , '('
		,
			((self needsIndent: args)
				ifTrue: [ self newlineIndentString: args ]
				ifFalse: [ args ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> casesExpression: aViennaNode [
	| value alternatives others |
	value := self format: aViennaNode first.
	alternatives := self format: aViennaNode second.
	others := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | ',' , String cr , (self format: node) ].
	^ self
		indentString:
			'cases ' , (self format: aViennaNode first) , ':' , String cr , (self format: aViennaNode second) , others , String cr
				, 'end'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> casesExpressionAlternative: aViennaNode [
	| patternList expression |
	patternList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: patternList , ' ', self arrow insertCrIfNeeded: expression
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> casesExpressionAlternatives: aViennaNode [
	^ ',' , String cr join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> casesStatement: aViennaNode [
	| value alternatives others |
	value := self format: aViennaNode first.
	alternatives := self format: aViennaNode second.
	others := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | ',' , String cr , (self format: node) ].
	^ self
		indentString:
			'cases ' , (self format: aViennaNode first) , ':' , String cr , (self format: aViennaNode second) , others , String cr
				, 'end'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> casesStatementAlternative: aViennaNode [
	| patternList statement |
	patternList := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self indentString: patternList , ' ', self arrow insertCrIfNeeded: statement
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> casesStatementAlternatives: aViennaNode [
	^ ',' , String cr join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> compositeType: aViennaNode [
	| constructor fields |
	constructor := self format: aViennaNode first.
	fields := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'compose ' , constructor , ' of' insertCrIfNeeded: fields)
		insertCrIfNeeded: 'end'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> composition: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'comp' arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> concat [
	^ '^'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> conditionalExpression: aViennaNode [
	^ 'elseif ' , (self indentString: (self format: aViennaNode first)) , String cr , indent , 'then '
		, (self indentString: (self format: aViennaNode second))
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> conditionalStatement: aViennaNode [
	^ 'elseif ' , (self indentString: (self format: aViennaNode first)) , String cr , indent , 'then '
		, (self indentString: (self format: aViennaNode second))
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> dclStatement: aViennaNode [
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
ViennaAbstractFormatter >> defExpression: aViennaNode [
	| defs expression |
	defs := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		indentString: (self indentString: 'def' insertCrIfNeeded: defs)
		insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: expression)
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> defStatement: aViennaNode [
	| equalDefinitionList statement |
	equalDefinitionList := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'def' insertCrIfNeeded: equalDefinitionList)
		insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: statement)
]

{ #category : #defaults }
ViennaAbstractFormatter >> defaultIndent [
	^ '    '
]

{ #category : #defaults }
ViennaAbstractFormatter >> defaultMaxSizePerLine [
	^ self class defaultMaxSizePerLine
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> definitionBlock: aViennaNode [
	^ (self format: aViennaNode first) , String cr
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> dinter [
	^ 'dinter'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> distributedMapMerge: aViennaNode [
	^ 'merge ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> distributedSequenceConcatenation: aViennaNode [
	^ 'conc ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> distributedSetIntersection: aViennaNode [
	^ self dinter , ' ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> distributedSetUnion: aViennaNode [
	^ self dunion , ' ' , (self format: aViennaNode first)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> document: aViennaNode [
	^ String cr join: (self formatAll: aViennaNode)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> domainRestrictedBy [
	^ '<-:'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> domainRestrictedTo [
	^ '<:'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> dot [
	^ '&'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> dots [
	^ '...'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> dunion [
	^ 'dunion'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> equal: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '=' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> equalDefinition: aViennaNode [
	| patternBind expression |
	patternBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: patternBind , ' =' insertCrIfNeeded: expression
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> equalDefinitionList: aViennaNode [
	| defs |
	defs := self formatAll: aViennaNode.
	^ (';' , String cr join: defs) , ';'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> equiv [
	^ '<=>'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> error: aViennaNode [
	^ aViennaNode first , ':' , (self format: aViennaNode second) , '->'
		, (self format: aViennaNode third)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> errorList: aViennaNode [
	^ String
		new: 1024
		streamContents: [ :stream | 
			aViennaNode
				do: [ :node | 
					stream
						space;
						nextPutAll: (self format: node) ] ]
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> errorStatement: aViennaNode [
	^ 'error'
]

{ #category : #private }
ViennaAbstractFormatter >> escapeString: aString [
	^ aString
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> exceptions: aViennaNode [
	^ 'errs' , (self format: aViennaNode first)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> exists [
	^ 'exists'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> exists1 [
	^ 'exists1'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> exists1Expression: aViennaNode [
	| bind expression |
	bind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		indentString: (self indentString: self exists1 insertCrIfNeeded: bind , ' ' , self dot)
		insertCrIfNeeded: expression
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> existsExpression: aViennaNode [
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		indentString: (self indentString: self exists insertCrIfNeeded: bindList trim , ' ' , self dot)
		insertCrIfNeeded: expression
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> exitStatement: aViennaNode [
	^ 'exit ' , (self indentString: (self format: aViennaNode first))
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> explicitFunctionDefinition: aViennaNode [
	| identifier1 typeVariableList functionType identifier2 parametersList expression pre post measure |
	identifier1 := self format: aViennaNode first.
	typeVariableList := self format: aViennaNode second.
	functionType := self format: aViennaNode third.
	identifier2 := self format: aViennaNode fourth.
	parametersList := self format: aViennaNode fifth.
	expression := self format: aViennaNode sixth.
	pre := aViennaNode seventh ifNotNil: [ :node | String cr , 'pre ' , (self format: node) ] ifNil: [ '' ].
	post := aViennaNode eighth ifNotNil: [ :node | String cr , 'post ' , (self format: node) ] ifNil: [ '' ].
	measure := aViennaNode ninth ifNotNil: [ :node | String cr , 'measure ' , (self format: node) ] ifNil: [ '' ].
	^ identifier1 , typeVariableList , ' : ' , functionType , String cr
		, (self indentString: identifier2 , parametersList , ' ==' insertCrIfNeeded: expression) , pre , post , measure
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> explicitOperationDefinition: aViennaNode [
	| identifier1 operationType identifier2 parameters expression pre post |
	identifier1 := self format: aViennaNode first.
	operationType := self format: aViennaNode second.
	identifier2 := self format: aViennaNode third.
	parameters := self format: aViennaNode fourth.
	expression := self format: aViennaNode fifth.
	pre := aViennaNode sixth
		ifNotNil: [ :node | String cr , (self indentString: 'pre ' insertCrIfNeeded: (self format: node)) ]
		ifNil: [ '' ].
	post := aViennaNode seventh
		ifNotNil: [ :node | String cr , (self indentString: 'post ' insertCrIfNeeded: (self format: node)) ]
		ifNil: [ '' ].
	^ identifier1 , ' : ' , operationType , String cr
		, (self indentString: identifier2 , parameters , ' ==' insertCrIfNeeded: expression) , pre , post
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportDefinition: aViennaNode [
	| exportSig |
	exportSig := self format: aViennaNode first.
	^ self indentString: 'exports' insertCrIfNeeded: exportSig
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportFunctionsSignature: aViennaNode [
	| functionExports |
	functionExports := self formatAll: aViennaNode.
	^ self indentString: 'functions' insertCrIfNeeded: (';' , String cr join: functionExports) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportModuleSignatrueAll: aViennaNode [
	^ 'all'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportModuleSignature: aViennaNode [
	| exportSignatures |
	exportSignatures := self formatAll: aViennaNode.
	^ String cr join: exportSignatures
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportTypesSignature: aViennaNode [
	| typeExports |
	typeExports := self formatAll: aViennaNode.
	^ self indentString: 'types' insertCrIfNeeded: (';' , String cr join: typeExports) , ';'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> expressionList: aViennaNode [
	| expressions |
	expressions := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: expressions)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: expressions
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> extendedExplicitFunctionDefinition: aViennaNode [
	| identifier typeVariableList parameterTypes identifierTypePairList body pre post |
	identifier := aViennaNode first.
	typeVariableList := aViennaNode second.
	parameterTypes := aViennaNode third.
	identifierTypePairList := aViennaNode fourth.
	body := aViennaNode fifth.
	pre := aViennaNode sixth.
	post := aViennaNode seventh.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: (self format: identifier);
				nextPutAll: (self format: typeVariableList);
				nextPutAll: (self format: parameterTypes);
				nextPutAll: (self format: identifierTypePairList);
				nextPutAll: ' ==';
				cr;
				nextPutAll: indent;
				nextPutAll: (self indentString: (self format: body)).
			pre
				ifNotNil: [ stream
						cr;
						nextPutAll: 'pre ';
						nextPutAll: (self format: pre) ].
			stream
				cr;
				nextPutAll: 'post ';
				nextPutAll: (self format: post) ]
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> extendedExplicitOperationDefinition: aViennaNode [
	| identifier parameterTypes identifierTypePairList body externals pre post exceptions |
	identifier := aViennaNode first.
	parameterTypes := aViennaNode second.
	identifierTypePairList := aViennaNode third.
	body := aViennaNode fourth.
	externals := aViennaNode fifth.
	pre := aViennaNode sixth.
	post := aViennaNode seventh.
	exceptions := aViennaNode eighth.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: (self format: identifier);
				nextPutAll: (self format: parameterTypes);
				nextPutAll: (self format: identifierTypePairList);
				nextPutAll: ' ==';
				cr;
				nextPutAll: indent;
				nextPutAll: (self indentString: (self format: body)).
			externals
				ifNotNil: [ stream
						cr;
						nextPutAll: (self format: externals) ].
			pre
				ifNotNil: [ stream
						cr;
						nextPutAll: 'pre ';
						nextPutAll: (self format: pre) ].
			stream
				cr;
				nextPutAll: 'post ';
				nextPutAll: (self format: post).
			exceptions
				ifNotNil: [ stream
						cr;
						nextPutAll: (self format: exceptions) ] ]
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> externals: aViennaNode [
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: 'ext'.
			aViennaNode
				do: [ :varInfo | 
					stream
						space;
						nextPutAll: (self format: varInfo) ] ]
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> field: aViennaNode [
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

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> fieldList: aViennaNode [
	| fields |
	fields := self formatAll: aViennaNode.
	^ ((self anyNeedsIndent: fields)
		ifTrue: [ String cr ]
		ifFalse: [ String space ]) join: fields
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> fieldPattern: aViennaNode [
	| identifier pattern |
	identifier := self format: aViennaNode first.
	pattern := self format: aViennaNode second.
	^ identifier , ' ', self maplet, ' ', pattern
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> fieldPatternList: aViennaNode [
	| fieldPatterns |
	fieldPatterns := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: fieldPatterns)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: fieldPatterns
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> fieldReference: aViennaNode [
	| stateDesignator field |
	stateDesignator := self format: aViennaNode first.
	field := self format: aViennaNode second.
	^ self indentString: stateDesignator insertCrIfNeeded: '.' , field
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> fieldSelect: aViennaNode [
	| record field |
	record := self format: aViennaNode first.
	field := self format: aViennaNode second.
	^ record , '.' , field
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> finExpression: aViennaNode [
	^ '#fin(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> finitePowerSet: aViennaNode [
	^ self power , ' ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> floor: aViennaNode [
	^ 'floor ' , (self format: aViennaNode first)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> forall [
	^ 'forall'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> forallExpression: aViennaNode [
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		indentString: (self indentString: self forall insertCrIfNeeded: bindList trim , ' ' , self dot)
		insertCrIfNeeded: expression
]

{ #category : #formatting }
ViennaAbstractFormatter >> format: aViennaNode [
	| string |
	aViennaNode isString
		ifTrue: [ ^ aViennaNode ].
	string := self perform: (aViennaNode label uncapitalized , ':') asSymbol with: aViennaNode.
	self needsParen
		ifTrue: [ string := '(' , (self indentString: string) , ')' ].
	^ string
]

{ #category : #formatting }
ViennaAbstractFormatter >> formatAll: aViennaNodeOrArray [
	| array |
	array := Array new: aViennaNodeOrArray size.
	1 to: array size do: [ :i | array at: i put: (self format: (aViennaNodeOrArray at: i)) ].
	^ array
]

{ #category : #private }
ViennaAbstractFormatter >> formatEnumerate: anArrayOfString ifEmpty: aBlock [
	^ self formatEnumerate: anArrayOfString separator: ',' ifEmpty: aBlock
]

{ #category : #private }
ViennaAbstractFormatter >> formatEnumerate: anArrayOfString separator: aString ifEmpty: aBlock [
	| lines |
	anArrayOfString size = 0
		ifTrue: [ ^ aBlock value ].
	lines := Array
		new: anArrayOfString size
		streamContents: [ :stream | 
			| line |
			line := anArrayOfString first.
			(self needsIndent: line)
				ifTrue: [ 
					stream nextPut: line.
					line := '' ].
			2 to: anArrayOfString size do: [ :index | 
				| element |
				element := anArrayOfString at: index.
				(self needsIndent: element)
					ifTrue: [ 
						line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ 
						| origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ aString , String space ]) , element.
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
	^ aString , String cr join: lines
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> functionDefinition: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> functionDefinitions: aViennaNode [
	^ self
		indentString: 'functions'
		insertCr: (';' , String cr , String cr join: (self formatAll: aViennaNode)) , ';' , String cr
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> functionExport: aViennaNode [
	| nameList typeVarList functionType |
	nameList := self format: aViennaNode first.
	typeVarList := self format: aViennaNode second.
	functionType := self format: aViennaNode third.
	^ self indentString: nameList , typeVarList insertCrIfNeeded: ': ' , functionType
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> functionImport: aViennaNode [
	| name typeVariableList type rename |
	name := self format: aViennaNode first.
	typeVariableList := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | self format: node ].
	type := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | ': ' , (self format: node) ].
	rename := aViennaNode fourth ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: name , typeVariableList , type insertCrIfNeeded: rename
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> functionImportType: aViennaNode [
	| typeVarList functionType |
	typeVarList := self format: aViennaNode first.
	functionType := self format: aViennaNode second.
	^ typeVarList , ' : ' , functionType
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> functionSignature: aViennaNode [
	| nameList functionType |
	nameList := self format: aViennaNode first.
	functionType := self format: aViennaNode second.
	^ nameList , ' : ' , functionType
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> functionTypeArgs: aViennaNode [
	^ '[' , (', ' join: (self formatAll: aViennaNode)) , ']'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> functionTypeInstantiation: aViennaNode [
	| function typeArgs |
	function := self format: aViennaNode first.
	typeArgs := self format: aViennaNode second.
	^ function , typeArgs
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> functionsSignature: aViennaNode [
	| signatures |
	signatures := self formatAll: aViennaNode.
	^ self indentString: 'functions' insertCrIfNeeded: (';' , String cr join: signatures) , ';'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> globalName: aViennaNode [
	^ aViennaNode first , '`' , aViennaNode second
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> greaterThan: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '>' arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> greaterThanOrEqual [
	^ '>='
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> greaterThanOrEqual: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self greaterThanOrEqual arg: (self format: aViennaNode second)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> identifierTypePairList: aViennaNode [
	^ String
		new: 1024
		streamContents: [ :stream | 
			aViennaNode
				ifNotEmpty: [ 1 to: aViennaNode size - 2 by: 2 do: [ :index | 
						stream
							nextPutAll: (self format: (aViennaNode at: index));
							nextPutAll: ':';
							nextPutAll: (self format: (aViennaNode at: index + 1));
							nextPutAll: ', ' ].
					stream
						nextPutAll: (self format: (aViennaNode at: aViennaNode size - 1));
						nextPutAll: ':';
						nextPutAll: (self format: (aViennaNode at: aViennaNode size)) ] ]
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> identityStatement: aViennaNode [
	^ 'skip'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> ifExpression: aViennaNode [
	| cond expr default elseifs |
	cond := self format: aViennaNode first first first.
	expr := self format: aViennaNode first first second.
	default := self format: aViennaNode second.
	elseifs := self formatAll: aViennaNode first asArray copyWithoutFirst.
	aViennaNode first size = 1
		ifTrue: [ 
			^ (self needsIndent: cond , expr , default)
				ifTrue: [ 
					(self indentString: 'if' insertCr: cond) , String cr , (self indentString: 'then' insertCr: expr) , String cr
						, (self indentString: 'else' insertCr: default) ]
				ifFalse: [ 'if ' , cond , ' then ' , expr , ' else ' , default ] ].
	^ (self indentString: 'if ' , cond insertCr: 'then ' , expr) , String cr , (String cr join: elseifs) , String cr
		, (self indentString: 'else' insertCr: default)
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> ifStatement: aViennaNode [
	| cond statement default elseifs |
	cond := self format: aViennaNode first first first.
	statement := self format: aViennaNode first first second.
	default := aViennaNode second ifNotNil: [ self format: aViennaNode second ].
	elseifs := self formatAll: aViennaNode first asArray copyWithoutFirst.
	aViennaNode first size = 1
		ifTrue: [ 
			^ (self needsIndent: cond , statement , (default ifNil: [ '' ]))
				ifTrue: [ 
					(self indentString: 'if' insertCr: cond) , String cr , (self indentString: 'then' insertCr: statement)
						, (default ifNil: [ '' ] ifNotNil: [ String cr , (self indentString: 'else' insertCr: default) ]) ]
				ifFalse: [ 'if ' , cond , ' then ' , statement , (default ifNil: [ '' ] ifNotNil: [ ' else ' , default ]) ] ].
	^ (self indentString: 'if ' , cond insertCr: 'then ' , statement) , String cr , (String cr join: elseifs)
		, (default ifNil: [ '' ] ifNotNil: [ String cr , (self indentString: 'else' insertCr: default) ])
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> implicitFunctionDefinition: aViennaNode [
	| identifier typeVariableList parameterTypes identifierTypePairList pre post |
	identifier := aViennaNode first.
	typeVariableList := aViennaNode second.
	parameterTypes := aViennaNode third.
	identifierTypePairList := aViennaNode fourth.
	pre := aViennaNode fifth.
	post := aViennaNode sixth.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: (self format: identifier);
				nextPutAll: (self format: typeVariableList);
				nextPutAll: (self format: parameterTypes);
				nextPutAll: (self format: identifierTypePairList).
			pre
				ifNotNil: [ stream
						cr;
						nextPutAll: 'pre ';
						nextPutAll: (self format: pre) ].
			stream
				cr;
				nextPutAll: 'post ';
				nextPutAll: (self format: post) ]
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> implicitOperationBody: aViennaNode [
	^ String
		new: 1024
		streamContents: [ :stream | 
			aViennaNode first
				ifNotNil: [ :externals | 
					stream
						cr;
						nextPutAll: (self format: externals) ].
			aViennaNode second
				ifNotNil: [ :pre | 
					stream
						cr;
						nextPutAll: 'pre ';
						nextPutAll: (self format: pre) ].
			aViennaNode third
				ifNotNil: [ :post | 
					stream
						cr;
						nextPutAll: 'post ';
						nextPutAll: (self format: post) ]
				ifNil: [ String new ].
			aViennaNode fourth
				ifNotNil: [ :exceptions | 
					stream
						cr;
						nextPutAll: (self format: exceptions) ] ]
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> implicitOperationDefinition: aViennaNode [
	| identifier parameterTypes identifierTypePairList implicitOperationBody |
	identifier := aViennaNode first.
	parameterTypes := self format: aViennaNode second.
	identifierTypePairList := self format: aViennaNode third.
	implicitOperationBody := self format: aViennaNode fourth.
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream
				nextPutAll: identifier;
				nextPutAll: parameterTypes;
				nextPutAll: identifierTypePairList;
				nextPutAll: implicitOperationBody ]
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> imply [
	^ '=>'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> imply: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self imply arg: (self format: aViennaNode second)
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importDefinition: aViennaNode [
	| identifier moduleSignature |
	identifier := self format: aViennaNode first.
	moduleSignature := self format: aViennaNode second.
	^ self indentString: 'from ' , identifier insertCrIfNeeded: moduleSignature
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importDefinitionList: aViennaNode [
	| definitions |
	definitions := self formatAll: aViennaNode.
	^ self indentString: 'imports' insertCrIfNeeded: (',' , String cr join: definitions)
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importFunctionsSignature: aViennaNode [
	| functionImport |
	functionImport := self formatAll: aViennaNode.
	^ self indentString: 'functions' insertCrIfNeeded: (';' , String cr join: functionImport) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importModuleSignature: aViennaNode [
	| importSignatures |
	importSignatures := self formatAll: aViennaNode.
	^ String cr join: importSignatures
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importModuleSignatureAll: aViennaNode [
	^ 'all'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importOperationsSignature: aViennaNode [
	| operationImports |
	operationImports := self formatAll: aViennaNode.
	^ self indentString: 'operations' insertCrIfNeeded: (';' , String cr join: operationImports) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importTypesSignature: aViennaNode [
	| typeImports |
	typeImports := self formatAll: aViennaNode.
	^ self indentString: 'types' insertCrIfNeeded: (';' , String cr join: typeImports) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importValuesSignature: aViennaNode [
	| valueImports |
	valueImports := self formatAll: aViennaNode.
	^ self indentString: 'values' insertCrIfNeeded: (';' , String cr join: valueImports) , ';'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> inSet: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self inset arg: (self format: aViennaNode second)
]

{ #category : #accessing }
ViennaAbstractFormatter >> indent [
	^ indent
]

{ #category : #accessing }
ViennaAbstractFormatter >> indent: aString [
	indent := aString
]

{ #category : #private }
ViennaAbstractFormatter >> indentAllStrings: anArrayOfString [
	^ String cr , indent join: (anArrayOfString collect: [ :string | self indentString: string ])
]

{ #category : #private }
ViennaAbstractFormatter >> indentAllStrings: anArrayOfString withSeparator: separator [
	^ separator , String cr , indent join: (anArrayOfString collect: [ :string | self indentString: string ])
]

{ #category : #private }
ViennaAbstractFormatter >> indentAllStrings: anArrayOfString withTerminator: terminator [
	^ (self indentAllStrings: anArrayOfString withSeparator: terminator) , terminator
]

{ #category : #private }
ViennaAbstractFormatter >> indentString: aString [
	^ String cr , indent join: aString lines
]

{ #category : #private }
ViennaAbstractFormatter >> indentString: aString insertCr: anotherString [
	^ anotherString ifEmpty: [ aString ] ifNotEmpty: [ aString , String cr , indent , (self indentString: anotherString) ]
]

{ #category : #private }
ViennaAbstractFormatter >> indentString: aString insertCrIfNeeded: anotherString [
	^ anotherString
		ifEmpty: [ aString ]
		ifNotEmpty: [ 
			aString
				,
					((self needsIndent: aString , anotherString)
						ifTrue: [ String cr , indent , (self indentString: anotherString) ]
						ifFalse: [ String space , anotherString ]) ]
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> indexForLoop: aViennaNode [
	| identifier start end step statement |
	identifier := self format: aViennaNode first.
	start := self format: aViennaNode second.
	end := self format: aViennaNode third.
	step := aViennaNode fourth
		ifNotNil: [ :node | self indentString: 'by ' insertCrIfNeeded: (self format: node) ]
		ifNil: [ '' ].
	statement := self format: aViennaNode fifth.
	^ self
		noIndentString:
			(self
				noIndentString: (self indentString: 'for ' , identifier insertCrIfNeeded: '= ' , start)
				insertCrIfNeeded: (self noIndentString: (self indentString: 'to ' insertCrIfNeeded: end) insertCrIfNeeded: step))
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> initialisation: aViennaNode [
	^ 'init ' , (self format: aViennaNode first)
]

{ #category : #'initialize-release' }
ViennaAbstractFormatter >> initialize [
	super initialize.
	maxSizePerLine := self defaultMaxSizePerLine.
	indent := self defaultIndent
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> inmapInfix [
	^ 'to'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> inmapPrefix [
	^ 'inmap '
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> inmapType: aViennaNode [
	^ self inmapPrefix, (self format: aViennaNode first) , ' ' , self inmapInfix , ' ' , (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> inseq [
	^ 'in seq'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> inset [
	^ 'in set'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> int [
	^ 'int'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> inter [
	^ 'inter'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> interface: aViennaNode [
	| importDefinitionList exportDefinition |
	importDefinitionList := aViennaNode first ifNil: [ '' ] ifNotNil: [ (self format: aViennaNode first) , String cr ].
	exportDefinition := self format: aViennaNode second.
	^ importDefinitionList , exportDefinition
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> invariant: aViennaNode [
	^ 'inv ' , (self format: aViennaNode first)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> invariantInitialFunction: aViennaNode [
	| pattern expression |
	pattern := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: pattern , ' ==' insertCrIfNeeded: expression
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> inversePostfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> inversePrefix [
	^ 'inverse '
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> iota [
	^ 'iota'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> iotaExpression: aViennaNode [
	| bind expression |
	bind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: self iota , ' ' , bind , ' ' , self dot insertCrIfNeeded: expression
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> isBasicExpression: aViennaNode [
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
ViennaAbstractFormatter >> isNameExpression: aViennaNode [
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
ViennaAbstractFormatter >> isNotYetSpecified: aViennaNode [
	^ 'is not yet specified'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> isSubclassResponsibility: aViennaNode [
	^ 'is subclass responsibility'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> isofbaseclassExpression: aViennaNode [
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'isofbaseclass(' , cls , ',' insertCrIfNeeded: expression , ')'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> isofclassExpression: aViennaNode [
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'isofclass(' , cls , ',' insertCrIfNeeded: expression , ')'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> iterate [
	^ '**'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> iterate: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self iterate arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> lambda [
	^ 'lambda'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> lambdaExpression: aViennaNode [
	| typeBind expression |
	typeBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: self lambda , ' ' , typeBind , ' ' , self dot insertCrIfNeeded: expression
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> lessThan: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '<' arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> lessThanOrEqual [
	^ '<='
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> lessThanOrEqual: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self lessThanOrEqual arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> letBeExpression: aViennaNode [
	| multipleBind guard expression |
	multipleBind := self indentString: 'let' insertCrIfNeeded: (self format: aViennaNode first).
	guard := aViennaNode second
		ifNil: [ '' ]
		ifNotNil: [ :node | self indentString: 'be st' insertCrIfNeeded: (self format: node) ].
	expression := self indentString: 'in' insertCrIfNeeded: (self format: aViennaNode third).
	^ self noIndentString: (self noIndentString: multipleBind insertCrIfNeeded: guard) insertCrIfNeeded: expression
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> letBeStatement: aViennaNode [
	| multipleBind guard statement |
	multipleBind := self indentString: 'let' insertCrIfNeeded: (self format: aViennaNode first).
	guard := aViennaNode second
		ifNil: [ '' ]
		ifNotNil: [ :node | self indentString: 'be st' insertCrIfNeeded: (self format: node) ].
	statement := self indentString: 'in' insertCrIfNeeded: (self format: aViennaNode third).
	^ self noIndentString: (self noIndentString: multipleBind insertCrIfNeeded: guard) insertCrIfNeeded: statement
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> letExpression: aViennaNode [
	| localDefinitionList expression |
	localDefinitionList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'let' insertCrIfNeeded: localDefinitionList)
		insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: expression)
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> letStatement: aViennaNode [
	| localDefinitionList statement |
	localDefinitionList := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'let' insertCrIfNeeded: localDefinitionList)
		insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: statement)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> localDefinition: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> localDefinitionList: aViennaNode [
	| localDefinitions |
	localDefinitions := self formatAll: aViennaNode.
	^ (self anyNeedsIndent: localDefinitions)
		ifTrue: [ ',' , String cr join: localDefinitions ]
		ifFalse: [ ', ' join: localDefinitions ]
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> localName: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> logicalEquivalence: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self equiv arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapComprehension: aViennaNode [
	| keyExpression valueExpression bindList guard |
	keyExpression := self format: aViennaNode first.
	valueExpression := self format: aViennaNode second.
	bindList := self format: aViennaNode third.
	guard := aViennaNode fourth ifNil: [ '' ] ifNotNil: [ :node | self dot , ' ' , (self format: node) ].
	(self needsIndent: keyExpression , valueExpression , bindList , guard)
		ifFalse: [ ^ '{' , keyExpression , ' ' , self maplet , ' ' , valueExpression , ' | ' , bindList , guard , '}' ].
	^ '{'
		,
			(self
				noIndentString: (self noIndentString: keyExpression insertCrIfNeeded: self maplet , ' ' , valueExpression)
				insertCrIfNeeded: (self noIndentString: '| ' , bindList insertCrIfNeeded: guard)) , '}'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapDomain: aViennaNode [
	^ 'dom ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapDomainRestrictedBy: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self domainRestrictedBy arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapDomainRestrictedTo: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self domainRestrictedTo arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapEnumeration: aViennaNode [
	| elements |
	elements := self formatAll: aViennaNode.
	^ '{' , (self formatEnumerate: elements ifEmpty: [ self maplet ]) , '}'
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> mapEnumerationPattern: aViennaNode [
	^ '{' , (self formatEnumerate: (self formatAll: aViennaNode) ifEmpty: [ self maplet ]) , '}'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mapInfix [
	^ 'to'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapInverse: aViennaNode [
	^ self inversePrefix , (self format: aViennaNode first), self inversePostfix
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapMerge: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self munion arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> mapMunionPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self munion arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapOrSequenceModify: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self override arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapOrSequenceReference: aViennaNode [
	| ref arg |
	ref := self format: aViennaNode first.
	arg := self format: aViennaNode second.
	^ (self needsIndent: ref , arg)
		ifTrue: [ ref , String cr , indent , (self indentString: '(' , arg , ')') ]
		ifFalse: [ ref , '(' , arg , ')' ]
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mapPrefix [
	^ 'map '
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapRange: aViennaNode [
	^ 'rng ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapRangeRestrictedBy: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self rangeRestrictedBy arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapRangeRestrictedTo: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self rangeRestrictedTo arg: (self format: aViennaNode second)
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> mapType: aViennaNode [
	^ self mapPrefix, (self format: aViennaNode first) , ' ' , self mapInfix , ' ' , (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> maplet [
	^ '|->'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> maplet: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self maplet arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> mapletList: aViennaNode [
	| maplets |
	maplets := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: maplets)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: maplets
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> mapletPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self maplet arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> matchValue: aViennaNode [
	| value |
	value := self format: aViennaNode first.
	^ aViennaNode first label = 'SymbolicLiteral'
		ifTrue: [ value ]
		ifFalse: [ '(' , value , ')' ]
]

{ #category : #accessing }
ViennaAbstractFormatter >> maxSizePerLine [
	^ maxSizePerLine
]

{ #category : #accessing }
ViennaAbstractFormatter >> maxSizePerLine: anInteger [
	maxSizePerLine := anInteger
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> module: aViennaNode [
	| identifier interface moduleBody |
	identifier := self format: aViennaNode first.
	interface := self format: aViennaNode second.
	moduleBody := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | String cr , (self format: node) ].
	^ 'module ' , identifier , String cr , interface , moduleBody , String cr , 'end ' , identifier
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> moduleBody: aViennaNode [
	| definitionBlocks |
	definitionBlocks := self formatAll: aViennaNode.
	^ 'definitions' , String cr , (String cr join: definitionBlocks)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mu [
	^ 'mu'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mul [
	^ ' *'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> multipleAssignStatement: aViennaNode [
	| statements |
	statements := self formatAll: aViennaNode.
	^ 'atomic('
		,
			((self anyNeedsIndent: statements)
				ifTrue: [ ';' , String cr , indent join: (statements collect: [ :statement | self indentString: statement ]) ]
				ifFalse: [ '; ' join: statements ]) , ')'
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> multipleSeqBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self inseq arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> multipleSetBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self inset arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> multipleTypeBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: ':' arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> munion [
	^ 'munion'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> nameList: aViennaNode [
	| names |
	names := self formatAll: aViennaNode.
	^ ', ' join: names
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> nat [
	^ 'nat'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> nat1 [
	^ 'nat1'
]

{ #category : #private }
ViennaAbstractFormatter >> needsIndent: aString [
	^ (aString includes: Character cr) or: [ (self strlen: aString) > self maxSizePerLine ]
]

{ #category : #private }
ViennaAbstractFormatter >> needsParen [
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
		at: parentNode label asString
		ifPresent: [ :grouping | 
			(grouping = #left and: [ parentNode first ~= childNode ])
				or: [ grouping = #right and: [ parentNode second ~= childNode ] ] ]
		ifAbsent: [ true ]
]

{ #category : #private }
ViennaAbstractFormatter >> newlineIndentAllStrings: anArrayOfString [
	^ String new join: (anArrayOfString collect: [ :string | self newlineIndentString: string ])
]

{ #category : #private }
ViennaAbstractFormatter >> newlineIndentString: aString [
	^ String cr , indent , (self indentString: aString)
]

{ #category : #private }
ViennaAbstractFormatter >> noIndentString: aString insertCrIfNeeded: anotherString [
	^ anotherString
		ifEmpty: [ aString ]
		ifNotEmpty: [ 
			aString
				,
					((self needsIndent: aString , anotherString)
						ifTrue: [ String cr ]
						ifFalse: [ String space ]) , anotherString ]
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> nondeterministicStatement: aViennaNode [
	| statements |
	statements := self formatAll: aViennaNode.
	^ '||('
		,
			((self anyNeedsIndent: statements)
				ifTrue: [ ',' , String cr , indent join: (statements collect: [ :statement | self indentString: statement ]) ]
				ifFalse: [ ', ' join: statements ]) , ')'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> not [
	^ 'not'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> not: aViennaNode [
	^ self not , ' ' , (self format: aViennaNode first)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> notEqual [
	^ '<>'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> notEqual: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self notEqual arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> notInSet [
	^ 'not in set'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> notInSet: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self notInSet arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> objectPattern: aViennaNode [
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
ViennaAbstractFormatter >> oldName: aViennaNode [
	^ (self format: aViennaNode first) , '~'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> oparrow [
	^ '==>'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> operationBody: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> operationDefinition: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> operationDefinitions: aViennaNode [
	^ self
		indentString: 'operations'
		insertCr: (';' , String cr , String cr join: (self formatAll: aViennaNode)) , ';' , String cr
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> operationImport: aViennaNode [
	| name operationType rename |
	name := self format: aViennaNode first.
	operationType := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ': ' , (self format: node) ].
	rename := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: name , operationType insertCrIfNeeded: rename
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> operationSignature: aViennaNode [
	| name operationType |
	name := self format: aViennaNode first.
	operationType := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ' : ' , (self format: node) ].
	^ name , operationType
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> operationType: aViennaNode [
	^ (self format: aViennaNode first) , ' ' , self oparrow , ' ' , (self format: aViennaNode second)
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> operationsSignature: aViennaNode [
	| signatures |
	signatures := self formatAll: aViennaNode.
	^ self indentString: 'operations' insertCrIfNeeded: (';' , String cr join: signatures) , ';'
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> optionalType: aViennaNode [
	^ '[' , (self format: aViennaNode first) , ']'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> or [
	^ 'or'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> or: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self or arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> othersExpression: aViennaNode [
	| expression |
	expression := self format: aViennaNode first.
	^ self indentString: 'others ->' insertCrIfNeeded: expression
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> othersStatement: aViennaNode [
	| statement |
	statement := self format: aViennaNode first.
	^ self indentString: 'others ', self arrow insertCrIfNeeded: statement
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> override [
	^ '++'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> parameterTypes: aViennaNode [
	^ '('
		,
			(aViennaNode first
				ifNil: [ '' ]
				ifNotNil: [ :node | self format: node ]) , ')'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> parameters: aViennaNode [
	^ '(' , (', ' join: (self formatAll: aViennaNode)) , ')'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> parametersList: aViennaNode [
	^ '' join: (self formatAll: aViennaNode)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> partialFunction [
	^ '->'
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> partialFunctionType: aViennaNode [
	^ (self format: aViennaNode first) , ' ' , self partialFunction , ' ' , (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> patternIdentifier: aViennaNode [
	^ aViennaNode first ifNil: ['-'] ifNotNil: [:identifier | self format:identifier]
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> patternList: aViennaNode [
	| patterns |
	patterns := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: patterns)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: patterns
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> patternTypePairList: aViennaNode [
	^ String
		new: 1024
		streamContents: [ :stream | 
			aViennaNode
				ifNotEmpty: [ 1 to: aViennaNode size - 2 by: 2 do: [ :index | 
						stream
							nextPutAll: (self format: (aViennaNode at: index));
							nextPutAll: ':';
							nextPutAll: (self format: (aViennaNode at: index + 1));
							nextPutAll: ', ' ].
					stream
						nextPutAll: (self format: (aViennaNode at: aViennaNode size - 1));
						nextPutAll: ':';
						nextPutAll: (self format: (aViennaNode at: aViennaNode size)) ] ]
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> power [
	^ 'power'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> preconditionExpression: aViennaNode [
	| expressions |
	expressions := self formatAll: aViennaNode.
	^ 'pre_('
		,
			((self anyNeedsIndent: expressions)
				ifTrue: [ ',' , String cr , indent join: (expressions collect: [ :expression | self indentString: expression ]) ]
				ifFalse: [ ', ' join: expressions ]) , ')'
]

{ #category : #private }
ViennaAbstractFormatter >> print: argString1 infix: opString arg: argString2 [
	^ (self needsIndent: argString1 , argString2)
		ifTrue: [ argString1 , String cr , opString , String space , argString2 ]
		ifFalse: [ argString1 , String space , opString , String space , argString2 ]
]

{ #category : #private }
ViennaAbstractFormatter >> print: aString withChildren: anArrayOfString [
	^ (self anyNeedsIndent: (anArrayOfString copyWith: aString))
		ifTrue: [ aString , (self newlineIndentAllStrings: anArrayOfString) ]
		ifFalse: [ aString , String space , (String space join: anArrayOfString) ]
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> productType: aViennaNode [
	^ self formatEnumerate: (self formatAll: aViennaNode) separator: self mul ifEmpty: [ '' ]
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> properSubset: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self psubset arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> psubset [
	^ 'psubset'
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> quoteType: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> rangeRestrictedBy [
	^ ':->'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> rangeRestrictedTo [
	^ ':>'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> real [
	^ 'real'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> recordConstructor: aViennaNode [
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
ViennaAbstractFormatter >> recordModifier: aViennaNode [
	| record mapletList |
	record := self format: aViennaNode first.
	mapletList := self format: aViennaNode second.
	^ self mu , '(' , record , ','
		,
			((self needsIndent: record , mapletList)
				ifTrue: [ String cr , indent , (self indentString: mapletList) ]
				ifFalse: [ mapletList ]) , ')'
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> recordPattern: aViennaNode [
	| constructor patternList |
	constructor := self format: aViennaNode first.
	patternList := self format: aViennaNode second.
	^ 'mk_' , constructor , '('
		,
			((self needsIndent: constructor , patternList)
				ifTrue: [ String cr , indent , (self indentString: patternList) ]
				ifFalse: [ patternList ]) , ')'
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> recordTypeDefinition: aViennaNode [
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
ViennaAbstractFormatter >> reqExpression: aViennaNode [
	^ '#req(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> resultExpression: aViennaNode [
	^ 'RESULT'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> returnStatement: aViennaNode [
	^ 'return '
		, (aViennaNode first ifNil: [ '' ] ifNotNil: [ :arg | self indentString: (self format: arg) ])
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> samebaseclassExpression: aViennaNode [
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'samebaseclass(' , cls , ',' insertCrIfNeeded: expression , ')'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sameclassExpression: aViennaNode [
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'sameclass(' , cls , ',' insertCrIfNeeded: expression , ')'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> selfExpression: aViennaNode [
	^ 'self'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> seq1Postfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> seq1Prefix [
	^ 'seq1 of '
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> seq1Type: aViennaNode [
	^ self seq1Prefix, (self format: aViennaNode first) , self seq1Postfix
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> seqBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self inseq arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> seqConcPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self concat arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> seqEnumPattern: aViennaNode [
	^ '[' , (self formatEnumerate: (self formatAll: aViennaNode) ifEmpty: [ '' ]) , ']'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> seqPostfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> seqPrefix [
	^ 'seq of '
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> seqType: aViennaNode [
	^ self seqPrefix, (self format: aViennaNode first) , self seqPostfix
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceComprehension: aViennaNode [
	| expression setBind guard |
	expression := self format: aViennaNode first.
	setBind := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ :node | self dot , ' ' , (self format: node) ] ifNil: [ '' ].
	^ '[' , (self indentString: expression insertCrIfNeeded: (self indentString: '| ' , setBind insertCrIfNeeded: guard))
		, ']'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceConcatenate: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self concat arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceElements: aViennaNode [
	^ 'elems ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceEnumeration: aViennaNode [
	| elements |
	elements := self formatAll: aViennaNode first.
	^ '[' , (self formatEnumerate: elements ifEmpty: [ '' ]) , ']'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> sequenceForLoop: aViennaNode [
	| patternBind expression statement |
	patternBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	^ self
		noIndentString:
			(self
				noIndentString: (self indentString: 'for' insertCrIfNeeded: patternBind)
				insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: expression))
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceHead: aViennaNode [
	^ 'hd ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceIndices: aViennaNode [
	^ 'inds ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceLength: aViennaNode [
	^ 'len ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceReverse: aViennaNode [
	^ 'reverse ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> sequenceTail: aViennaNode [
	^ 'tl ' , (self format: aViennaNode first)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> set1Postfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> set1Prefix [
	^ 'set1 of '
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> set1Type: aViennaNode [
	^ self set1Prefix, (self format: aViennaNode first) , self set1Postfix
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> setBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self inset arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> setCardinality: aViennaNode [
	^ self print: 'card' withChildren: (self formatAll: aViennaNode)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> setComprehension: aViennaNode [
	| expression bindList guard |
	expression := self format: aViennaNode first.
	bindList := self format: aViennaNode second.
	guard := aViennaNode third ifNotNil: [ :node | self dot , ' ' , (self format: node) ] ifNil: [ '' ].
	^ '{' , (self indentString: (self indentString: expression insertCrIfNeeded: '| ' , bindList) insertCrIfNeeded: guard)
		, '}'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setDifference [
	^ '\'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> setDifference: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self setDifference arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> setEnumPattern: aViennaNode [
	^ '{' , (self formatEnumerate: (self formatAll: aViennaNode) ifEmpty: [ '' ]) , '}'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> setEnumeration: aViennaNode [
	| elements |
	elements := self formatAll: aViennaNode first.
	^ '{' , (self formatEnumerate: elements ifEmpty: [ '' ]) , '}'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> setForLoop: aViennaNode [
	| pattern expression statement |
	pattern := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	(self needsIndent: pattern , expression , statement)
		ifFalse: [ ^ 'for all ' , pattern , ' ', self inset, ' ' , expression , ' do ' , statement ].
	(self needsIndent: pattern , expression)
		ifFalse: [ ^ 'for all ' , pattern , ' in set ' , expression , ' do' , String cr , indent , (self indentString: statement) ].
	^ self
		noIndentString:
			(self
				noIndentString: (self indentString: 'for all' insertCrIfNeeded: pattern)
				insertCrIfNeeded: (self indentString: 'in set' insertCrIfNeeded: expression))
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> setIntersection: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self inter arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setPostfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setPrefix [
	^ 'set of '
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> setRangeExpression: aViennaNode [
	| start end |
	start := self format: aViennaNode first.
	end := self format: aViennaNode second.
	^ self noIndentString: '{' , start , ',' insertCrIfNeeded: self dots , ', ' , end , '}'
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> setType: aViennaNode [
	^ self setPrefix, (self format: aViennaNode first) , self setPostfix
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> setUnion: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self union arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> setUnionPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self union arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> space [
	^ ' '
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> stateDefinition: aViennaNode [
	| identifier stateFieldList invariant initialisation |
	identifier := self format: aViennaNode first.
	stateFieldList := String cr join: (self formatAll: aViennaNode second).
	invariant := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | String cr , (self format: node) ].
	initialisation := aViennaNode fourth ifNil: [ '' ] ifNotNil: [ :node | String cr , (self format: node) ].
	^ 'state ' , identifier , ' of' , String cr , indent , (self indentString: stateFieldList) , invariant , initialisation
		, String cr , 'end'
]

{ #category : #private }
ViennaAbstractFormatter >> strlen: aString [
	^ aString
		inject: 0
		into: [ :len :char | 
			len
				+
					(char charCode < 256
						ifTrue: [ 1 ]
						ifFalse: [ 2 ]) ]
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> subsequence: aViennaNode [
	| sequence start end |
	sequence := self format: aViennaNode first.
	start := self format: aViennaNode second.
	end := self format: aViennaNode third.
	(self needsIndent: sequence , start , end)
		ifFalse: [ ^ sequence , '(' , start , ',' , self dots , ',' , end , ')' ].
	(self needsIndent: start , end)
		ifFalse: [ ^ sequence , '(' , String cr , indent , (self indentString: start , ',' , self dots , ', ' , end , ')') ].
	^ sequence , '(' , String cr , indent
		, ((self indentString: start , ',') , String cr , indent , self dots , ', ' , (self indentString: end , ')'))
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> subset [
	^ 'subset'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> subset: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self subset arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> symbolicLiteral: aViennaNode [
	| literal |
	literal := aViennaNode first trim.
	^ literal
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> threadidExpression: aViennaNode [
	^ 'threadid'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> timeExpression: aViennaNode [
	^ 'time'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> tixeStatement: aViennaNode [
	| traps statement |
	traps := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ (self needsIndent: traps)
		ifTrue: [ (self indentString: 'tixe' insertCr: traps) , String cr
				, (self indentString: 'in' insertCr: statement) ]
		ifFalse: [ self indentString: 'tixe ' , traps , ' in' insertCrIfNeeded: statement ]
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> tokenConstructor: aViennaNode [
	| expression |
	expression := self format: aViennaNode first.
	^ 'mk_token('
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ expression ]) , ')'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> totalFunction [
	^ '+>'
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> totalFunctionType: aViennaNode [
	^ (self format: aViennaNode first) , ' ' , self totalFunction , ' ' , (self format: aViennaNode second)
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> trapStatement: aViennaNode [
	| pattern handler statement |
	pattern := self format: aViennaNode first.
	handler := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	^ (self needsIndent: pattern)
		ifTrue: [ (self indentString: 'trap' insertCr: pattern) , String cr
				, (self indentString: 'with' insertCr: handler) , String cr
				, (self indentString: 'in' insertCr: statement) ]
		ifFalse: [ | trap |
			trap := 'trap ' , pattern.
			(self needsIndent: trap , handler)
				ifTrue: [ trap , String cr , (self indentString: 'with' insertCr: handler) , String cr
						, (self indentString: 'in' insertCr: statement) ]
				ifFalse: [ trap := trap , ' with ' , handler.
					(self needsIndent: trap , statement)
						ifTrue: [ trap , String cr , (self indentString: 'in' insertCr: statement) ]
						ifFalse: [ trap , ' in ' , statement ] ] ]
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> traps: aViennaNode [
	^ String
		new: 1024
		streamContents: [ :stream | 
			stream nextPutAll: '{'.
			aViennaNode
				ifNotEmpty: [ stream
						nextPutAll:
							(',' , String cr
								join:
									((1 to: aViennaNode size by: 2)
										collect: [ :index | 
											(self format: (aViennaNode at: index)) , ' |-> '
												, (self indentString: (self format: (aViennaNode at: index + 1))) ])) ].
			stream nextPutAll: '}' ]
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> tupleConstructor: aViennaNode [
	| expressionList |
	expressionList := self format: aViennaNode first.
	^ 'mk_('
		,
			((self needsIndent: expressionList)
				ifTrue: [ String cr , indent , (self indentString: expressionList) ]
				ifFalse: [ expressionList ]) , ')'
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> tuplePattern: aViennaNode [
	| patternList |
	patternList := self format: aViennaNode first.
	^ 'mk_('
		,
			((self needsIndent: patternList)
				ifTrue: [ String cr , indent , (self indentString: patternList) ]
				ifFalse: [ patternList ]) , ')'
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> tupleSelect: aViennaNode [
	| tuple int |
	tuple := self format: aViennaNode first.
	int := self format: aViennaNode second.
	^ self print: tuple infix: '.#' arg: int
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> typeBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: ':' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> typeBindList: aViennaNode [
	| patterns |
	patterns := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: patterns)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: patterns
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> typeDefinition: aViennaNode [
	| typeName baseType invariant |
	typeName := self format: aViennaNode first.
	baseType := self format: aViennaNode second.
	invariant := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | self format: node ].
	^ self indentString: (self indentString: typeName , ' =' insertCrIfNeeded: baseType) insertCrIfNeeded: invariant
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> typeDefinitions: aViennaNode [
	^ self indentString: 'types' insertCr: (';' , String cr join: (self formatAll: aViennaNode)) , ';' , String cr
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> typeImport: aViennaNode [
	| type rename |
	type := self format: aViennaNode first.
	rename := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: type insertCrIfNeeded: rename
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> typeJudgement: aViennaNode [
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
ViennaAbstractFormatter >> typeName: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> typeNameExport: aViennaNode [
	| name |
	name := self format: aViennaNode first.
	^ name
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> typeStructExport: aViennaNode [
	| name |
	name := self format: aViennaNode first.
	^ 'struct ' , name
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> typeVariable: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> typeVariableIdentifier: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> typeVariableList: aViennaNode [
	^ aViennaNode size > 0
		ifTrue: [ '[' , (String space join: (self formatAll: aViennaNode)) , ']' ]
		ifFalse: [ '' ]
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> unaryMinus: aViennaNode [
	^ '-' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> unaryPlus: aViennaNode [
	^ '+' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> undefinedExpression: aViennaNode [
	^ 'undefined'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> union [
	^ 'union'
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> unionType: aViennaNode [
	^ self formatEnumerate: (self formatAll: aViennaNode) separator: '|' ifEmpty: [ '' ]
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> unitType: aViennaNode [
	^ '()'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> valueDefinition: aViennaNode [
	| identifier type expression |
	identifier := self format: aViennaNode first.
	type := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ' : ' , (self format: node) ].
	expression := self format: aViennaNode third.
	^ self indentString: identifier , type , ' =' insertCrIfNeeded: expression
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> valueDefinitions: aViennaNode [
	^ self indentString: 'values' insertCr: (';' , String cr join: (self formatAll: aViennaNode)) , ';' , String cr
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> valueImport: aViennaNode [
	| name type rename |
	name := self format: aViennaNode first.
	type := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ': ' , (self format: node) ].
	rename := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: name , type insertCrIfNeeded: rename
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> valueSignature: aViennaNode [
	| nameList type |
	nameList := self format: aViennaNode first.
	type := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ' : ' , (self format: node) ].
	^ nameList , type
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> valuesSignature: aViennaNode [
	| signatures |
	signatures := self formatAll: aViennaNode.
	^ self indentString: 'values' insertCrIfNeeded: (';' , String cr join: signatures) , ';'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> varInformation: aViennaNode [
	| mode nameList type |
	mode := aViennaNode first.
	nameList := self format: aViennaNode second.
	type := aViennaNode third
		ifNotNil: [ :node | ':' , (self format: node) ]
		ifNil: [ String new ].
	^ mode , ' ' , nameList , type
]

{ #category : #'formatting-expressions' }
ViennaAbstractFormatter >> waitingExpression: aViennaNode [
	^ '#waiting(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> whileLoop: aViennaNode [
	| expression statement |
	expression := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'while' insertCrIfNeeded: expression)
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)
]
