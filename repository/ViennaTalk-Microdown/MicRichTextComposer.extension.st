Extension { #name : 'MicRichTextComposer' }

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaEvalScript: aScriptBlock [

	| expression expressionText |
	expression := aScriptBlock body asString.
	expressionText := expression asText.
	ViennaVDMHighlighter new
		text: expressionText;
		parse: expression.
	expressionText := expressionText , ((Form extent: 16 @ 22 depth: 32) mergeWith: (self iconNamed: #smallDoIt) at: 0 @ 8) asText.
	expressionText addAttribute: (MicRichTextDoIt new
			 actOnClickBlock: [ :attr :event |
					 | popoverPresenter |
					 popoverPresenter := SpPopoverPresenter new presenter:
							                     (ViennaPopoverExpressionPresenter expression: aScriptBlock execute viennaString).
					 popoverPresenter relativeTo: (SpPresenter new
								  layout: SpBoxLayout new;
								  build;
								  yourself).
					 popoverPresenter bePositionRight.
					 popoverPresenter popupPointingTo: (event hand position + (10 @ -10) extent: 1 @ 1).
					 popoverPresenter takeKeyboardFocus ];
			 yourself).

	canvas << expressionText.
	canvas newLineIfNotAlready
]
