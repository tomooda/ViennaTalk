utilities
proceed: aText title: aString
	| dialog |
	dialog := ProceedDialogWindow newWithTheme: UIManager default theme.
	dialog title: aString.
	dialog textFont: TextStyle default defaultFont.
	dialog text: aText asText.
	dialog textMorph contents removeAttribute: TextAlignment centered.
	^ (UIManager default openModal: dialog) cancelled not