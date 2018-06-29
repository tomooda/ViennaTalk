Class {
	#name : #ViennaVDMGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'expression',
		'letExpression',
		'letBeExpression',
		'defExpression',
		'ifExpression',
		'casesExpression',
		'unaryExpression',
		'binaryExpression',
		'quantifiedExpression',
		'iotaExpression',
		'setEnumeration',
		'setComprehension',
		'setRangeExpression',
		'sequenceEnumeration',
		'sequenceComprehension',
		'subsequence',
		'mapEnumeration',
		'mapComprehension',
		'tupleConstructor',
		'recordConstructor',
		'recordModifier',
		'apply',
		'fieldSelect',
		'tupleSelect',
		'functionTypeInstantiation',
		'lambdaExpression',
		'newExpression',
		'selfExpression',
		'threadidExpression',
		'generalIsExpr',
		'undefinedExpression',
		'preconditionExpression',
		'isofbaseclassExpression',
		'isofclassExpression',
		'samebaseclassExpression',
		'sameclassExpression',
		'actExpression',
		'finExpression',
		'activeExpression',
		'reqExpression',
		'waitingExpression',
		'timeExpression',
		'name',
		'oldName',
		'symbolicLiteral',
		'pattern',
		'type',
		'functionDefinition',
		'basicType',
		'compositeType',
		'productType',
		'unionType',
		'optionalType',
		'setType',
		'seqType',
		'mapType',
		'typeName',
		'typeVariable',
		'quoteType',
		'quoteLiteral',
		'identifier',
		'partialFunctionType',
		'numericLiteral',
		'booleanLiteral',
		'nilLiteral',
		'characterLiteral',
		'textLiteral',
		'identifiedField',
		'equalityAbstractionField',
		'anonymousField'
	],
	#category : 'ViennaTalk-Value-Core'
}

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> actExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> activeExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> anonymousField [
	^ type
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> apply [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> basicType [
	^ 'bool' asParser trim / 'nat1' asParser trim / 'nat' asParser trim / 'int' asParser trim / 'real' asParser trim
		/ 'char' asParser trim / 'token' asParser trim
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> binaryExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> booleanLiteral [
	^ 'true' asParser trim / 'false' asParser trim
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> casesExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> characterLiteral [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> compositeType [
	| fieldList |
	fieldList := (identifiedField / equalityAbstractionField / anonymousField) star.
	^ ('compose' asParser trim , identifier , 'of' asParser trim , fieldList , 'end' asParser trim)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> defExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> equalityAbstractionField [
	^ (identifier , ':-' asParser trim , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> expression [
	^ letExpression / letBeExpression / defExpression / ifExpression / casesExpression / unaryExpression / binaryExpression
		/ quantifiedExpression / iotaExpression / setEnumeration / setComprehension / setRangeExpression / sequenceEnumeration
		/ sequenceComprehension / subsequence / mapEnumeration / mapComprehension / tupleConstructor / recordConstructor
		/ recordModifier / apply / fieldSelect / tupleSelect / functionTypeInstantiation / lambdaExpression / newExpression
		/ selfExpression / threadidExpression / generalIsExpr / undefinedExpression / preconditionExpression
		/ isofbaseclassExpression / isofclassExpression / samebaseclassExpression / sameclassExpression / actExpression
		/ finExpression / activeExpression / reqExpression / waitingExpression / timeExpression / name / oldName
		/ symbolicLiteral / (($( asParser trim , expression , $) asParser trim) ==> [ :triple | triple second ])
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> fieldSelect [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> finExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-definitions' }
ViennaVDMGrammar >> functionDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> functionTypeInstantiation [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> generalIsExpr [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> identifiedField [
	^ (identifier , $: asParser trim , type)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]
]

{ #category : #'parsers-symbols' }
ViennaVDMGrammar >> identifier [
	^ ((PPPredicateObjectParser on: [ :char | ViennaUnicode isInitialLetter: char ] message: 'identifier expected')
		, (PPPredicateObjectParser on: [ :char | ViennaUnicode isFollowingLetter: char ] message: 'identifier expected') star)
		flatten trim
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> ifExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> iotaExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> isofbaseclassExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> isofclassExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> lambdaExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> letBeExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> letExpression [
	| valueDefinition localDefinition |
	valueDefinition := (pattern , ($: asParser trim , type) optional , $= asParser trim , expression)
		==> [ :quatro | 
			{(quatro first).
			(quatro second ifNotNil: [ :second | second second ]).
			(quatro fourth)} ].
	localDefinition := valueDefinition / functionDefinition.
	^ ('let' asParser trim , localDefinition , ($, asParser trim , localDefinition) star , 'in' asParser trim , expression)
		==> [ :quin | 
			{(Array
				new: quin third size + 1
				streamContents: [ :stream | 
					stream nextPut: quin second.
					quin third do: [ :pair | stream nextPut: pair second ] ]).
			(quin fifth)} ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> mapComprehension [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> mapEnumeration [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> mapType [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> name [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> newExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> nilLiteral [
	^ 'nil' asParser trim
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> numericLiteral [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> oldName [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> optionalType [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> partialFunctionType [
	^ PPFailingParser new
]

{ #category : #'parsers-patterns' }
ViennaVDMGrammar >> pattern [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> preconditionExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> productType [
	^ (type , ($* asParser trim , type) plus)
		==> [ :pair | 
			Array
				new: pair second size + 1
				streamContents: [ :stream | 
					stream nextPut: pair first.
					pair second do: [ :second | stream nextPut: second second ] ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> quantifiedExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> quoteLiteral [
	^ ($< asParser , identifier , $> asParser) flatten trim
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> quoteType [
	^ quoteLiteral
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> recordConstructor [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> recordModifier [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> reqExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> samebaseclassExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> sameclassExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> selfExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> seqType [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> sequenceComprehension [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> sequenceEnumeration [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> setComprehension [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> setEnumeration [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> setRangeExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> setType [
	^ PPFailingParser new
]

{ #category : #parsing }
ViennaVDMGrammar >> start [
	^ expression end
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> subsequence [
	^ PPFailingParser new
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> symbolicLiteral [
	^ numericLiteral / booleanLiteral / nilLiteral / characterLiteral / textLiteral / quoteLiteral
]

{ #category : #'parsers-literals' }
ViennaVDMGrammar >> textLiteral [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> threadidExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> timeExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> tupleConstructor [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> tupleSelect [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> type [
	^ basicType / quoteType / compositeType / unionType / productType / optionalType / setType / seqType / mapType
		/ partialFunctionType / typeName / typeVariable
		/ (($( asParser trim , type , $) asParser trim) ==> [ :triple | triple second ])
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> typeName [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> typeVariable [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> unaryExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> undefinedExpression [
	^ PPFailingParser new
]

{ #category : #'parsers-types' }
ViennaVDMGrammar >> unionType [
	^ (type , ($| asParser trim , type) plus)
		==> [ :pair | 
			Array
				new: pair second size + 1
				streamContents: [ :stream | 
					stream nextPut: pair first.
					pair second do: [ :second | stream nextPut: second second ] ] ]
]

{ #category : #'parsers-expressions' }
ViennaVDMGrammar >> waitingExpression [
	^ PPFailingParser new
]
