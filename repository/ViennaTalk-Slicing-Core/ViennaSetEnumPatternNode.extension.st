Extension { #name : 'ViennaSetEnumPatternNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaSetEnumPatternNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :pattern | aViennaSlicer read: pattern ] ].
	self reverseDo: [ :pattern | pattern sliceWith: aViennaSlicer ]
]
