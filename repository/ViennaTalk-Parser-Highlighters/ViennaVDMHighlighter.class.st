Class {
	#name : 'ViennaVDMHighlighter',
	#superclass : 'ViennaVDMParser',
	#instVars : [
		'text',
		'identifierAttribute',
		'keywordAttribute',
		'literalAttribute',
		'typeAttribute',
		'commentAttribute',
		'moduleAttribute',
		'declAttribute'
	],
	#category : 'ViennaTalk-Parser-Highlighters',
	#package : 'ViennaTalk-Parser-Highlighters'
}

{ #category : 'accessing' }
ViennaVDMHighlighter class >> current [

	^ self new
]

{ #category : 'accessing' }
ViennaVDMHighlighter class >> ignoredNames [
	"Answer a collection of instance-variables that should not be automatically initialized with productions, but that are used internal to the composite parser."

	^ super ignoredNames , ViennaVDMHighlighter instVarNames
]

{ #category : 'parsers-definitions' }
ViennaVDMHighlighter >> access [
	^ self keyword: super access
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> all [
	^ self keyword: super all
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> always [
	^ self keyword: super always
]

{ #category : 'parsers-symbols' }
ViennaVDMHighlighter >> amp [
	^ self keyword: super amp
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> arrow [
	^ self keyword: super arrow
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> best [
	^ self keyword: super best
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> by [
	^ self keyword: super by
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> cases [
	^ self keyword: super cases
]

{ #category : 'parsers-symbols' }
ViennaVDMHighlighter >> colon [
	^ self keyword: super colon
]

{ #category : 'parsers-comments' }
ViennaVDMHighlighter >> comment [
	^ self comment: super comment
]

{ #category : 'utilities' }
ViennaVDMHighlighter >> comment: aParser [
	^ self highlight: aParser with: self commentAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> commentAttribute [
	^ commentAttribute ifNil: [ commentAttribute := TextColor gray ]
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> compose [
	^ self keyword: super compose
]

{ #category : 'utilities' }
ViennaVDMHighlighter >> decl: aParser [
	^ self highlight: aParser with: self declAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> declAttribute [
	^ declAttribute ifNil: [ declAttribute := TextEmphasis italic ]
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> def [
	^ self keyword: super def
]

{ #category : 'parsing' }
ViennaVDMHighlighter >> default [

	^ document end / self namedTrace end / self importModuleSignature end
	  / self accessTypeDefinition end / self accessValueDefinition end
	  / self stateDefinition end / self accessFunctionDefinition end
	  / self accessOperationDefinition end / self statement end
	  / self expression end / self importDefinition end
	  / self typeImport end / self valueImport end
	  / self functionImport end / self operationImport
	  
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> definitions [
	^ self keyword: super definitions
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> do [
	^ self keyword: super do
]

{ #category : 'parsers-symbols' }
ViennaVDMHighlighter >> doublebar [
	^ self keyword: super doublebar
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> else [
	^ self keyword: super else
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> elseif [
	^ self keyword: super elseif
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> endKeyword [
	^ self keyword: super endKeyword
]

{ #category : 'parsers-statements' }
ViennaVDMHighlighter >> errorStatement [
	^ self keyword: super errorStatement
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> errs [
	^ self keyword: super errs
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> exists [
	^ self keyword: super exists
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> exists1 [
	^ self keyword: super exists1
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> exit [
	^ self keyword: super exit
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> exports [
	^ self keyword: super exports
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> ext [
	^ self keyword: super ext
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> for [
	^ self keyword: super for
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> forall [
	^ self keyword: super forall
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> from [
	^ self keyword: super from
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> functions [
	^ self keyword: super functions
]

{ #category : 'utilities' }
ViennaVDMHighlighter >> highlight: aParser with: aTextAttributeOrCollection [
	^ aParser
		=>> [ :start :end :result | 
			aTextAttributeOrCollection isCollection
				ifTrue: [ aTextAttributeOrCollection do: [ :attribute | text addAttribute: attribute from: start to: end ] ]
				ifFalse: [ text addAttribute: aTextAttributeOrCollection from: start to: end ].
			result ]
]

{ #category : 'parsers-symbols' }
ViennaVDMHighlighter >> identifier [
	^ self identifier: super identifier
]

{ #category : 'utilities' }
ViennaVDMHighlighter >> identifier: aParser [
	^ self highlight: aParser with: self identifierAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> identifierAttribute [
	^ identifierAttribute
		ifNil: [ identifierAttribute := TextColor
				color: (Color blue mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> if [
	^ self keyword: super if
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> imports [
	^ self keyword: super imports
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> in [
	^ self keyword: super in
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> init [
	^ self keyword: super init
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> inseq [

	^ self keyword: super inseq
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> inset [

	^ self keyword: super inset
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> inv [
	^ self keyword: super inv
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> iota [
	^ self keyword: super iota
]

{ #category : 'parsers-definitions' }
ViennaVDMHighlighter >> isNotYetSpecified [
	^ self keyword: super isNotYetSpecified
]

{ #category : 'utilities' }
ViennaVDMHighlighter >> keyword: aParser [
	^ self highlight: aParser with: self keywordAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> keywordAttribute [
	^ keywordAttribute ifNil: [ keywordAttribute := TextEmphasis bold ]
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> lambda [
	^ self keyword: super lambda
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> let [
	^ self keyword: super let
]

{ #category : 'utilities' }
ViennaVDMHighlighter >> literal: aParser [
	^ self highlight: aParser with: self literalAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> literalAttribute [
	^ literalAttribute
		ifNil:
			[ literalAttribute := TextColor color: Color yellow muchDarker ]
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> measure [
	^ self keyword: super measure
]

{ #category : 'utilities' }
ViennaVDMHighlighter >> module: aParser [
	^ self highlight: aParser with: self moduleAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> moduleAttribute [
	^ moduleAttribute
		ifNil: [ moduleAttribute := TextColor
				color: (Color red mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : 'parsers-symbols' }
ViennaVDMHighlighter >> moduleIdentifier [
	^ self module: super moduleIdentifier
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> moduleKeyword [
	^ self keyword: super moduleKeyword
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> of [
	^ self keyword: super of
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> operations [
	^ self keyword: super operations
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> others [
	^ self keyword: super others
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> parse: aStringOrText onError: errorBlock [
	| result |
	self text: aStringOrText asText.
	result := self parse: aStringOrText asString.
	result isPetit2Failure
		ifFalse: [ ^ text ].
	errorBlock numArgs = 0
		ifTrue: [ ^ errorBlock value ].
	errorBlock numArgs = 1
		ifTrue: [ ^ errorBlock value: result ].
	^ errorBlock value: result message value: result position
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> post [
	^ self keyword: super post
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> pre [
	^ self keyword: super pre
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> rd [
	^ self keyword: super rd
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> renamed [
	^ self keyword: super renamed
]

{ #category : 'parsers-expressions' }
ViennaVDMHighlighter >> resultExpression [
	^ self keyword: super resultExpression
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> return [
	^ self keyword: super return
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> skip [
	^ self keyword: super skip
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> state [
	^ self keyword: super state
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> struct [
	^ self keyword: super struct
]

{ #category : 'parsers-literals' }
ViennaVDMHighlighter >> symbolicLiteral [
	^ self literal: super symbolicLiteral
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> text [
	^ text
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> text: aText [
	text := aText
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> then [
	^ self keyword: super then
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> tixe [
	^ self keyword: super tixe
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> to [
	^ self keyword: super to
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> traces [
	^ self keyword: super traces
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> trap [
	^ self keyword: super trap
]

{ #category : 'utilities' }
ViennaVDMHighlighter >> type: aParser [
	^ self highlight: aParser with: self typeAttribute
]

{ #category : 'accessing' }
ViennaVDMHighlighter >> typeAttribute [
	^ typeAttribute
		ifNil: [ typeAttribute := TextColor
				color: (Color cyan mixed: 0.4 with: UITheme current textColor) ]
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> types [
	^ self keyword: super types
]

{ #category : 'parsers-expressions' }
ViennaVDMHighlighter >> undefinedExpression [
	^ self keyword: super undefinedExpression
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> values [
	^ self keyword: super values
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> while [
	^ self keyword: super while
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> with [
	^ self keyword: super with
]

{ #category : 'parsers-keywords' }
ViennaVDMHighlighter >> wr [
	^ self keyword: super wr
]
