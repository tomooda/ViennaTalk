Class {
	#name : #ViennaUseType,
	#superclass : #ViennaUse,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseType >> execute [

	^ self replaceNode: ast with: (ViennaTypeNameNode name:
			   (ViennaLocalNameNode identifier: self identifier))
]

{ #category : #accessing }
ViennaUseType >> findDefinitionNode [
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'TypeDefinitions'
						ifTrue: [ definitionBlock first
								do: [ :accessTypeDef | 
									accessTypeDef second
										ifNotNil: [ :typeDef | 
											((ast sameAs: typeDef second)
												and:
													[ typeDef third isNil and: [ (ast includesParent: typeDef) not ] ])
												ifTrue: [ ^ typeDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseType >> identifier [
	^ self definitionNode ifNotNil: #first
]
