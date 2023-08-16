Extension { #name : #ViennaTupleConstructorNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaTupleConstructorNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self expressionList reverseDo: [ :expression |
			aViennaSlicer read: expression ] ].
	self expressionList reverseDo: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
