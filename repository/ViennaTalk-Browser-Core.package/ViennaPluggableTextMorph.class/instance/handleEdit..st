as yet unclassified
handleEdit: aBlock
	^ [ super handleEdit: aBlock ]
		ensure: [ wantsHighlighting := true ]