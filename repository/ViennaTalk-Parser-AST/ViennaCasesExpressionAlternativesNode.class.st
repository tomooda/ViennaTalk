Class {
	#name : #ViennaCasesExpressionAlternativesNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaCasesExpressionAlternativesNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaCasesExpressionAlternativesNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ',' , String cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #private }
ViennaCasesExpressionAlternativesNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :alternative |
		alternative freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaCasesExpressionAlternativesNode >> isViennaCasesExpressionAlternativesNode [

	^ true
]

{ #category : #accessing }
ViennaCasesExpressionAlternativesNode >> label [

	^ 'CasesExpressionAlternatives'
]

{ #category : #typechecking }
ViennaCasesExpressionAlternativesNode >> maximalType [

	^ self
		  inject: ViennaType unit
		  into: [ :type :alternative | type + alternative typecheck ]
]
