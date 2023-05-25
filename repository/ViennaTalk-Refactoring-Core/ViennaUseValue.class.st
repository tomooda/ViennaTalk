Class {
	#name : #ViennaUseValue,
	#superclass : #ViennaUse,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaUseValue >> execute [

	^ self
		  replaceNode: ast
		  with: (ViennaLocalNameNode identifier: self identifier)
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
ViennaUseValue >> identifier [
	^ (self definitionNode ifNotNil: #first) ifNotNil: #first
]
