Class {
	#name : #ViennaAbstractFormatter,
	#superclass : #Object,
	#instVars : [
		'maxSizePerLine',
		'indent'
	],
	#classVars : [
		'DefaultMaxSizePerLine'
	],
	#category : #'ViennaTalk-Parser-Formatters'
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
	ast isPetit2Failure
		ifTrue: [ ^ errorBlock value ].
	^ self format: ast
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> and [
	^ 'and'
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> arrow [
	^ '->'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> bool [
	^ 'bool'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> concat [
	^ '^'
]

{ #category : #defaults }
ViennaAbstractFormatter >> defaultIndent [
	^ '    '
]

{ #category : #defaults }
ViennaAbstractFormatter >> defaultMaxSizePerLine [
	^ self class defaultMaxSizePerLine
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> dinter [
	^ 'dinter'
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> equiv [
	^ '<=>'
]

{ #category : #private }
ViennaAbstractFormatter >> escapeString: aString [
	^ aString
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> exists [
	^ 'exists'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> exists1 [
	^ 'exists1'
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
	^ (self format: identifier) , (self format: typeVariableList)
		, (self format: parameterTypes)
		, (self format: identifierTypePairList) , ' ==' , String cr , indent
		, (self indentString: (self format: body))
		,
			(pre
				ifNotNil: [ String cr , 'pre ' , (self format: pre) ]
				ifNil: [ '' ]) , String cr , 'post ' , (self format: post)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> extendedExplicitOperationDefinition: aViennaNode [
	| identifier parameterTypes identifierTypePairList body externals pre post exceptions string |
	identifier := aViennaNode first.
	parameterTypes := aViennaNode second.
	identifierTypePairList := aViennaNode third.
	body := aViennaNode fourth.
	externals := aViennaNode fifth.
	pre := aViennaNode sixth.
	post := aViennaNode seventh.
	exceptions := aViennaNode eighth.
	string := (self format: identifier) , (self format: parameterTypes)
		, (self format: identifierTypePairList) , ' ==' , String cr , indent
		, (self indentString: (self format: body)).
	externals
		ifNotNil: [ string := string , String cr , (self format: externals) ].
	pre
		ifNotNil:
			[ string := string , String cr , 'pre ' , (self format: pre) ].
	string := string , String cr , 'post ' , (self format: post).
	exceptions
		ifNotNil:
			[ string := string , String cr , (self format: exceptions) ].
	^ string
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> forall [
	^ 'forall'
]

{ #category : #formatting }
ViennaAbstractFormatter >> format: aViennaNode [

	| string |
	aViennaNode isString ifTrue: [ ^ aViennaNode ].
	string := (aViennaNode annotations
		           ifNil: [ '' ]
		           ifNotNil: [ :annotations |
			           String streamContents: [ :stream |
				           annotations do: [ :annotation |
					           stream
						           nextPutAll: '--@';
						           nextPutAll: annotation;
						           nextPutAll: String cr ] ] ])
	          , ([ aViennaNode formatWith: self ]
			           on: SubclassResponsibility
			           do: [ :ex |
				           self
					           perform:
					           (aViennaNode label uncapitalized , ':') asSymbol
					           with: aViennaNode ]).
	(self needsParen: aViennaNode) ifTrue: [
		string := '(' , (self indentString: string) , ')' ].
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
				ifTrue: [ stream nextPut: line.
					line := '' ].
			2 to: anArrayOfString size do: [ :index | 
				| element |
				element := anArrayOfString at: index.
				(self needsIndent: element)
					ifTrue: [ line ifNotEmpty: [ stream nextPut: line ].
						stream nextPut: element.
						line := '' ]
					ifFalse: [ | origLine |
						origLine := line.
						line := line , (line ifNotEmpty: [ aString , String space ])
							, element.
						(self needsIndent: line)
							ifTrue: [ origLine
									ifEmpty: [ stream nextPut: line.
										line := '' ]
									ifNotEmpty: [ stream nextPut: origLine.
										line := element ] ] ] ].
			line ifNotEmpty: [ stream nextPut: line ] ].
	^ self join: aString , String cr withAll: lines
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> functionDefinition: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> functionDefinitions: aViennaNode [

	^ self indentString: 'functions' insertCr: (self
			   join: ';' , String cr , String cr
			   withAll: (self formatAll: aViennaNode)) , (aViennaNode isEmpty
			   ifTrue: [ '' ]
			   ifFalse: [ ';' , String cr ])
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> greaterThanOrEqual [
	^ '>='
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> identifierTypePairList: aViennaNode [
	^ aViennaNode
		ifNotEmpty: [ | string |
			string := ''.
			1 to: aViennaNode size - 2 by: 2 do: [ :index | 
				string := string , (self format: (aViennaNode at: index)) , ':'
					, (self format: (aViennaNode at: index + 1)) , ', ' ].
			string , (self format: (aViennaNode at: aViennaNode size - 1))
				, ':' , (self format: (aViennaNode at: aViennaNode size)) ]
		ifEmpty: [ '' ]
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
	^ (self format: identifier) , (self format: typeVariableList)
		, (self format: parameterTypes)
		, (self format: identifierTypePairList)
		,
			(pre
				ifNotNil: [ String cr , 'pre ' , (self format: pre) ]
				ifNil: [ String new ]) , String cr , 'post ' , (self format: post)
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> implicitOperationBody: aViennaNode [
	^ (aViennaNode first
		ifNotNil:
			[ :externals | String cr , (self format: externals) ]
		ifNil: [ '' ])
		,
			(aViennaNode second
				ifNotNil:
					[ :pre | String cr , 'pre ' , (self format: pre) ]
				ifNil: [ '' ])
		,
			(aViennaNode third
				ifNotNil:
					[ :post | String cr , 'post ' , (self format: post) ]
				ifNil: [ '' ])
		,
			(aViennaNode fourth
				ifNotNil:
					[ :exceptions | String cr , (self format: exceptions) ]
				ifNil: [ '' ])
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> implicitOperationDefinition: aViennaNode [
	| identifier parameterTypes identifierTypePairList implicitOperationBody |
	identifier := aViennaNode first.
	parameterTypes := self format: aViennaNode second.
	identifierTypePairList := self format: aViennaNode third.
	implicitOperationBody := self format: aViennaNode fourth.
	^ identifier , parameterTypes , identifierTypePairList
		, implicitOperationBody
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> imply [
	^ '=>'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importFunctionsSignature: aViennaNode [
	| functionImport |
	functionImport := self formatAll: aViennaNode.
	^ self
		indentString: 'functions'
		insertCrIfNeeded: (self join: ';' , String cr withAll: functionImport) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importOperationsSignature: aViennaNode [
	| operationImports |
	operationImports := self formatAll: aViennaNode.
	^ self
		indentString: 'operations'
		insertCrIfNeeded: (self join: ';' , String cr withAll: operationImports) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importTypesSignature: aViennaNode [
	| typeImports |
	typeImports := self formatAll: aViennaNode.
	^ self
		indentString: 'types'
		insertCrIfNeeded: (self join: ';' , String cr withAll: typeImports) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importValuesSignature: aViennaNode [
	| valueImports |
	valueImports := self formatAll: aViennaNode.
	^ self
		indentString: 'values'
		insertCrIfNeeded: (self join: ';' , String cr withAll: valueImports) , ';'
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
	^ self
		join: String cr , indent
		withAll: (anArrayOfString collect: [ :string | self indentString: string ])
]

{ #category : #private }
ViennaAbstractFormatter >> indentAllStrings: anArrayOfString withSeparator: separator [
	^ self
		join: separator , String cr , indent
		withAll: (anArrayOfString collect: [ :string | self indentString: string ])
]

{ #category : #private }
ViennaAbstractFormatter >> indentAllStrings: anArrayOfString withTerminator: terminator [
	^ (self indentAllStrings: anArrayOfString withSeparator: terminator) , terminator
]

{ #category : #private }
ViennaAbstractFormatter >> indentString: aString [
	^ self join: String cr , indent withAll: aString lines
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> inverse: aString [
	^ 'inverse ', aString
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> iota [
	^ 'iota'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> iterate [
	^ '**'
]

{ #category : #private }
ViennaAbstractFormatter >> join: aString withAll: aCollectionOfString [
	^ aString join: aCollectionOfString
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> lambda [
	^ 'lambda'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> lessThanOrEqual [
	^ '<='
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mapInfix [
	^ 'to'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mapPrefix [
	^ 'map '
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> maplet [
	^ '|->'
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mu [
	^ 'mu'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mul [
	^ '*'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> munion [
	^ 'munion'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> nameList: aViennaNode [
	| names |
	names := self formatAll: aViennaNode.
	^ self join: ', ' withAll: names
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
	[ childContext notNil and: [ childContext selector ~= #format: ] ]
		whileTrue: [ childContext := childContext sender ].
	childContext ifNil: [ ^ false ].
	childNode := childContext arguments first.
	childPrecedence := childNode operatorPrecedence.
	childPrecedence = 0 ifTrue: [ ^ false ].
	parentContext := childContext sender.
	[ parentContext notNil and: [ parentContext selector ~= #format: ] ]
		whileTrue: [ parentContext := parentContext sender ].
	parentContext ifNil: [ ^ false ].
	parentNode := parentContext arguments first.
	parentPrecedence := parentNode operatorPrecedence.
	parentPrecedence = 0 ifTrue: [ ^ false ].
	childPrecedence < parentPrecedence ifTrue: [ ^ true ].
	parentPrecedence < childPrecedence ifTrue: [ ^ false ].
	^ parentNode
		  ifAssociatesLeftDo: [ parentNode first ~= childNode ]
		  ifAssociatesRightDo: [ parentNode second ~= childNode ]
		  otherwise: [ true ]
]

{ #category : #private }
ViennaAbstractFormatter >> needsParen: aViennaNode [

	| precedence parentPrecedence |
	precedence := aViennaNode operatorPrecedence.
	precedence = 0 ifTrue: [ ^ false ].
	parentPrecedence := aViennaNode parent
		                    ifNotNil: #operatorPrecedence
		                    ifNil: [ 0 ].
	parentPrecedence = 0 ifTrue: [ ^ false ].
	precedence < parentPrecedence ifTrue: [ ^ true ].
	parentPrecedence < precedence ifTrue: [ ^ false ].
	^ aViennaNode parent
		  ifAssociatesLeftDo: [ aViennaNode parent first ~= aViennaNode ]
		  ifAssociatesRightDo: [ aViennaNode parent second ~= aViennaNode ]
		  otherwise: [ true ]
]

{ #category : #private }
ViennaAbstractFormatter >> newlineIndentAllStrings: anArrayOfString [
	^ self
		join: String new
		withAll:
			(anArrayOfString
				collect: [ :string | self newlineIndentString: string ])
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> not [
	^ 'not'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> notEqual [
	^ '<>'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> notInSet [
	^ 'not in set'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> oparrow [
	^ '==>'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> operationDefinition: aViennaNode [
	^ self format: aViennaNode first
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> operationDefinitions: aViennaNode [

	^ self indentString: 'operations' insertCr: (self
			   join: ';' , String cr , String cr
			   withAll: (self formatAll: aViennaNode)) , (aViennaNode isEmpty
			   ifTrue: [ '' ]
			   ifFalse: [ ';' , String cr ])
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> operationImport: aViennaNode [
	| name operationType rename |
	name := self format: aViennaNode first.
	operationType := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ': ' , (self format: node) ].
	rename := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: name , operationType insertCrIfNeeded: rename
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> or [
	^ 'or'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> override [
	^ '++'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> partialFunction [
	^ '->'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> power [
	^ 'power'
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
		ifFalse: [ aString , String space
				, (self join: String space withAll: anArrayOfString) ]
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> psubset [
	^ 'psubset'
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> seq1Postfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> seq1Prefix [
	^ 'seq1 of '
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> seqPostfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> seqPrefix [
	^ 'seq of '
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> set1Postfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> set1Prefix [
	^ 'set1 of '
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setDifference [
	^ '\'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setPostfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setPrefix [
	^ 'set of '
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> space [
	^ ' '
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> stateDefinition: aViennaNode [
	| identifier stateFieldList invariant initialisation |
	identifier := self format: aViennaNode first.
	stateFieldList := self
		join: String cr
		withAll: (self formatAll: aViennaNode second).
	invariant := aViennaNode third
		ifNil: [ '' ]
		ifNotNil: [ :node | String cr , (self format: node) ].
	initialisation := aViennaNode fourth
		ifNil: [ '' ]
		ifNotNil: [ :node | String cr , (self format: node) ].
	^ 'state ' , identifier , ' of' , String cr , indent
		, (self indentString: stateFieldList) , invariant , initialisation
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> subset [
	^ 'subset'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> totalFunction [
	^ '+>'
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> typeBindList: aViennaNode [
	| patterns |
	patterns := self formatAll: aViennaNode.
	^ self
		join:
			','
				,
					((self anyNeedsIndent: patterns)
						ifTrue: [ String cr ]
						ifFalse: [ String space ])
		withAll: patterns
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

	^ self
		  indentString: 'types'
		  insertCr:
			  (self
				   join: ';' , String cr
				   withAll: (self formatAll: aViennaNode)) , (aViennaNode isEmpty
				   ifTrue: [ '' ]
				   ifFalse: [ ';' , String cr ])
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> typeImport: aViennaNode [
	| type rename |
	type := self format: aViennaNode first.
	rename := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: type insertCrIfNeeded: rename
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> union [
	^ 'union'
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

	^ self
		  indentString: 'values'
		  insertCr:
			  (self
				   join: ';' , String cr
				   withAll: (self formatAll: aViennaNode)) , (aViennaNode isEmpty
				   ifTrue: [ '' ]
				   ifFalse: [ ';' , String cr ])
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> valueExport: aViennaNode [
	| nameList type |
	nameList := self format: aViennaNode first.
	type := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ' : ' , (self format: node) ].
	^ nameList , type
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> valueImport: aViennaNode [
	| name type rename |
	name := self format: aViennaNode first.
	type := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ': ' , (self format: node) ].
	rename := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: name , type insertCrIfNeeded: rename
]
