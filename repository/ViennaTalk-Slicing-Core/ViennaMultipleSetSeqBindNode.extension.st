Extension { #name : #ViennaMultipleSetSeqBindNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaMultipleSetSeqBindNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		aViennaSlicer read: self expression.
		self patternList do: [ :pattern | aViennaSlicer read: pattern ] ].
	self patternList reverseDo: [ :pattern |
		pattern sliceWith: aViennaSlicer ].
	self expression sliceWith: aViennaSlicer
]
