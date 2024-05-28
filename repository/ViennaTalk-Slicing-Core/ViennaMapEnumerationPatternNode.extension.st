Extension { #name : 'ViennaMapEnumerationPatternNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapEnumerationPatternNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :mapPattern | aViennaSlicer read: mapPattern ] ].
	self reverseDo: [ :mapletPattern |
		mapletPattern sliceWith: aViennaSlicer ]
]
