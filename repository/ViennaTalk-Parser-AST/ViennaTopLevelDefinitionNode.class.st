Class {
	#name : #ViennaTopLevelDefinitionNode,
	#superclass : #ViennaAbstractSyntaxNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaTopLevelDefinitionNode class >> isAbstract [

	^ self = ViennaTopLevelDefinitionNode
]

{ #category : #testing }
ViennaTopLevelDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ self subclassResponsibility
]

{ #category : #testing }
ViennaTopLevelDefinitionNode >> isViennaTopLevelDefinitionNode [

	^ true
]
