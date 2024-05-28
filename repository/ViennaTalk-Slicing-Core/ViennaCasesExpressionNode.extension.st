Extension { #name : 'ViennaCasesExpressionNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaCasesExpressionNode >> sliceWith: aViennaSlicer [

	| branchSlicer |
	branchSlicer := aViennaSlicer branch.
	branchSlicer value: [ :slicer |
		slicer onNode: self othersExpression do: [
			slicer write: self.
			slicer read: self othersExpression expression ].
		self othersExpression expression sliceWith: slicer.
		aViennaSlicer control: self expression ].
	self casesExpressionAlternatives reverseDo: [ :alternative |
		branchSlicer value: [ :slicer |
			slicer onNode: alternative do: [
				slicer write: self.
				slicer read: alternative expression ].
			alternative expression sliceWith: slicer.
			slicer onNode: alternative do: [
				slicer
					write: alternative;
					read: self expression.
				alternative patternList do: [ :pattern | slicer read: pattern ] ].
			alternative patternList reverseDo: [ :pattern |
				pattern sliceWith: slicer ] ] ].
	branchSlicer value: nil.
	self expression sliceWith: aViennaSlicer
]
