translation pane
acceptTranslationRule: aString
	| newTranslator |
	newTranslator := WWTTranslationRuleParser new parse: aString asString.
	newTranslator isPetitFailure
		ifTrue: [ ^ false ].
	vdmc translator: newTranslator.
	^ true