Class {
	#name : #ViennaRenameLocal,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameLocal >> check [

	^ self definitionNode notNil and: [
		  (self definitionNode lookupIdentifier: self oldName) respondsTo:
			  #identifier: ]
]

{ #category : #accessing }
ViennaRenameLocal >> construct [
	^ 'local variable'
]

{ #category : #operations }
ViennaRenameLocal >> execute [

	self newName ifNil: [ ^ nil ].
	self oldName = self newName ifTrue: [ ^ nil ].
	(self definitionNode lookupIdentifier: self oldName) identifier:
		self newName.
	self definitionNode
		freeIdentifiersExcept: Set new
		do: [ :identifier :node |
			identifier = self oldName ifTrue: [ node identifier: self newName ] ].
	^ nil
]

{ #category : #accessing }
ViennaRenameLocal >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast isViennaLocalNameNode ifFalse: [ ^ nil ].
	(ast findResolverForIdentifier: ast identifier) ifNotNil: [ :resolver |
		resolver isViennaModuleNode ifTrue: [ ^ nil ].
		^ resolver ].
	^ nil
]

{ #category : #accessing }
ViennaRenameLocal >> findOldName [

	^ ast ifNotNil: #identifier
]

{ #category : #accessing }
ViennaRenameLocal >> sortingOrder [
	^ 1.2
]
