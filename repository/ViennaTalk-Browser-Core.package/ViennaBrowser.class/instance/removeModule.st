module list menu
removeModule
	self selectedModule
		ifNotNil: [ :moduleName | 
			| position newSpecification oldSpecification |
			position := ((self modulePositionsFrom: animation specification)
				detect: [ :assoc | assoc key = moduleName ]
				ifNone: [ ^ false ]) value.
			newSpecification := (animation specification copyFrom: 1 to: position first - 1)
				, (animation specification copyFrom: position last + 1 to: animation specification size).
			oldSpecification := animation specification.
			animation specification: newSpecification.
			animation
				plainEvaluate: 'nil'
				ifError: [ :msg | 
					animation specification: oldSpecification.
					UIManager default abort: msg title: 'VDM Error'.
					^ false ].
			self changed: #moduleList.
			self selectModuleNamed: nil.
			^ true ]