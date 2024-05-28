Extension { #name : 'ViennaExplicitFunctionDefinitionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaExplicitFunctionDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression;
			read: self type.
		self typeVariableList do: [ :typeVariable |
			aViennaSlicer read: typeVariable ] ].
	self expression sliceWith: aViennaSlicer.
	self type sliceWith: aViennaSlicer.
	self parametersList do: [ :parameters |
		parameters do: [ :parameter | parameter sliceWith: aViennaSlicer ] ]
]
