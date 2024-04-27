Class {
	#name : #ViennaTopLevelDefinitionNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #testing }
ViennaTopLevelDefinitionNode class >> isAbstract [

	^ self = ViennaTopLevelDefinitionNode
]

{ #category : #accessing }
ViennaTopLevelDefinitionNode >> identifier [

	^ self subclassResponsibility
]

{ #category : #accessing }
ViennaTopLevelDefinitionNode >> identifiers [

	^ { self identifier }
]

{ #category : #testing }
ViennaTopLevelDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ self subclassResponsibility
]

{ #category : #testing }
ViennaTopLevelDefinitionNode >> isViennaTopLevelDefinitionNode [

	^ true
]
