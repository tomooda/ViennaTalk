Extension { #name : #ViennaCompositeTypeNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaCompositeTypeNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self fieldList do: [ :field | aViennaSlicer read: field type ] ].
	self fieldList reverseDo: [ :field | field sliceWith: aViennaSlicer ]
]
