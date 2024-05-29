Extension { #name : 'ViennaIfStatementNode' }

{ #category : '*ViennaTalk-Slicing-Core' }
ViennaIfStatementNode >> sliceWith: aViennaSlicer [

	| branchSlicer |
	branchSlicer := aViennaSlicer branch.
	self statement
		ifNil: [ branchSlicer value: [ :slicer |  ] ]
		ifNotNil: [ :statement |
			branchSlicer value: [ :slicer |
				| origin needsControl |
				origin := slicer copy.
				statement sliceWith: slicer.
				needsControl := slicer affectingNodes ~= origin affectingNodes.
				self conditionalStatementList reverseDo: [ :conditionalStatement |
					needsControl ifTrue: [
						slicer control: conditionalStatement condition ].
					conditionalStatement condition sliceWith: slicer ] ] ].
	self conditionalStatementList size to: 1 by: -1 do: [ :index |
		branchSlicer value: [ :slicer |
			| origin needsControl |
			origin := slicer copy.
			(self conditionalStatementList at: index) statement sliceWith:
				slicer.
			needsControl := slicer affectingNodes ~= origin affectingNodes.
			index to: 1 by: -1 do: [ :i |
				| conditionalStatement |
				conditionalStatement := self conditionalStatementList at: i.
				needsControl ifTrue: [
					slicer control: conditionalStatement condition ].
				conditionalStatement condition sliceWith: slicer ] ] ].
	branchSlicer value: nil
]
