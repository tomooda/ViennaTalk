Class {
	#name : #ViennaTypeDefinitionsNode,
	#superclass : #ViennaSectionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #testing }
ViennaTypeDefinitionsNode >> isViennaTypeDefinitionsNode [

	^ true
]

{ #category : #testing }
ViennaTypeDefinitionsNode >> label [

	^ 'TypeDefinitions'
]

{ #category : #'pretty printing' }
ViennaTypeDefinitionsNode >> sectionName [

	^ 'types'
]
