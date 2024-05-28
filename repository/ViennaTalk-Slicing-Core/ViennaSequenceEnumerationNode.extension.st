Extension { #name : 'ViennaSequenceEnumerationNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaSequenceEnumerationNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self expressionList do: [ :expression | aViennaSlicer read: expression ] ].
	self expressionList reverseDo: [ :expression | expression sliceWith: aViennaSlicer ]
]
