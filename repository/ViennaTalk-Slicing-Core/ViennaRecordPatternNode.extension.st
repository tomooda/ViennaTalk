Extension { #name : 'ViennaRecordPatternNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaRecordPatternNode >> sliceWith: aViennaSlicer [

	| type |
	type := self name resolve.
	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self patternList do: [ :pattern | aViennaSlicer read: pattern ] ].
	self patternList reverseDo: [ :pattern |
		pattern sliceWith: aViennaSlicer ]
]
