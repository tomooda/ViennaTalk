Extension { #name : 'MicRichTextComposer' }

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaEvalBlockScript: aScriptBlock [

	| expression expressionText buttonText |
	aScriptBlock retrievePresenter.
	expression := aScriptBlock body asString trim.
	expressionText := expression asText.
	ViennaVDMHighlighter new
		text: expressionText;
		parse: expression.
	buttonText := ' run ' asText
		              addAttribute: (TextBackgroundColor color: (Color gray: 0.8));
		              yourself.
	buttonText addAttribute: (MicRichTextDoIt new
			 actOnClickBlock: [ :attr :event |
					 | popoverPresenter |
					 popoverPresenter := SpPopoverPresenter new presenter:
							                     (ViennaPopoverExpressionPresenter expression: aScriptBlock execute viennaString).
					 popoverPresenter relativeTo: (SpPresenter new
								  layout: SpBoxLayout new;
								  build;
								  yourself).
					 popoverPresenter bePositionRight.
					 popoverPresenter popupPointingTo: (event hand position + (10 @ -20) extent: 1 @ 1).
					 popoverPresenter takeKeyboardFocus ];
			 yourself).
	canvas << expressionText << ' ' asText << buttonText.
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaExecBlockScript: aScriptBlock [

	| expression expressionText buttonText |
	aScriptBlock retrievePresenter.
	expression := aScriptBlock body asString trim.
	expressionText := expression asText.
	ViennaVDMHighlighter new
		text: expressionText;
		parse: expression.
	buttonText := ' run ' asText
		              addAttribute: (TextBackgroundColor color: (Color gray: 0.8));
		              yourself.
	buttonText addAttribute: (MicRichTextDoIt new
			 actOnClickBlock: [ :attr :event |
					 | popoverPresenter |
					 popoverPresenter := SpPopoverPresenter new presenter:
							                     (ViennaPopoverExpressionPresenter expression: aScriptBlock execute viennaString).
					 popoverPresenter relativeTo: (SpPresenter new
								  layout: SpBoxLayout new;
								  build;
								  yourself).
					 popoverPresenter bePositionRight.
					 popoverPresenter popupPointingTo: (event hand position + (10 @ -20) extent: 1 @ 1).
					 popoverPresenter takeKeyboardFocus ];
			 yourself).
	canvas << expressionText << ' ' asText << buttonText.
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaSourceBlockScript: aScriptBlock [

	| sourceText |
	aScriptBlock retrievePresenter.
	sourceText := aScriptBlock sourceText.
	canvas << sourceText.
	canvas
		newLine;
		newLine
]
