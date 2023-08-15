Extension { #name : #ViennaPreconditionExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaPreconditionExpressionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :expression | aViennaSlicer read: expression ] ].
	self reverseDo: [ :expression | expression sliceWith: aViennaSlicer ]
]
