user interface
build
	| pane webapiPane |
	translationRulePane := self buildTranslationRulePane.
	portField := self buildPortField.
	publishButton := self buildPublishButton.
	pane := super build.
	webapiPane := Morph new.
	webapiPane changeProportionalLayout.
	webapiPane
		addMorph: portField
		fullFrame:
			((0 @ 1 corner: 1 @ 1) asLayoutFrame
				rightOffset: -100;
				topOffset: -32;
				yourself).
	webapiPane
		addMorph: publishButton
		fullFrame:
			((1 @ 1 corner: 1 @ 1) asLayoutFrame
				leftOffset: -100;
				topOffset: -32;
				yourself).
	webapiPane
		addMorph: translationRulePane
		fullFrame:
			((0 @ 0 corner: 1 @ 1) asLayoutFrame
				bottomOffset: -32;
				yourself).
	lowerTabPane addLazyPage: webapiPane label: 'Web API'.
	^ pane