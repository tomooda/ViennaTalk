Class {
	#name : #ViennaFunctionDefinitionsNode,
	#superclass : #ViennaSectionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaFunctionDefinitionsNode >> isViennaFunctionDefinitionsNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionDefinitionsNode >> label [

	^ 'FunctionDefinitions'
]
