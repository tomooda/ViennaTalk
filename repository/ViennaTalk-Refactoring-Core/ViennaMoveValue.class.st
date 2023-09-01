Class {
	#name : #ViennaMoveValue,
	#superclass : #ViennaMove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaMoveValue >> definitionNames [

	^ self definitionNode patternIdentifiers collect: #identifier
]

{ #category : #accessing }
ViennaMoveValue >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast resolve ifNotNil: [ :defNode |
		defNode isViennaValueDefinitionNode ifTrue: [ ^ defNode ] ].
	^ nil
]
