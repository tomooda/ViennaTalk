Class {
	#name : 'ViennaOperationDefinitionsNode',
	#superclass : 'ViennaSectionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaOperationDefinitionsNode >> isViennaOperationDefinitionsNode [

	^ true
]

{ #category : 'testing' }
ViennaOperationDefinitionsNode >> label [

	^ 'OperationDefinitions'
]

{ #category : 'pretty printing' }
ViennaOperationDefinitionsNode >> sectionName [

	^ 'operations'
]
