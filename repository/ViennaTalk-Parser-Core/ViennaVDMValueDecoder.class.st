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
	^ ($- asPParser optional , super decimalLiteral) flatten trim ==> [ :str | str trim asNumber ]
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
	^ self mapEnumeration / self setEnumeration / self sequenceEnumeration / self tupleConstructor / self recordConstructor
		/ self tokenConstructor / self undefinedExpression / symbolicLiteral
		/ ((lparen , expression , rparen) ==> [ :triple | triple second ])
]

{ #category : #'parsers-definitions' }
ViennaVDMValueDecoder >> functionDefinitions [
	^ PPFailingParser new
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> hexadecimalLiteral [
	^ ($- asPParser optional , super hexadecimalLiteral) trim
		==> [ :pair | 
			| nat |
			nat := Integer readFrom: pair second radix: 16.
			pair first ifNotNil: [ nat := nat negated ].
			nat ]
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
	^ super quoteLiteral ==> [ :quote | (quote copyFrom: 2 to: quote size - 1) asSymbol ]
]

{ #category : #'parsers-expressions' }
ViennaVDMValueDecoder >> recordConstructor [
	^ super recordConstructor
		==> [ :constructorAndArgs | 
			| constructorName args |
			constructorName := constructorAndArgs first.
			constructorName isArray
				ifTrue: [ constructorName := '`' join: constructorName ].
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
	^ super setEnumeration ==> [ :elems | elems asSet ]
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
ViennaVDMValueDecoder >> tokenConstructor [
	^ super tokenConstructor ==> [ :arg | ViennaToken with: arg ]
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
