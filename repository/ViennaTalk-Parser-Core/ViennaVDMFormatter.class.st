Class {
	#name : #ViennaVDMFormatter,
	#superclass : #Object,
	#instVars : [
		'maxSizePerLine',
		'indent'
	],
	#classVars : [
		'OperatorPrecedence'
	],
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'class initialization' }
ViennaVDMFormatter class >> initialize [
	super initialize.
	self initializeOperatorPrecedence
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
		at: 'Not' put: 15;
		at: 'And' put: 14;
		at: 'Or' put: 13;
		at: 'Imply' put: 12;
		at: 'LogicalEquivalence' put: 11;
		yourself
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> access: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> accessFunctionDefinition: aViennaNode [
	^ ' ' join: (self formatAll: aViennaNode)
]

{ #category : #'formatting-definitions' }
ViennaVDMFormatter >> accessOperationDefinition: aViennaNode [
	^ ' ' join: (self formatAll: aViennaNode)
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
	^ (self print: (self format: aViennaNode first) , '(' withChildren: {self format: aViennaNode second}) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticAbs: aViennaNode [
	^ 'abs ' , (self format: aViennaNode first)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> arithmeticIntegerDivision: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: 'div' arg: (self format: aViennaNode second)
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

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> finExpression: aViennaNode [
	^ '#fin(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #formatting }
ViennaVDMFormatter >> format: aViennaNode [
	aViennaNode isString
		ifTrue: [ ^ aViennaNode ].
	^ self perform: (aViennaNode label uncapitalized , ':') asSymbol with: aViennaNode
]

{ #category : #formatting }
ViennaVDMFormatter >> formatAll: aViennaNodeOrArray [
	| array |
	array := Array new: aViennaNodeOrArray size.
	1 to: array size do: [ :i | array at: i put: (self format: (aViennaNodeOrArray at: i)) ].
	^ array
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

{ #category : #'initialize-release' }
ViennaVDMFormatter >> initialize [
	super initialize.
	maxSizePerLine := self defaultMaxSizePerLine.
	indent := self defaultIndent
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
ViennaVDMFormatter >> mapDomain: aViennaNode [
	^ 'dom ' , (self format: aViennaNode first)
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
ViennaVDMFormatter >> newlineIndentAllStrings: anArrayOfString [
	^ String new join: (anArrayOfString collect: [ :string | self newlineIndentString: string ])
]

{ #category : #private }
ViennaVDMFormatter >> newlineIndentString: aString [
	^ String cr , indent , (self indentString: aString)
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

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> patternIdentifier: aViennaNode [
	^ self format: aViennaNode first
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

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> reqExpression: aViennaNode [
	^ '#req(' , ', ' join: (self formatAll: aViennaNode) , ')'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceConcatenate: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '^' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> sequenceElements: aViennaNode [
	^ 'elems ' , (self format: aViennaNode first)
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
ViennaVDMFormatter >> setDifference: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: '\' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> setEnumeration: aViennaNode [
	^ '{' , (self format: aViennaNode first) , '}'
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> symbolicLiteral: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-patterns and binds' }
ViennaVDMFormatter >> typeBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: ':' arg: (self format: aViennaNode second)
]

{ #category : #'formatting-expressions' }
ViennaVDMFormatter >> waitingExpression: aViennaNode [
	^ '#waiting(' , ', ' join: (self formatAll: aViennaNode) , ')'
]
