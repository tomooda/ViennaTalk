Class {
	#name : #ViennaDocumentNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaDocumentNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: String cr
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #testing }
ViennaDocumentNode >> hasScope [

	^ true
]

{ #category : #testing }
ViennaDocumentNode >> isViennaDocumentNode [

	^ true
]

{ #category : #accessing }
ViennaDocumentNode >> label [

	^ 'Document'
]
