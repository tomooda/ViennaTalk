Class {
	#name : #ViennaFunctionDefinitionsNode,
	#superclass : #ViennaSectionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaFunctionDefinitionsNode >> isViennaFunctionDefinitionsNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionDefinitionsNode >> label [

	^ 'FunctionDefinitions'
]

{ #category : #'pretty printing' }
ViennaFunctionDefinitionsNode >> sectionName [

	^ 'functions'
]
