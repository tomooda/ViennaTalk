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
			(#('ExplicitOperationDefinition' 'ImplicitOperationDefinition')
				includes: defNode label)
				ifFalse: [ ^ nil ].
			defNode label = 'ExplicitOperationDefinition'
				ifTrue: [ defNode fifth
						allDescendantsDo: [ :node | 
							(node label = 'LocalName' and: [ node isStateVariableNameNode ])
								ifTrue: [ ^ nil ] ] ].
			(defNode label = 'ImplicitOperationDefinition'
				and: [ defNode third notEmpty ])
				ifTrue: [ ^ nil ].
			^ defNode ].
	^ nil
]
