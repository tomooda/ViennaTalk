Extension { #name : 'ViennaUnionTypeNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaUnionTypeNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :type | aViennaSlicer read: type ] ].
	self reverseDo: [ :type | type sliceWith: aViennaSlicer ]
]
