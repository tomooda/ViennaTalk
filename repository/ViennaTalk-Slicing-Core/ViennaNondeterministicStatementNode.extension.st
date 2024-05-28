Extension { #name : 'ViennaNondeterministicStatementNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaNondeterministicStatementNode >> sliceWith: aViennaSlicer [

	| branchSlicer |
	branchSlicer := aViennaSlicer branch.
	self asArray permutationsDo: [ :statements |
		branchSlicer value: [ :slicer |
			statements do: [ :statement | statement sliceWith: slicer ] ] ].
	branchSlicer value: nil
]
