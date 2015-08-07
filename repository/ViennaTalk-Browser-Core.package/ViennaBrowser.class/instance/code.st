code pane
code
	| section module |
	vdmc ifNil: [ ^ String new ].
	module := self selectedModule.
	module ifNil: [ ^ vdmc specification ].
	section := ((self modulePositionsFrom: vdmc specification)
		detect: [ :assoc | assoc key = module ]
		ifNone: [ ^ String new ]) value.
	^ vdmc specification copyFrom: section first to: section last