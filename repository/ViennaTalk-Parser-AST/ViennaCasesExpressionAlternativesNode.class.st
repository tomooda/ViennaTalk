Class {
	#name : #ViennaCasesExpressionAlternativesNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaCasesExpressionAlternativesNode >> boundIdentifiersDo: aBlock [

	self do: [ :alternative | alternative boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaCasesExpressionAlternativesNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ',' , String cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #testing }
ViennaCasesExpressionAlternativesNode >> isViennaCasesExpressionAlternativesNode [

	^ true
]

{ #category : #accessing }
ViennaCasesExpressionAlternativesNode >> label [

	^ 'CasesExpressionAlternatives'
]
