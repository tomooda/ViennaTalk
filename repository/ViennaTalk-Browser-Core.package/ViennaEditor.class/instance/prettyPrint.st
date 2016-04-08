editing keys
prettyPrint
	[ 
	| formattedSource |
	formattedSource := ViennaVDMParser new format: self text.
	formattedSource isPetitFailure
		ifFalse: [ 
			self selectInvisiblyFrom: 1 to: self paragraph text size.
			self replaceSelectionWith: formattedSource.
			self selectAt: 1 ] ]
		on: Error
		do: [ :ex |  ]