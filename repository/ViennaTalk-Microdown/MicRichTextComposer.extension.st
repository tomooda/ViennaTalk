Extension { #name : 'MicRichTextComposer' }

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> viennaWriteResult: aScriptBlock [

	aScriptBlock resultString ifNotNil: [ :resultString |
			| resultText |
			resultText := (' ' , resultString , ' ') asText
				              addAttribute: (TextBackgroundColor color: (Color gray: 0.9));
				              addAttribute: (MicRichTextDoIt new
						               actOnClickBlock: [
								               aScriptBlock
									               flushResultString;
									               recompose ];
						               yourself);
				              yourself.
			canvas << ' ' << resultText ].
	aScriptBlock errorString ifNotNil: [ :errorString |
			| errorText |
			errorText := errorString asText
				             addAttribute: (TextBackgroundColor color: Color red muchLighter);
				             yourself.
			canvas << ' ' << errorText ]
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> viennaWriteResultWithoutArrow: aScriptBlock [

	aScriptBlock resultString ifNotNil: [ :resultString | canvas << resultString asText ].
	aScriptBlock errorString ifNotNil: [ :errorString |
			| errorText |
			errorText := errorString asText
				             addAttribute: (TextBackgroundColor color: Color red muchLighter);
				             yourself.
			canvas << errorText ]
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
	self viennaWriteResult: aScriptBlock.
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
	self viennaWriteResult: aScriptBlock.
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaSource: aScriptBlock [

	aScriptBlock retrievePresenter.
	aScriptBlock execute.
	self viennaWriteResultWithoutArrow: aScriptBlock.
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaWatch: aScriptBlock [

	aScriptBlock retrievePresenter.
	aScriptBlock execute.
	self viennaWriteResult: aScriptBlock.
	canvas
		newLine;
		newLine
]
