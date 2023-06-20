Class {
	#name : #ViennaEqualDefinitionNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaEqualDefinitionNode class >> patternOrBind: aViennaPatternNodeOrViennaBindNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  patternOrBind: aViennaPatternNodeOrViennaBindNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #private }
ViennaEqualDefinitionNode >> boundIdentifiersDo: aBlock [

	self patternOrBind boundIdentifiersDo: aBlock
]

{ #category : #'parsers-patterns' }
ViennaEqualDefinitionNode >> expression [

	^ self at: 2
]

{ #category : #'parsers-patterns' }
ViennaEqualDefinitionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaEqualDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| patternOrBind expression |
	patternOrBind := aViennaAbstractFormatter format: self patternOrBind.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString: patternOrBind , ' = '
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaEqualDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternOrBind freeIdentifiersExcept: aSet do: aBlock.
	self expression
		freeIdentifiersExcept:
		aSet , self patternOrBind uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaEqualDefinitionNode >> isViennaEqualDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaEqualDefinitionNode >> label [

	^ 'EqualDefinition'
]

{ #category : #'parsers-patterns' }
ViennaEqualDefinitionNode >> patternOrBind [

	^ self at: 1
]

{ #category : #'parsers-patterns' }
ViennaEqualDefinitionNode >> patternOrBind: aViennaPatternNodeOrViennaBindNode [

	self at: 1 put: aViennaPatternNodeOrViennaBindNode
]
