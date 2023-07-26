Extension { #name : #ViennaTuplePatternNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaTuplePatternNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		self patternList do: [ :pattern |
			aViennaSlicer
				read: pattern;
				write: self ] ].
	self patternList reverseDo: [ :pattern |
		pattern sliceWith: aViennaSlicer ]
]
