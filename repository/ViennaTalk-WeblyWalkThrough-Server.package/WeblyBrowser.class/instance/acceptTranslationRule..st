translation pane
acceptTranslationRule: aString
	| newTranslator |
	newTranslator := WWTTranslationRuleParser new parse: aString asString.
	newTranslator isPetitFailure
		ifTrue: [ ^ false ].
	animation translator: newTranslator.
	^ true