module list menu
newAndLoadFromFile
	self
		fileOpen: 'New and load from...'
		do: [ :stream | 
			stream contents
				in: [ :source | 
					[ 
					vdmc specification: source ifError: [ :msg | self error: msg ].
					self selectModuleNamed: nil ]
						on: Error
						do: [ :ex | 
							codePane setText: source.
							codePane hasUnacceptedEdits: true ] ] ]