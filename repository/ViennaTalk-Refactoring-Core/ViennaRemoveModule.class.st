Class {
	#name : 'ViennaRemoveModule',
	#superclass : 'ViennaRemove',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaRemoveModule >> check [

	self definitionNode ifNil: [ ^ false ].
	self definitionNode isReferenced ifTrue: [ ^ false ].
	^ true
]

{ #category : 'operations' }
ViennaRemoveModule >> execute [

	^ self definitionNode parent
		  remove: self definitionNode;
		  yourself
]

{ #category : 'accessing' }
ViennaRemoveModule >> findDefinitionNode [

	ast isViennaModuleNode ifTrue: [ ^ ast ].
	^ nil
]

{ #category : 'accessing' }
ViennaRemoveModule >> sortingOrder [
	^ 10.0
]
