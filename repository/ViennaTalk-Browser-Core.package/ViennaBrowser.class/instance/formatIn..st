private
formatIn: aPluggableTextMorph
	aPluggableTextMorph
		handleEdit: [ 
			[ 
			aPluggableTextMorph textMorph newContents: (ViennaVDMParser new parse: aPluggableTextMorph text) format.
			aPluggableTextMorph hasUnacceptedEdits: true ]
				on: Error
				do: [ :ex |  ] ]