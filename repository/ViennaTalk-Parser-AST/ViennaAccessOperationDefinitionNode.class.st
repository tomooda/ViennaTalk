Class {
	#name : #ViennaAccessOperationDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaAccessOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll:
		  ((aViennaAbstractFormatter formatAll: self) reject: #isEmpty)
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> identifier [

	^ self operationDefinition identifier
]

{ #category : #'as yet unclassified' }
ViennaAccessOperationDefinitionNode >> isViennaAccessOperationDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> label [

	^ 'AccessOperationDefinition'
]

{ #category : #'parsers-definitions' }
ViennaAccessOperationDefinitionNode >> operationDefinition [

	^ self at: 2
]
