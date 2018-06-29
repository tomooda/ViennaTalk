Class {
	#name : #ViennaVDMHighlighter,
	#superclass : #ViennaVDMGrammar,
	#instVars : [
		'text',
		'identifierAttribute',
		'keywordAttribute',
		'operatorAttribute',
		'literalAttribute',
		'typeAttribute',
		'commentAttribute',
		'moduleAttribute'
	],
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #accessing }
ViennaVDMHighlighter class >> ignoredNames [
	"Answer a collection of instance-variables that should not be automatically initialized with productions, but that are used internal to the composite parser."

	^ super ignoredNames , ViennaVDMHighlighter instVarNames
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> abs [
	^ self op: super abs
]

{ #category : #'parsers-definitions' }
ViennaVDMHighlighter >> access [
	^ self keyword: super access
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> all [
	^ self keyword: super all
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> amp [
	^ self keyword: super amp
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> andOp [
	^ self op: super andOp
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> arrow [
	^ self keyword: super arrow
]

{ #category : #'parsers-types' }
ViennaVDMHighlighter >> basicTypeName [
	^ self type: super basicTypeName
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> best [
	^ self keyword: super best
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> by [
	^ self keyword: super by
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> card [
	^ self op: super card
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> cases [
	^ self keyword: super cases
]

{ #category : #'parsers-expressions' }
ViennaVDMHighlighter >> casesExpressionAlternatives [
	^ (self casesExpressionAlternative separatedBy: (self keyword: comma)) withoutSeparators
]

{ #category : #'parsers-statements' }
ViennaVDMHighlighter >> casesStatementAlternatives [
	^ (self casesStatementAlternative separatedBy: (self keyword: comma)) withoutSeparators
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> colon [
	^ self keyword: super colon
]

{ #category : #'parsers-comments' }
ViennaVDMHighlighter >> comment [
	^ self comment: super comment
]

{ #category : #utilities }
ViennaVDMHighlighter >> comment: aParser [
	^ self highlight: aParser with: self commentAttribute
]

{ #category : #accessing }
ViennaVDMHighlighter >> commentAttribute [
	^ commentAttribute ifNil: [ commentAttribute := TextColor gray ]
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> comp [
	^ self op: super comp
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> compose [
	^ self keyword: super compose
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> conc [
	^ self op: super conc
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> def [
	^ self keyword: super def
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> definitions [
	^ self keyword: super definitions
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> diffOp [
	^ self op: super diffOp
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> dinter [
	^ self op: super dinter
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> div [
	^ self op: super div
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> do [
	^ self keyword: super do
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> dom [
	^ self op: super dom
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> dots [
	^ self op: super dots
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> doublebar [
	^ self keyword: super doublebar
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> dunion [
	^ self op: super dunion
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> elems [
	^ self op: super elems
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> else [
	^ self keyword: super else
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> elseif [
	^ self keyword: super elseif
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> endKeyword [
	^ self keyword: super endKeyword
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> enumerate [
	^ self op: super enumerate
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> eq [
	^ self keyword: super eq
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> eqOp [
	^ self op: super eqOp
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> equivOp [
	^ self op: super equivOp
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> exists [
	^ self keyword: super exists
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> exists1 [
	^ self keyword: super exists1
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> exports [
	^ self keyword: super exports
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> floor [
	^ self op: super floor
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> for [
	^ self keyword: super for
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> forall [
	^ self keyword: super forall
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> from [
	^ self keyword: super from
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> functions [
	^ self keyword: super functions
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> greater [
	^ self op: super greater
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> greaterOrEqual [
	^ self op: super greaterOrEqual
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> hatOp [
	^ self op: super hatOp
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> hd [
	^ self op: super hd
]

{ #category : #utilities }
ViennaVDMHighlighter >> highlight: aParser with: aTextAttributeOrCollection [
	^ aParser
		=>> [ :start :end :result | 
			aTextAttributeOrCollection isCollection
				ifTrue: [ aTextAttributeOrCollection do: [ :attribute | text addAttribute: attribute from: start to: end ] ]
				ifFalse: [ text addAttribute: aTextAttributeOrCollection from: start to: end ].
			result ]
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> identifier [
	^ self identifier: super identifier
]

{ #category : #utilities }
ViennaVDMHighlighter >> identifier: aParser [
	^ self highlight: aParser with: self identifierAttribute
]

{ #category : #accessing }
ViennaVDMHighlighter >> identifierAttribute [
	^ identifierAttribute ifNil: [ identifierAttribute := TextColor blue ]
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> if [
	^ self keyword: super if
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> impOp [
	^ self op: super impOp
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> imports [
	^ self keyword: super imports
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> in [
	^ self keyword: super in
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> inds [
	^ self op: super inds
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> init [
	^ self keyword: super init
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> inter [
	^ self op: super inter
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> inv [
	^ self keyword: super inv
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> inverse [
	^ self op: super inverse
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> iota [
	^ self keyword: super iota
]

{ #category : #'parsers-expressions' }
ViennaVDMHighlighter >> isNameExpression [
	^ ('is_' asParser , (self type: name) , lparen , expression , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-definitions' }
ViennaVDMHighlighter >> isNotYetSpecified [
	^ self keyword: super isNotYetSpecified
]

{ #category : #'parsers-definitions' }
ViennaVDMHighlighter >> isSubclassResponsibility [
	^ self keyword: super isSubclassResponsibility
]

{ #category : #utilities }
ViennaVDMHighlighter >> keyword: aParser [
	^ self highlight: aParser with: self keywordAttribute
]

{ #category : #accessing }
ViennaVDMHighlighter >> keywordAttribute [
	^ keywordAttribute ifNil: [ keywordAttribute := TextEmphasis bold ]
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> lambda [
	^ self keyword: super lambda
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> len [
	^ self op: super len
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> less [
	^ self op: super less
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> lessOrEqual [
	^ self op: super lessOrEqual
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> let [
	^ self keyword: super let
]

{ #category : #utilities }
ViennaVDMHighlighter >> literal: aParser [
	^ self highlight: aParser with: self literalAttribute
]

{ #category : #accessing }
ViennaVDMHighlighter >> literalAttribute [
	^ literalAttribute ifNil: [ literalAttribute := TextColor color: Color yellow muchDarker ]
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> mapDomainRestrictedBy [
	^ self op: super mapDomainRestrictedBy
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> mapDomainRestrictedTo [
	^ self op: super mapDomainRestrictedTo
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> mapRangeRestrictedBy [
	^ self op: super mapRangeRestrictedBy
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> mapRangeRestrictedTo [
	^ self op: super mapRangeRestrictedTo
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> measure [
	^ self keyword: super measure
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> merge [
	^ self op: super merge
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> minusOp [
	^ self op: super minusOp
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> mod [
	^ self op: super mod
]

{ #category : #utilities }
ViennaVDMHighlighter >> module: aParser [
	^ self highlight: aParser with: self moduleAttribute
]

{ #category : #accessing }
ViennaVDMHighlighter >> moduleAttribute [
	^ moduleAttribute ifNil: [ moduleAttribute := TextColor color: Color red muchDarker ]
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> moduleIdentifier [
	^ self module: super moduleIdentifier
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> moduleKeyword [
	^ self keyword: super moduleKeyword
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> munion [
	^ self op: super munion
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> notEq [
	^ self op: super notEq
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> notOp [
	^ self op: super notOp
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> of [
	^ self keyword: super of
]

{ #category : #utilities }
ViennaVDMHighlighter >> op: aParser [
	^ self highlight: aParser with: self operatorAttribute
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> operations [
	^ self keyword: super operations
]

{ #category : #accessing }
ViennaVDMHighlighter >> operatorAttribute [
	^ operatorAttribute ifNil: [ operatorAttribute := {} ]
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> orOp [
	^ self op: super orOp
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> others [
	^ self keyword: super others
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> plusOp [
	^ self op: super plusOp
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> plusPlusOp [
	^ self op: super plusPlusOp
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> post [
	^ self keyword: super post
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> power [
	^ self op: super power
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> pre [
	^ self keyword: super pre
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> psubset [
	^ self op: super psubset
]

{ #category : #'parsers-types' }
ViennaVDMHighlighter >> quoteType [
	^ self type: super quoteType
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> rem [
	^ self op: super rem
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> renamed [
	^ self keyword: super renamed
]

{ #category : #'parsers-expressions' }
ViennaVDMHighlighter >> resultExpression [
	^ self keyword: super resultExpression
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> return [
	^ self keyword: super return
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> reverse [
	^ self op: super reverse
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> rng [
	^ self op: super rng
]

{ #category : #'parsers-expressions' }
ViennaVDMHighlighter >> selfExpression [
	^ self keyword: super selfExpression
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> slash [
	^ self op: super slash
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> starOp [
	^ self op: super starOp
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> state [
	^ self keyword: super state
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> struct [
	^ self keyword: super struct
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> subset [
	^ self op: super subset
]

{ #category : #'parsers-literals' }
ViennaVDMHighlighter >> symbolicLiteral [
	^ self literal: super symbolicLiteral
]

{ #category : #accessing }
ViennaVDMHighlighter >> text [
	^ text
]

{ #category : #accessing }
ViennaVDMHighlighter >> text: aText [
	text := aText
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> then [
	^ self keyword: super then
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> tl [
	^ self op: super tl
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> to [
	^ self keyword: super to
]

{ #category : #utilities }
ViennaVDMHighlighter >> type: aParser [
	^ self highlight: aParser with: self typeAttribute
]

{ #category : #accessing }
ViennaVDMHighlighter >> typeAttribute [
	^ typeAttribute ifNil: [ typeAttribute := TextColor color: Color cyan muchDarker ]
]

{ #category : #'parsers-types' }
ViennaVDMHighlighter >> typeIdentifier [
	^ self type: super typeIdentifier
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> types [
	^ self keyword: super types
]

{ #category : #'parsers-expressions' }
ViennaVDMHighlighter >> undefinedExpression [
	^ self keyword: super undefinedExpression
]

{ #category : #'parsers-symbols' }
ViennaVDMHighlighter >> union [
	^ self op: super union
]

{ #category : #'parsers-types' }
ViennaVDMHighlighter >> unitType [
	^ self type: super unitType
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> values [
	^ self keyword: super values
]

{ #category : #'parsers-keywords' }
ViennaVDMHighlighter >> while [
	^ self keyword: super while
]
