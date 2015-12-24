private
formatIn: aPluggableTextMorph
	aPluggableTextMorph
		handleEdit: [ 
			[ 
			| formattedSource |
			formattedSource := ViennaVDMParser new parse: aPluggableTextMorph text.
			formattedSource isPetitFailure
				ifFalse: [ 
					aPluggableTextMorph textMorph newContents: formattedSource.
					aPluggableTextMorph hasUnacceptedEdits: true ] ]
				on: Error
				do: [ :ex |  ] ]