code pane
code
	| section module |
	animation ifNil: [ ^ String new ].
	module := self selectedModule.
	module ifNil: [ ^ self specificationTemplate ].
	section := ((self modulePositionsFrom: animation specification)
		detect: [ :assoc | assoc key = module ]
		ifNone: [ ^ self specificationTemplate ]) value.
	^ (animation specification copyFrom: section first to: section last) asText makeAllColor: Color black