Extension { #name : #ViennaIfExpressionNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaIfExpressionNode >> sliceWith: aViennaSlicer [

	| branchSlicer |
	branchSlicer := aViennaSlicer branch.
	branchSlicer value: [ :slicer |
		slicer onNode: self do: [
			slicer
				write: self;
				read: self expression.
			self conditionalExpressionList do: [ :conditionalExpression |
				slicer read: conditionalExpression condition ] ].
		self expression sliceWith: slicer.
		self conditionalExpressionList reverseDo: [ :conditionalExpression |
			conditionalExpression condition sliceWith: slicer ] ].
	self conditionalExpressionList size to: 1 by: -1 do: [ :index |
		| expression |
		expression := (self conditionalExpressionList at: index) expression.
		branchSlicer value: [ :slicer |
			slicer onNode: self do: [
				slicer
					write: self;
					read: expression.
				index to: 1 by: -1 do: [ :i |
				slicer read: (self conditionalExpressionList at: i) condition ] ].
			expression sliceWith: slicer.
			index to: 1 by: -1 do: [ :i |
				(self conditionalExpressionList at: i) condition sliceWith: slicer ] ] ].
	branchSlicer value: nil
]
