module list menu
removeModule
	self selectedModule
		ifNotNil: [ :moduleName | 
			| position newSpecification oldSpecification |
			position := ((self modulePositionsFrom: vdmc specification)
				detect: [ :assoc | assoc key = moduleName ]
				ifNone: [ ^ false ]) value.
			newSpecification := (vdmc specification copyFrom: 1 to: position first - 1)
				, (vdmc specification copyFrom: position last + 1 to: vdmc specification size).
			oldSpecification := vdmc specification.
			vdmc specification: newSpecification.
			vdmc
				plainEvaluate: 'nil'
				ifError: [ :msg | 
					vdmc specification: oldSpecification.
					UIManager default abort: msg title: 'VDM Error'.
					^ false ].
			self changed: #moduleList.
			self selectModuleNamed: nil.
			^ true ]