Class {
	#name : #ViennaVDMValueDecoder,
	#superclass : #ViennaVDMGrammar,
	#category : 'ViennaTalk-Parser-Core'
}

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> accessFunctionDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> accessOperationDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> accessTypeDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> booleanLiteral [
	^ super booleanLiteral
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> characterLiteral [
	^ super characterLiteral
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> decimalLiteral [
	^ super decimalLiteral ==> [ :str | str asNumber ]
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> document [
	^ PPFailingParser new
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> explicitFunctionDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> explicitOperationDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> expression [
	| expressionParser |
	expressionParser := PPExpressionParser new.
	expressionParser
		term:
			mapEnumeration / setEnumeration / sequenceEnumeration / tupleConstructor / recordConstructor / undefinedExpression
				/ symbolicLiteral / ((lparen , expression , rparen) ==> [ :triple | triple second ]).
	^ expressionParser
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> functionDefinitions [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> hexadecimalLiteral [
	^ super hexadecimalLiteral ==> [ :hex | Integer readFrom: hex radix: 16 ]
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> initialisation [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> mapEnumeration [
	^ super mapEnumeration
		==> [ :pairs | 
			| map |
			map := Dictionary new.
			pairs do: [ :pair | map at: pair first put: pair second ].
			map ]
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> nilLiteral [
	^ super nilLiteral
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> operationDefinitions [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> quoteLiteral [
	^ super quoteLiteral ==> [ :quote | quote asSymbol ]
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> recordConstructor [
	^ super recordConstructor
		==> [ :constructorAndArgs | 
			| constructorName args |
			constructorName := constructorAndArgs first.
			args := constructorAndArgs second.
			ViennaComposite constructorName: constructorName withAll: args ]
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> recordTypeDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> sequenceEnumeration [
	^ super sequenceEnumeration ==> [ :elems | elems asOrderedCollection ]
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> setEnumeration [
	^ super sequenceEnumeration ==> [ :elems | elems asSet ]
]

{ #category : #parsing }
ViennaVDMValueDecoder >> start [
	^ expression end
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> stateDefinition [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> textLiteral [
	^ super textLiteral
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> tupleConstructor [
	^ super tupleConstructor ==> [ :array | array asArray ]
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> typeDefinitions [
	^ PPFailingParser new
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> typeSynonym [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> unaryMinus [
	^ (self operator: $-) , expression
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> unaryPlus [
	^ (self operator: $+) , expression
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> undefinedExpression [
	^ super undefinedExpression ==> [ :t | ViennaUndefinedEvaluationError signal ]
]