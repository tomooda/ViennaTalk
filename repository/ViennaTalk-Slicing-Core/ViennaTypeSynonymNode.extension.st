Extension { #name : 'ViennaTypeSynonymNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTypeSynonymNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self inv ifNotNil: [ :inv | aViennaSlicer read: inv ] ].
	self inv ifNotNil: [ :inv | inv sliceWith: aViennaSlicer ]
]
