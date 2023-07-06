Class {
	#name : #ViennaMoveType,
	#superclass : #ViennaMove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaMoveType >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast resolve ifNotNil: [ :defNode |
		defNode isViennaTypeSynonymNode ifTrue: [
			^ defNode asAccessDefinition ].
		defNode isViennaRecordTypeDefinitionNode ifTrue: [
			^ defNode asAccessDefinition ] ].
	^ nil
]
