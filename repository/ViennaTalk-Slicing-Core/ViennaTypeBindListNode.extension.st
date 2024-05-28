Extension { #name : 'ViennaTypeBindListNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTypeBindListNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :typeBind | aViennaSlicer read: typeBind ] ].
	self reverseDo: [ :typeBind | typeBind sliceWith: aViennaSlicer ]
]
