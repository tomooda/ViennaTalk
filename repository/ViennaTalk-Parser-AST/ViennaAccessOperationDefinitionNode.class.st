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

{ #category : #'as yet unclassified' }
ViennaAccessOperationDefinitionNode >> isViennaAccessOperationDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessOperationDefinitionNode >> label [

	^ 'AccessOperationDefinition'
]
