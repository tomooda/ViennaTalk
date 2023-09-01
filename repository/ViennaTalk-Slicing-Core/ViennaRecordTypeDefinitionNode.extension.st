Extension { #name : #ViennaRecordTypeDefinitionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaRecordTypeDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self inv ifNotNil: [ :inv | aViennaSlicer read: inv ] ].
	self inv ifNotNil: [ :inv | inv sliceWith: aViennaSlicer ]
]
