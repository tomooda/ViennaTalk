Class {
	#name : #ViennaUseValueInAllOccurrences,
	#superclass : #ViennaUseValue,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> execute [
	ast module
		allDescendantsDo: [ :node | 
			((node includesParent: self definitionNode) not
				and: [ node sameAs: ast ])
				ifTrue: [ self
						replaceNode: node
						with: (ViennaNode label: 'LocalName' with: self definitionNode first first) ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> findDefinitionNode [
	ast module
		ifNotNil: [ :node | 
			node third
				do: [ :definitionBlock | 
					definitionBlock first label = 'ValueDefinitions'
						ifTrue: [ definitionBlock first
								do: [ :accessValueDef | 
									accessValueDef second
										ifNotNil: [ :valueDef | 
											((ast sameAs: valueDef third)
												and: [ valueDef first label = 'PatternIdentifier' ])
												ifTrue: [ ^ valueDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> name [
	^ 'use ' , self definitionNode first source asText allBold , ' for all occurrences of '
		, self ast source asText allBold
]

{ #category : #accessing }
ViennaUseValueInAllOccurrences >> sortingOrder [
	^ 2.12
]
