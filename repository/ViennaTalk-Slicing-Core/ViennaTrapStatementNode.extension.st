Extension { #name : #ViennaTrapStatementNode }

{ #category : #'*ViennaTalk-Slicing-Core' }
ViennaTrapStatementNode >> sliceWith: aViennaSlicer [

	| exits branchSlicer |
	exits := Array streamContents: [ :stream |
		         self statement
			         allDescendantsSuchThat: #isViennaExitStatementNode
			         do: [ :exit | stream nextPut: exit ] ].
	branchSlicer := aViennaSlicer branch.
	branchSlicer value: [ :slicer | self statement sliceWith: slicer ].
	branchSlicer value: [ :slicer |
		self handlerStatement sliceWith: slicer.
		slicer onNode: self do: [
			slicer write: self.
			exits do: [ :exit | slicer read: exit ] ].
		self statement sliceWith: slicer ].
	branchSlicer value: nil
]
