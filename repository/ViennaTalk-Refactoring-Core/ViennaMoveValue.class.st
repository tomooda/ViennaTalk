Class {
	#name : #ViennaMoveValue,
	#superclass : #ViennaMove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaMoveValue >> definitionNames [
	^ Array
		streamContents: [ :stream | 
			self definitionNode
				allDescendantsDo: [ :node | 
					node label = 'PatternIdentifier'
						ifTrue: [ stream nextPut: node first ] ] ]
]

{ #category : #accessing }
ViennaMoveValue >> findDefinitionNode [
	ast ifNil: [ ^ nil ].
	ast resolve
		ifNotNil: [ :defNode | 
			defNode label = 'ValueDefinition'
				ifTrue: [ ^ defNode ] ].
	^ nil
]
