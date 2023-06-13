Class {
	#name : #ViennaFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaFunctionDefinitionNode >> definition [

	^ self at: 1
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> identifier [

	^ self definition identifier
]

{ #category : #'as yet unclassified' }
ViennaFunctionDefinitionNode >> isViennaFunctionDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionDefinitionNode >> label [

	^ 'FunctionDefinition'
]
