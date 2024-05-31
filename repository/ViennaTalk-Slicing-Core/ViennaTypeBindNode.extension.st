Extension { #name : 'ViennaTypeBindNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaTypeBindNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		aViennaSlicer read: self type.
		aViennaSlicer read: self pattern ].
	self pattern sliceWith: aViennaSlicer.
	self type sliceWith: aViennaSlicer.
	(self type resolve ifNotNil: #inv) ifNotNil: [ :inv |
		inv sliceWith: aViennaSlicer ]
]
