Extension { #name : #ViennaApplyNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaApplyNode >> sliceWith: aViennaSlicer [

	| functionDefinition |
	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression.
		self argumentExpressionList do: [ :expression |
			aViennaSlicer read: expression ] ].
	aViennaSlicer call: self expression.
	self expression sliceWith: aViennaSlicer.
	functionDefinition := self expression resolve.
	functionDefinition isFunctionDefinition ifTrue: [
		self argumentExpressionList asArray
			with: functionDefinition parametersList first asArray
			do: [ :arg :param |
				aViennaSlicer onNode: self do: [
					aViennaSlicer
						write: param;
						read: arg ] ] ].
	self arguments do: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
