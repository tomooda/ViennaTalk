Class {
	#name : #ViennaOperationDefinitionsNode,
	#superclass : #ViennaSectionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaOperationDefinitionsNode >> isViennaOperationDefinitionsNode [

	^ true
]

{ #category : #testing }
ViennaOperationDefinitionsNode >> label [

	^ 'OperationDefinitions'
]

{ #category : #'pretty printing' }
ViennaOperationDefinitionsNode >> sectionName [

	^ 'operations'
]
