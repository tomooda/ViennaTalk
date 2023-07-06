Class {
	#name : #ViennaMoveFunction,
	#superclass : #ViennaMove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaMoveFunction >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast resolve ifNotNil: [ :defNode |
		defNode isViennaExplicitFunctionDefinitionNode ifTrue: [
			^ defNode asAccessDefinition ].
		defNode isViennaImplicitFunctionDefinitionNode ifTrue: [
			^ defNode asAccessDefinition ] ].
	^ nil
]
