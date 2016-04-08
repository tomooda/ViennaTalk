editor access
handleEdit: aBlock
	^ [ super handleEdit: aBlock ]
		ensure: [ wantsHighlighting := true ]