Extension { #name : 'ViennaSeqConcPatternNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaSeqConcPatternNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :pattern | aViennaSlicer read: pattern ] ].
	self reverseDo: [ :pattern | pattern sliceWith: aViennaSlicer ]
]
