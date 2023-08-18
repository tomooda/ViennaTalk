Extension { #name : #ViennaBindListNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaBindListNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :bind | aViennaSlicer read: bind ] ].
	self reverseDo: [ :bind | bind sliceWith: aViennaSlicer ]
]
