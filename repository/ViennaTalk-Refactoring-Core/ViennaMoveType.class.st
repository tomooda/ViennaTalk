Class {
	#name : #ViennaMoveType,
	#superclass : #ViennaMove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaMoveType >> findDefinitionNode [
	ast ifNil: [ ^ nil ].
	ast resolve
		ifNotNil: [ :defNode | 
			(#('TypeDefinition' 'RecordTypeDefinition') includes: defNode label)
				ifTrue: [ ^ defNode ] ].
	^ nil
]
