Class {
	#name : #ViennaUseValue,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'definitionNode'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseValue >> check [
	^ self definitionNode notNil
]

{ #category : #accessing }
ViennaUseValue >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : #accessing }
ViennaUseValue >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : #operations }
ViennaUseValue >> execute [
	^ self
		replaceNode: ast
		with: (ViennaNode label: 'LocalName' with: self definitionNode first first)
]

{ #category : #accessing }
ViennaUseValue >> findDefinitionNode [
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
												and: [ valueDef first label = 'PatternIdentifier'
														and: [ (ast includesParent: valueDef) not ] ])
												ifTrue: [ ^ valueDef ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaUseValue >> name [
	^ 'Use ' , self definitionNode first source asText allBold , ' for '
		, self ast source asText allBold
]

{ #category : #accessing }
ViennaUseValue >> sortingOrder [
	^ 2.11
]
