module list menu
loadSnapshotFromFile
	self
		fileOpen: 'Open snapshot...'
		extensions: #('vdmim')
		do: [ :stream | 
			| json |
			json := (NeoJSONReader on: stream) next.
			animation := (json at: 'engineType' ifAbsent: [ nil ]) asSymbol
				in:
					[ :type | type = #transpiler and: [ Smalltalk hasClassNamed: #ViennaTranspiledAnimation ] ].
			[ animation
				specification: (json at: 'specification' ifAbsent: [ '' ])
				ifError: [ :msg | self error: msg ].
			self selectModuleNamed: nil ]
				on: Error
				do: [ :ex | 
					codePane setText: (json at: 'specification').
					codePane hasUnacceptedEdits: true ].
			animation state: (json at: 'state' ifAbsent: [Dictionary new]).
			self acceptWorkspace: (json at: 'workspace' ifAbsent: [ '' ]) ]