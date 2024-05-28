Extension { #name : 'ViennaRecordModifierNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaRecordModifierNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		aViennaSlicer read: self expression.
		self mapletList do: [ :map |
			aViennaSlicer read: map valueExpression ] ].
	self mapletList reverseDo: [ :maplet |
		maplet valueExpression sliceWith: aViennaSlicer ].
	self expression sliceWith: aViennaSlicer
]
