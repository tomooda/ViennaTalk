Class {
	#name : #ViennaMoveOperation,
	#superclass : #ViennaMove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaMoveOperation >> findDefinitionNode [
	ast ifNil: [ ^ nil ].
	ast resolve
		ifNotNil: [ :defNode | 
			'ExplicitOperationDefinition' = defNode label
				ifFalse: [ ^ nil ].
			defNode fifth
				allDescendantsDo: [ :node | 
					(node label = 'LocalName' and: [ node isStateVariableNameNode ])
						ifTrue: [ ^ nil ] ].
			^ defNode ].
	^ nil
]
