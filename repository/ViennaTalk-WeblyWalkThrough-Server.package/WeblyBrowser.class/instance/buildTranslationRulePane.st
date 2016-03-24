user interface
buildTranslationRulePane
	^ (PluggableTextMorph
		on: self
		text: #translationRule
		accept: #acceptTranslationRule:
		readSelection: #translationRuleSelection
		menu: #translationPaneMenu:shifted:
		setSelection: #translationRuleSelection:)
		setBalloonText: 'VDM - JSON translation rule';
		font: ViennaLauncher font;
		yourself