Extension { #name : 'MicRichTextComposer' }

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> viennaWriteResult: aScriptBlock [

	aScriptBlock resultString ifNotNil: [ :resultString |
			^ (' ' asText , resultString , ' ') asText
				  addAttribute: (TextBackgroundColor color: (Color gray: 0.9));
				  addAttribute: (MicRichTextDoIt new
						   actOnClickBlock: [
								   aScriptBlock
									   flushResultString;
									   recompose ];
						   yourself);
				  yourself ].
	aScriptBlock errorString ifNotNil: [ :errorString |
			^ errorString asText
				  addAttribute: (TextBackgroundColor color: Color red muchLighter);
				  yourself ].
	^ '' asText
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> viennaWriteResultWithoutArrow: aScriptBlock [

	aScriptBlock resultString ifNotNil: [ :resultString | ^ resultString asText ].
	aScriptBlock errorString ifNotNil: [ :errorString |
			^ errorString asText
				  addAttribute: (TextBackgroundColor color: Color red muchLighter);
				  yourself ].
	^ '' asText
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaEval: aScriptBlock [

	| expressionText buttonText |
	aScriptBlock retrievePresenter.
	expressionText := aScriptBlock bodyText.
	buttonText := ' run ' asText
		              addAttribute: (TextBackgroundColor color: (Color gray: 0.8));
		              addAttribute: (MicRichTextDoIt new
				               actOnClickBlock: [ aScriptBlock execute ];
				               yourself);
		              yourself.
	canvas << expressionText << ' ' asText << buttonText.
	canvas << (self viennaWriteResult: aScriptBlock).
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaExec: aScriptBlock [

	| statementText buttonText |
	aScriptBlock retrievePresenter.
	statementText := aScriptBlock bodyText.
	buttonText := ' run ' asText
		              addAttribute: (TextBackgroundColor color: (Color gray: 0.8));
		              addAttribute: (MicRichTextDoIt new
				               actOnClickBlock: [ aScriptBlock execute ];
				               yourself);
		              yourself.
	canvas << statementText << ' ' asText << buttonText.
	canvas << (self viennaWriteResult: aScriptBlock).
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaSource: aScriptBlock [

	aScriptBlock retrievePresenter.
	aScriptBlock execute.
	canvas << (self viennaWriteResultWithoutArrow: aScriptBlock).
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaTalkScript: aMicromaidScriptBlock [

	| script resText |
	script := aMicromaidScriptBlock body asString.
	resText := script asText.
	ViennaVDMHighlighter new
		text: resText;
		parse: script.
	canvas
		newLineIfNotAlready;
		<< resText;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaWatch: aScriptBlock [

	aScriptBlock retrievePresenter.
	aScriptBlock execute.
	canvas << (self viennaWriteResult: aScriptBlock).
	canvas
		newLine;
		newLine
]
