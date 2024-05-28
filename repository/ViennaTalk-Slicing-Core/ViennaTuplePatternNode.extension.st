Extension { #name : 'ViennaTuplePatternNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTuplePatternNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self patternList do: [ :pattern | aViennaSlicer read: pattern ] ].
	self patternList reverseDo: [ :pattern |
		pattern sliceWith: aViennaSlicer ]
]
