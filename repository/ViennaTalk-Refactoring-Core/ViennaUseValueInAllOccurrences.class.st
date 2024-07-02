Class {
	#name : 'ViennaUseValueInAllOccurrences',
	#superclass : 'ViennaUseInAllOccurrences',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaUseValueInAllOccurrences >> execute [

	ast module allDescendantsDo: [ :node |
		((node includesParent: self definitionNode) not and: [
			 node = self definitionNode expression ]) ifTrue: [
			| binds expression |
			binds := (self definitionNode pattern uniqueBoundIdentifiers
				          collect: [ :string |
				          string -> (ViennaLocalNameNode identifier: string) ])
				         asDictionary.
			expression := self
				              expressionFromPattern: self definitionNode pattern
				              bindings: binds.
			^ self replaceNode: node with: expression ] ].
	^ nil
]

{ #category : 'accessing' }
ViennaUseValueInAllOccurrences >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	^ ast localResolve ifNotNil: [ :def |
		  def isViennaValueDefinitionNode ifTrue: [ def ] ]
]

{ #category : 'accessing' }
ViennaUseValueInAllOccurrences >> identifier [

	^ (self definitionNode ifNotNil: #pattern) source
]
