Class {
	#name : #ViennaMoveOperation,
	#superclass : #ViennaMove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaMoveOperation >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast resolve ifNotNil: [ :defNode |
		(defNode isViennaExplicitOperationDefinitionNode or: [
			 defNode isViennaImplicitOperationDefinitionNode ]) ifFalse: [
			^ nil ].
		defNode isViennaExplicitOperationDefinitionNode ifTrue: [
			defNode operationBody allDescendantsDo: [ :node |
				(node isViennaLocalNameNode and: [ node isStateVariableNameNode ])
					ifTrue: [ ^ nil ] ] ].
		(defNode isViennaImplicitOperationDefinitionNode and: [
			 defNode third notEmpty ]) ifTrue: [ ^ nil ].
		^ defNode ].
	^ nil
]
