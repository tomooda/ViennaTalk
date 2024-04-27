Class {
	#name : #ViennaCasesStatementAlternativesNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaCasesStatementAlternativesNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativesNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join:
		  aViennaAbstractFormatter empty , ',' , aViennaAbstractFormatter cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #private }
ViennaCasesStatementAlternativesNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :alternative |
		alternative freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaCasesStatementAlternativesNode >> isViennaCasesStatementAlternativesNode [

	^ true
]

{ #category : #accessing }
ViennaCasesStatementAlternativesNode >> label [

	^ 'CasesStatementAlternatives'
]

{ #category : #typechecking }
ViennaCasesStatementAlternativesNode >> maximalType [

	^ self
		  inject: ViennaType unit
		  into: [ :type :alternative | type + alternative typecheck ]
]
