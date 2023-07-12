Class {
	#name : #ViennaUseTypeSynonymInAllOccurrences,
	#superclass : #ViennaUseInAllOccurrences,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseTypeSynonymInAllOccurrences >> execute [

	ast module allDescendantsDo: [ :node |
		((node includesParent: self definitionNode) not and: [
			 node = self definitionNode type ]) ifTrue: [
			self replaceNode: node with: (ViennaTypeNameNode name:
					 (ViennaLocalNameNode identifier: self definitionNode identifier)) ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseTypeSynonymInAllOccurrences >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	^ ast localResolve ifNotNil: [ :def |
		  | accessDef |
		  accessDef := def asAccessDefinition.
		  (accessDef isViennaAccessTypeDefinitionNode and: [
			   accessDef isViennaTypeSynonymNode and: [ accessDef inv isNil ] ])
			  ifTrue: [ accessDef ] ]
]

{ #category : #accessing }
ViennaUseTypeSynonymInAllOccurrences >> identifier [
	^ self definitionNode ifNotNil: #first
]
