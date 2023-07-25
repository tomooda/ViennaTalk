Extension { #name : #ViennaCasesStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaCasesStatementNode >> sliceWith: aViennaSlicer [

	| origin branchSlicer |
	origin := aViennaSlicer copy.
	branchSlicer := aViennaSlicer branch.
	branchSlicer value: [ :slicer |
		self othersStatement sliceWith: slicer ].
	self casesStatementAlternatives reverseDo: [ :alternative |
		branchSlicer value: [ :slicer |
			alternative statement sliceWith: slicer ] ].
	branchSlicer value: nil.
	origin agenda ~= aViennaSlicer agenda ifTrue: [
		aViennaSlicer control: self expression ].
	self expression sliceWith: aViennaSlicer
]
