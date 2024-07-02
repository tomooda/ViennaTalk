Class {
	#name : 'ViennaMoveOperation',
	#superclass : 'ViennaMove',
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'accessing' }
ViennaMoveOperation >> findDefinitionNode [

	ast ifNil: [ ^ nil ].
	ast resolve ifNotNil: [ :defNode |
		(defNode isViennaExplicitOperationDefinitionNode or: [
			 defNode isViennaImplicitOperationDefinitionNode ]) ifFalse: [
			^ nil ].
		defNode isViennaExplicitOperationDefinitionNode ifTrue: [
			defNode statement allDescendantsDo: [ :node |
				(node isViennaLocalNameNode and: [ node isStateVariableNameNode ])
					ifTrue: [ ^ nil ] ] ].
		(defNode isViennaImplicitOperationDefinitionNode and: [
			 defNode externals notEmpty ]) ifTrue: [ ^ nil ].
		^ defNode ].
	^ nil
]
