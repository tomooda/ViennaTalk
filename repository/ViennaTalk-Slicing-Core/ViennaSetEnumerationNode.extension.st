Extension { #name : #ViennaSetEnumerationNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaSetEnumerationNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self expressionList do: [ :expression |
			aViennaSlicer read: expression ] ].
	self expressionList reverseDo: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
