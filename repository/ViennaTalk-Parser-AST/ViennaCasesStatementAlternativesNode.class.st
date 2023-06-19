Class {
	#name : #ViennaCasesStatementAlternativesNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaCasesStatementAlternativesNode >> boundIdentifiersInto: aSet [

	self do: [ :alternative | alternative boundIdentifiersInto: aSet ]
]

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativesNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ',' , String cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #testing }
ViennaCasesStatementAlternativesNode >> isViennaCasesStatementAlternativesNode [

	^ true
]

{ #category : #accessing }
ViennaCasesStatementAlternativesNode >> label [

	^ 'CasesStatementAlternatives'
]
