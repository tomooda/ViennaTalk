Extension { #name : #ViennaPatternListNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaPatternListNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :pattern | aViennaSlicer read: pattern ] ].
	self reverseDo: [ :pattern | pattern sliceWith: aViennaSlicer ]
]
