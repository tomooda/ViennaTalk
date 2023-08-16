Extension { #name : #ViennaRecordConstructorNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaRecordConstructorNode >> sliceWith: aViennaSlicer [

	| type |
	type := self name resolve.
	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self expressionList do: [ :expression |
			aViennaSlicer read: expression ].
		type inv ifNotNil: [ :inv | aViennaSlicer read: inv ] ].
	self expressionList reverseDo: [ :expression |
		expression sliceWith: aViennaSlicer ].
	type inv ifNotNil: [ :inv | inv sliceWith: aViennaSlicer ]
]
