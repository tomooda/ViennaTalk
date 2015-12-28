user interface
build
	| pane |
	translationRulePane := self buildTranslationRulePane.
	pane := super build.
	lowerTabPane addLazyPage: translationRulePane label: 'Translation'.
	^ pane