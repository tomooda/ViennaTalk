Class {
	#name : #ViennaRemoveModule,
	#superclass : #ViennaRemove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRemoveModule >> check [

	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRemoveModule >> execute [

	^ self definitionNode parent remove: self definitionNode
]

{ #category : #accessing }
ViennaRemoveModule >> findDefinitionNode [

	(ast isViennaModuleNode and: [ ast moduleBody isEmpty ]) ifTrue: [
		^ ast ].
	^ nil
]

{ #category : #accessing }
ViennaRemoveModule >> sortingOrder [
	^ 10.0
]
