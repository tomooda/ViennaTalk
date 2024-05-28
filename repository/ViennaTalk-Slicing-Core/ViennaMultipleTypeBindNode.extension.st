Extension { #name : 'ViennaMultipleTypeBindNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMultipleTypeBindNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		aViennaSlicer read: self type.
		self patternList do: [ :pattern | aViennaSlicer read: pattern ] ].
	self patternList reverseDo: [ :pattern |
		pattern sliceWith: aViennaSlicer ].
	self type sliceWith: aViennaSlicer
]
