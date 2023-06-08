Class {
	#name : #ViennaRecordTypeDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'as yet unclassified' }
ViennaRecordTypeDefinitionNode >> isViennaRecordTypeDefinitionNode [

	^ true
]

{ #category : #'as yet unclassified' }
ViennaRecordTypeDefinitionNode >> label [

	^ 'RecordTypeDefinition'
]
