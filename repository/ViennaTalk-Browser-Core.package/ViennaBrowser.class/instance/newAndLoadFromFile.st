module list menu
newAndLoadFromFile
	self
		fileOpen: 'New and load from...'
		do: [ :stream | 
			stream contents
				in: [ :source | 
					[ self vdmc specification: source ]
						on: Error
						do: [ :ex | 
							codePane setText: source.
							codePane hasUnacceptedEdits: true ] ] ]