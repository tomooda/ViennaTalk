utilities
proceed: aText title: aString
	| dialog |
	dialog := ProceedDialogWindow newWithTheme: UIManager default theme.
	dialog title: aString.
	dialog textFont: TextStyle default defaultFont.
	dialog text: aText asText.
	dialog textMorph contents removeAttribute: TextAlignment centered.
	dialog textMorph height > 600
		ifTrue: [ 
			"dialog textMorph delete.
		dialog textMorph autoFit: false.
		dialog textMorph height: 600."
			dialog textMorph owner
				addMorphBack:
					((dialog newScrollPaneFor: dialog textMorph)
						extent: (dialog textMorph width + 100) @ 600;
						yourself) ].
	^ (UIManager default openModal: dialog) cancelled not