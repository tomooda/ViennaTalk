user interface
buildTranslationRulePane
	^ (PluggableTextMorph
		on: self
		text: #translationRule
		accept: #acceptTranslationRule:
		readSelection: #translationRuleSelection
		menu: #translationRulePaneMenu:shifted:
		setSelection: #translationRuleSelection:)
		askBeforeDiscardingEdits: true;
		yourself