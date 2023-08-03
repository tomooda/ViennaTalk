Extension { #name : #ViennaFunctionTypeInstantiationNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaFunctionTypeInstantiationNode >> sliceWith: aViennaSlicer [

	| functionDefinition |
	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression.
		self functionTypeArgs do: [ :type | aViennaSlicer read: type ] ].
	self expression sliceWith: aViennaSlicer.
	functionDefinition := self expression resolve.
	functionDefinition isFunctionDefinition ifTrue: [
		aViennaSlicer onNode: self do: [
			self functionTypeArgs asArray
				with: functionDefinition typeVariableList asArray
				do: [ :type :typeVar |
					aViennaSlicer
						write: typeVar;
						read: type ] ].
		self functionTypeArgs reverseDo: [ :type |
			type sliceWith: aViennaSlicer ] ]
]
