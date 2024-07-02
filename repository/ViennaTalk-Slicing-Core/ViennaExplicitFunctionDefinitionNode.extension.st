Extension { #name : 'ViennaExplicitFunctionDefinitionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaExplicitFunctionDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self.
	aViennaSlicer startNode ifNotNil: [ :startNode |
		self pre ifNotNil: [ :pre |
			(startNode includesParent: pre) ifTrue: [
				^ startNode sliceWith: aViennaSlicer ] ].
		self post ifNotNil: [ :post |
			(startNode includesParent: post) ifTrue: [
				^ startNode sliceWith: aViennaSlicer ] ].
		self measure ifNotNil: [ :measure |
			(startNode includesParent: measure) ifTrue: [
				^ startNode sliceWith: aViennaSlicer ] ] ].
	aViennaSlicer
		read: self expression;
		read: self type.
	self typeVariableList do: [ :typeVariable |
		aViennaSlicer read: typeVariable ].
	self expression sliceWith: aViennaSlicer.
	self type sliceWith: aViennaSlicer.
	self parametersList do: [ :parameters |
		parameters do: [ :parameter | parameter sliceWith: aViennaSlicer ] ]
]
