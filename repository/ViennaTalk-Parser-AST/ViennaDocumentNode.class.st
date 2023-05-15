Class {
	#name : #ViennaDocumentNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaDocumentNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: String cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #accessing }
ViennaDocumentNode >> label [

	^ 'Document'
]