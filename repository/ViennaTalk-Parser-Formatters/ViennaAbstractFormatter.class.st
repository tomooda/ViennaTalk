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
	          , (aViennaNode formatWith: self).
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> greaterThanOrEqual [
	^ '>='
]

{ #category : #'symbol access' }
ViennaAbstractFormatter >> imply [
	^ '=>'
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

{ #category : #'symbol access' }
ViennaAbstractFormatter >> union [
	^ 'union'
]
