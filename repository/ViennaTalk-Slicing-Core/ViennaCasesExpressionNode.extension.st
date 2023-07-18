Extension { #name : #ViennaCasesExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaCasesExpressionNode >> sliceWith: aViennaSlicer [

	| branchSlicer |
	branchSlicer := aViennaSlicer branch.
	branchSlicer value: [ :slicer |
		self othersExpression sliceWith: slicer ].
	self casesExpressionAlternatives reverseDo: [ :alternative |
		branchSlicer value: [ :slicer |
			alternative expression sliceWith: slicer ] ].
	branchSlicer value: nil.
	self expression sliceWith: aViennaSlicer
]
