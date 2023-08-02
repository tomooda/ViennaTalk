Extension { #name : #ViennaTixeStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaTixeStatementNode >> sliceWith: aViennaSlicer [

	| exits branchSlicer |
	exits := Array streamContents: [ :stream |
		         self statement
			         allDescendantsSuchThat: #isViennaExitStatementNode
			         do: [ :exit | stream nextPut: exit ] ].
	branchSlicer := aViennaSlicer branch.
	branchSlicer value: [ :slicer | self statement sliceWith: slicer ].
	self patternsAndStatementsDo: [ :pattern :statement |
		branchSlicer value: [ :slicer |
			statement sliceWith: slicer.
			slicer onNode: self do: [
				slicer write: self.
				exits do: [ :exit | slicer read: exit ] ].
			self statement sliceWith: slicer ] ].
	branchSlicer value: nil
]
