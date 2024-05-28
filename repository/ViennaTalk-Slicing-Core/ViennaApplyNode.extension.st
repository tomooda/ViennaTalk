Extension { #name : 'ViennaApplyNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaApplyNode >> sliceWith: aViennaSlicer [

	| callee |
	aViennaSlicer onNode: self do: [
		aViennaSlicer
			write: self;
			read: self expression.
		self argumentExpressionList do: [ :expression |
			aViennaSlicer read: expression ] ].
	aViennaSlicer
		onNode: self
		do: [ aViennaSlicer call: self expression ].
	self expression sliceWith: aViennaSlicer.
	callee := self expression resolve.
	callee isFunctionDefinition ifTrue: [
		self argumentExpressionList asArray
			with: callee parametersList first asArray
			do: [ :arg :param |
				aViennaSlicer onNode: self do: [
					aViennaSlicer
						write: param;
						read: arg ] ] ].
	callee isOperationDefinition ifTrue: [
		self argumentExpressionList asArray
			with: callee parameters asArray
			do: [ :arg :param |
				aViennaSlicer onNode: self do: [
					aViennaSlicer
						write: param;
						read: arg ] ] ].
	self arguments do: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
