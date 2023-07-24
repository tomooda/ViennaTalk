Extension { #name : #ViennaIfStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaIfStatementNode >> sliceWith: aViennaSlicer [

	| branchSlicer |
	branchSlicer := aViennaSlicer branch.
	self statement ifNotNil: [ :statement |
		branchSlicer value: [ :slicer |
			statement sliceWith: slicer.
			self conditionalStatementList reverseDo: [ :conditionalStatement |
				conditionalStatement condition sliceWith: slicer ] ] ].
	self conditionalStatementList size to: 1 by: -1 do: [ :index |
		branchSlicer value: [ :slicer |
			(self conditionalStatementList at: index) statement sliceWith:
				slicer.
			index to: 1 by: -1 do: [ :i |
				(self conditionalStatementList at: i) condition sliceWith: slicer ] ] ].
	branchSlicer value: nil
]
