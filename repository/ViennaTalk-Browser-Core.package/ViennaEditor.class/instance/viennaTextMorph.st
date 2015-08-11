accessing
viennaTextMorph
	| textMorph |
	textMorph := morph.
	[ textMorph notNil and: [ textMorph isKindOf: ViennaPluggableTextMorph ] ] whileFalse: [ textMorph := textMorph owner ].
	^ textMorph