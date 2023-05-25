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

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> assignStatement: aViennaNode [
	^ self indentString: (self format: aViennaNode first) insertCrIfNeeded: ':= ' , (self format: aViennaNode second)
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
	^ self
		join:
			','
				,
					((self anyNeedsIndent: binds)
						ifTrue: [ String cr ]
						ifFalse: [ String space ])
		withAll: binds
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> blockStatement: aViennaNode [
	^ '('
		, (self join: ';' , String cr withAll: (self formatAll: aViennaNode))
		, ')'
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

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> casesStatement: aViennaNode [
	| value alternatives others |
	value := self format: aViennaNode first.
	alternatives := self format: aViennaNode second.
	others := aViennaNode third
		ifNil: [ '' ]
		ifNotNil: [ :node | ',' , String cr , (self format: node) ].
	^ self
		indentString:
			'cases ' , value , ':' , String cr , alternatives , others , String cr
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
	^ self join: ',' , String cr withAll: (self formatAll: aViennaNode)
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> concat [
	^ '^'
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
				ifTrue: [ String cr , indent
						, (self indentAllStrings: assigns withSeparator: ',') ]
				ifFalse: [ String space , (self join: ', ' withAll: assigns) ])
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
	^ self
		indentString: 'functions'
		insertCrIfNeeded: (self join: ';' , String cr withAll: functionExports) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportModuleSignature: aViennaNode [
	| exportSignatures |
	exportSignatures := self formatAll: aViennaNode.
	^ self join: String cr withAll: exportSignatures
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportModuleSignatureAll: aViennaNode [
	^ 'all'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportOperationsSignature: aViennaNode [
	| signatures |
	signatures := self formatAll: aViennaNode.
	^ self
		indentString: 'operations'
		insertCrIfNeeded: (self join: ';' , String cr withAll: signatures) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportTypesSignature: aViennaNode [
	| typeExports |
	typeExports := self formatAll: aViennaNode.
	^ self
		indentString: 'types'
		insertCrIfNeeded: (self join: ';' , String cr withAll: typeExports) , ';'
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> exportValuesSignature: aViennaNode [
	| signatures |
	signatures := self formatAll: aViennaNode.
	^ self
		indentString: 'values'
		insertCrIfNeeded: (self join: ';' , String cr withAll: signatures) , ';'
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

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> externals: aViennaNode [
	^ aViennaNode asArray
		inject: 'ext'
		into: [ :str :node | str , ' ' , (self format: node) ]
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
	^ self
		join:
			((self anyNeedsIndent: fields)
				ifTrue: [ String cr ]
				ifFalse: [ String space ])
		withAll: fields
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
	^ self
		join:
			','
				,
					((self anyNeedsIndent: fieldPatterns)
						ifTrue: [ String cr ]
						ifFalse: [ String space ])
		withAll: fieldPatterns
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> fieldReference: aViennaNode [
	| stateDesignator field |
	stateDesignator := self format: aViennaNode first.
	field := self format: aViennaNode second.
	^ self indentString: stateDesignator insertCrIfNeeded: '.' , field
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

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> identityStatement: aViennaNode [
	^ 'skip'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> ifStatement: aViennaNode [
	| cond statement default elseifs |
	cond := self format: aViennaNode first first first.
	statement := self format: aViennaNode first first second.
	default := aViennaNode second
		ifNotNil: [ self format: aViennaNode second ].
	elseifs := self formatAll: aViennaNode first asArray copyWithoutFirst.
	aViennaNode first size = 1
		ifTrue: [ ^ (self needsIndent: cond , statement , (default ifNil: [ '' ]))
				ifTrue: [ (self indentString: 'if' insertCr: cond) , String cr
						, (self indentString: 'then' insertCr: statement)
						,
							(default
								ifNil: [ '' ]
								ifNotNil: [ String cr , (self indentString: 'else' insertCr: default) ]) ]
				ifFalse: [ 'if ' , cond , ' then ' , statement
						, (default ifNil: [ '' ] ifNotNil: [ ' else ' , default ]) ] ].
	^ (self indentString: 'if ' , cond insertCr: 'then ' , statement)
		, String cr , (self join: String cr withAll: elseifs)
		,
			(default
				ifNil: [ '' ]
				ifNotNil: [ String cr , (self indentString: 'else' insertCr: default) ])
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
	^ self
		indentString: 'imports'
		insertCrIfNeeded: (self join: ',' , String cr withAll: definitions)
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
ViennaAbstractFormatter >> importModuleSignature: aViennaNode [
	| importSignatures |
	importSignatures := self formatAll: aViennaNode.
	^ self join: String cr withAll: importSignatures
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> importModuleSignatureAll: aViennaNode [
	^ 'all'
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
		ifTrue: [ self join: ',' , String cr withAll: localDefinitions ]
		ifFalse: [ self join: ', ' withAll: localDefinitions ]
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> mapEnumerationPattern: aViennaNode [
	^ '{' , (self formatEnumerate: (self formatAll: aViennaNode) ifEmpty: [ self maplet ]) , '}'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mapInfix [
	^ 'to'
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> mapMunionPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self munion arg: (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mapPrefix [
	^ 'map '
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> mapType: aViennaNode [
	^ self mapPrefix, (self format: aViennaNode first) , ' ' , self mapInfix , ' ' , (self format: aViennaNode second)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> maplet [
	^ '|->'
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> mapletPattern: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: self maplet arg: (self format: aViennaNode second)
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> matchValue: aViennaNode [

	| value |
	value := self format: aViennaNode first.
	^ aViennaNode first isViennaSymbolicLiteralNode
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
	^ 'definitions' , String cr
		, (self join: String cr withAll: definitionBlocks)
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mu [
	^ 'mu'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> mul [
	^ '*'
]

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> multipleAssignStatement: aViennaNode [
	| statements |
	statements := self formatAll: aViennaNode.
	^ 'atomic('
		,
			((self anyNeedsIndent: statements)
				ifTrue: [ self
						join: ';' , String cr , indent
						withAll: (statements collect: [ :statement | self indentString: statement ]) ]
				ifFalse: [ self join: '; ' withAll: statements ]) , ')'
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

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> nondeterministicStatement: aViennaNode [
	| statements |
	statements := self formatAll: aViennaNode.
	^ '||('
		,
			((self anyNeedsIndent: statements)
				ifTrue: [ self
						join: ',' , String cr , indent
						withAll: (statements collect: [ :statement | self indentString: statement ]) ]
				ifFalse: [ self join: ', ' withAll: statements ]) , ')'
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

	^ self indentString: 'operations' insertCr: (self
			   join: ';' , String cr , String cr
			   withAll: (self formatAll: aViennaNode)) , (aViennaNode isEmpty
			   ifTrue: [ '' ]
			   ifFalse: [ ';' , String cr ])
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> operationExport: aViennaNode [
	| name operationType |
	name := self format: aViennaNode first.
	operationType := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ' : ' , (self format: node) ].
	^ name , operationType
]

{ #category : #'formatting-interfaces' }
ViennaAbstractFormatter >> operationImport: aViennaNode [
	| name operationType rename |
	name := self format: aViennaNode first.
	operationType := aViennaNode second ifNil: [ '' ] ifNotNil: [ :node | ': ' , (self format: node) ].
	rename := aViennaNode third ifNil: [ '' ] ifNotNil: [ :node | 'renamed ' , (self format: node) ].
	^ self indentString: name , operationType insertCrIfNeeded: rename
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> operationType: aViennaNode [
	^ (self format: aViennaNode first) , ' ' , self oparrow , ' ' , (self format: aViennaNode second)
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> optionalType: aViennaNode [
	^ '[' , (self format: aViennaNode first) , ']'
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> or [
	^ 'or'
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
	^ '(' , (self join: ', ' withAll: (self formatAll: aViennaNode))
		, ')'
]

{ #category : #'formatting-definitions' }
ViennaAbstractFormatter >> parametersList: aViennaNode [
	^ self join: '' withAll: (self formatAll: aViennaNode)
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
ViennaAbstractFormatter >> patternTypePairList: aViennaNode [
	| string |
	string := ''.
	aViennaNode
		ifNotEmpty: [ 1 to: aViennaNode size - 2 by: 2 do: [ :index | 
				string := string , (self format: (aViennaNode at: index)) , ':'
					, (self format: (aViennaNode at: index + 1)) , ', ' ].
			string := string
				, (self format: (aViennaNode at: aViennaNode size - 1)) , ':'
				, (self format: (aViennaNode at: aViennaNode size)) ].
	^ string
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

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> productType: aViennaNode [
	^ self formatEnumerate: (self formatAll: aViennaNode) separator: self mul ifEmpty: [ '' ]
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

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> returnStatement: aViennaNode [
	^ 'return '
		, (aViennaNode first ifNil: [ '' ] ifNotNil: [ :arg | self indentString: (self format: arg) ])
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
	| patterns |
	patterns := self formatAll: aViennaNode.
	^ self
		join:
			((self anyNeedsIndent: patterns)
				ifTrue: [ String cr , self concat ]
				ifFalse: [ self concat ])
		withAll: patterns
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setDifference [
	^ '\'
]

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> setEnumPattern: aViennaNode [
	^ '{' , (self formatEnumerate: (self formatAll: aViennaNode) ifEmpty: [ '' ]) , '}'
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setPostfix [
	^ ''
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> setPrefix [
	^ 'set of '
]

{ #category : #'formatting-types' }
ViennaAbstractFormatter >> setType: aViennaNode [
	^ self setPrefix, (self format: aViennaNode first) , self setPostfix
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
	^ '{'
		,
			(aViennaNode
				ifNotEmpty: [ self
						join: ',' , String cr
						withAll:
							((1 to: aViennaNode size by: 2)
								collect: [ :index | 
									(self format: (aViennaNode at: index)) , ' |-> '
										, (self indentString: (self format: (aViennaNode at: index + 1))) ]) ]
				ifEmpty: [ '' ]) , '}'
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

{ #category : #'formatting-patterns and binds' }
ViennaAbstractFormatter >> typeBind: aViennaNode [
	^ self print: (self format: aViennaNode first) infix: ':' arg: (self format: aViennaNode second)
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
		ifTrue: [ '['
				, (self join: String space withAll: (self formatAll: aViennaNode))
				, ']' ]
		ifFalse: [ '' ]
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

{ #category : #'formatting-statements' }
ViennaAbstractFormatter >> whileLoop: aViennaNode [
	| expression statement |
	expression := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'while' insertCrIfNeeded: expression)
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)
]
