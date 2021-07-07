Class {
	#name : #ViennaMoveFunction,
	#superclass : #ViennaMove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaMoveFunction >> findDefinitionNode [
	ast ifNil: [ ^ nil ].
	ast resolve
		ifNotNil: [ :defNode | 
			(#('ExplicitFunctionDefinition' 'ImplicitFunctionDefinition')
				includes: defNode label)
				ifTrue: [ ^ defNode ] ].
	^ nil
]
