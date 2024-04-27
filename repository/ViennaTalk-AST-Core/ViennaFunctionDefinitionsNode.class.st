Class {
	#name : #ViennaFunctionDefinitionsNode,
	#superclass : #ViennaSectionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
