Extension { #name : 'ViennaRecordConstructorNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaRecordConstructorNode >> sliceWith: aViennaSlicer [

	| type |
	type := self name resolve.
	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self expressionList do: [ :expression |
			aViennaSlicer read: expression ] ].
	self expressionList reverseDo: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
