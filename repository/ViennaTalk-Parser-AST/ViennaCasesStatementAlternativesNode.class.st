Class {
	#name : #ViennaCasesStatementAlternativesNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaCasesStatementAlternativesNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ',' , String cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #'as yet unclassified' }
ViennaCasesStatementAlternativesNode >> isViennaCasesStatementAlternativesNode [

	^ true
]

{ #category : #accessing }
ViennaCasesStatementAlternativesNode >> label [

	^ 'CasesStatementAlternatives'
]
