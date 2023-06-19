Class {
	#name : #ViennaUseTypeInAllOccurrences,
	#superclass : #ViennaUseInAllOccurrences,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseTypeInAllOccurrences >> execute [

	ast module allDescendantsDo: [ :node |
		((node includesParent: self definitionNode) not and: [ node = ast ])
			ifTrue: [
				self replaceNode: node with: (ViennaTypeNameNode name:
						 (ViennaLocalNameNode identifier: self identifier)) ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseTypeInAllOccurrences >> findDefinitionNode [

	ast module ifNotNil: [ :node |
		node third do: [ :definitionBlock |
			definitionBlock first isViennaTypeDefinitionsNode ifTrue: [
				definitionBlock first do: [ :accessTypeDef |
					accessTypeDef second ifNotNil: [ :typeDef |
						(ast = typeDef second and: [
							 typeDef third isNil and: [ (ast includesParent: typeDef) not ] ])
							ifTrue: [ ^ typeDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseTypeInAllOccurrences >> identifier [
	^ self definitionNode ifNotNil: #first
]
