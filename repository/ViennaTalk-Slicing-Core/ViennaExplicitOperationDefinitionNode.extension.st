Extension { #name : 'ViennaExplicitOperationDefinitionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaExplicitOperationDefinitionNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self.
	aViennaSlicer startNode ifNotNil: [ :startNode |
		self pre ifNotNil: [ :pre |
			(startNode includesParent: pre) ifTrue: [
				^ startNode sliceWith: aViennaSlicer ] ].
		self post ifNotNil: [ :post |
			(startNode includesParent: post) ifTrue: [
				^ startNode sliceWith: aViennaSlicer ] ] ].
	self statement sliceWith: aViennaSlicer
]
