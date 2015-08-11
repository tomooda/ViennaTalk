code pane
code
	| section module |
	vdmc ifNil: [ ^ String new ].
	module := self selectedModule.
	module ifNil: [ ^ self specificationTemplate ].
	section := ((self modulePositionsFrom: vdmc specification)
		detect: [ :assoc | assoc key = module ]
		ifNone: [ ^ self specificationTemplate ]) value.
	^ vdmc specification copyFrom: section first to: section last