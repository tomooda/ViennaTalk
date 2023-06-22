Class {
	#name : #ViennaCasesStatementAlternativesNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaCasesStatementAlternativesNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativesNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ',' , String cr
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
