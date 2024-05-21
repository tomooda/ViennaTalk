Class {
	#name : 'ViennaDefinitionComponentNode',
	#superclass : 'ViennaNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaDefinitionComponentNode class >> isAbstract [

	^ self = ViennaDefinitionComponentNode
]

{ #category : 'testing' }
ViennaDefinitionComponentNode >> isViennaDefinitionComponentNode [

	^ true
]
