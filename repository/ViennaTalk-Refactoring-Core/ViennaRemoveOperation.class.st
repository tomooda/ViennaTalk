Class {
	#name : 'ViennaRemoveOperation',
	#superclass : 'ViennaRemove',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaRemoveOperation >> check [

	ast ifNil: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	self definitionNode isReferenced ifTrue: [ ^ false ].
	^ true
]

{ #category : 'operations' }
ViennaRemoveOperation >> execute [

	(self definitionNode
		 detectParent: #isViennaOperationDefinitionsNode
		 ifNone: [ nil ]) ifNotNil: [ :operationDefinitions |
		operationDefinitions remove: self definitionNode.
		^ operationDefinitions ifEmpty: [
			  operationDefinitions parent
				  remove: operationDefinitions;
				  yourself ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaRemoveOperation >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	^ ast resolve ifNotNil: [ :node |
		  node isOperationDefinition
			  ifTrue: [ node ]
			  ifFalse: [ nil ] ]
]

{ #category : 'accessing' }
ViennaRemoveOperation >> sortingOrder [
	^ 1.2
]
