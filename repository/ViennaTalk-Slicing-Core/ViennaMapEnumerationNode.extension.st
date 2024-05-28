Extension { #name : 'ViennaMapEnumerationNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaMapEnumerationNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self do: [ :maplet |
			aViennaSlicer
				read: maplet keyExpression;
				read: maplet valueExpression ] ].
	self reverseDo: [ :maplet |
		maplet valueExpression sliceWith: aViennaSlicer.
		maplet keyExpression sliceWith: aViennaSlicer ]
]
