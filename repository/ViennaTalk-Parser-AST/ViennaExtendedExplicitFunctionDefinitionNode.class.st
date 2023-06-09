Class {
	#name : #ViennaExtendedExplicitFunctionDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #'as yet unclassified' }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaExtendedExplicitFunctionDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> label [

	^ 'ExtendedExplicitFunctionDefinition'
]
