Class {
	#name : #ViennaRemoveEmptySection,
	#superclass : #ViennaRemove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRemoveEmptySection >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRemoveEmptySection >> execute [

	^ self definitionNode parent
		  remove: self definitionNode;
		  yourself
]

{ #category : #accessing }
ViennaRemoveEmptySection >> findDefinitionNode [

	ast isViennaSectionNode ifFalse: [ ^ nil ].
	ast isEmpty ifTrue: [ ^ ast ].
	^ nil
]

{ #category : #accessing }
ViennaRemoveEmptySection >> name [

	^ 'Remove ' , self definitionNode sectionName asText allBold
	  , ' section'
]

{ #category : #accessing }
ViennaRemoveEmptySection >> sortingOrder [
	^ 0.1
]
