private
updateState
	"| newState |
	newState := (vdmj
				ifNotNil: [selectedModule
						ifNotNil: [vdmj stateAt: selectedModule]])
				ifNil: [Array new].
	newState ~= state
		ifTrue: [state := newState.
			self updateContents.
			self changed: #moduleList.
			self changed: #moduleSelectionIndex.
			self changed: #fieldList.
			self changed: #fieldSelectionIndex.
			self changed: #contents.
			self changed: #state]"