Class {
	#name : #ViennaCasesExpressionAlternativesNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaCasesExpressionAlternativesNode class >> withAll: anArrayOfViennaCasesExpressionAlternativeNode [

	| alternatives |
	alternatives := self new:
		                anArrayOfViennaCasesExpressionAlternativeNode size.
	1 to: anArrayOfViennaCasesExpressionAlternativeNode size do: [ :index |
		alternatives
			at: index
			put: (anArrayOfViennaCasesExpressionAlternativeNode at: index) ].
	^ alternatives
]

{ #category : #'pretty printing' }
ViennaCasesExpressionAlternativesNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ',' , String cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #accessing }
ViennaCasesExpressionAlternativesNode >> label [

	^ 'CasesExpressionAlternatives'
]
