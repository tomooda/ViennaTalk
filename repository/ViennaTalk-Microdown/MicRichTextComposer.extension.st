Extension { #name : 'MicRichTextComposer' }

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> viennaWriteDiagrams: aScriptBlock [

	^ Text streamContents: [ :stream |
			  aScriptBlock forms ifNotNil: [ :forms |
					  forms do: [ :form |
							  stream
								  nextPutAll: String cr asText;
								  nextPutAll: form asText ] ] ]
]

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
MicRichTextComposer >> visitViennaEval: aMicViennaEvalBlock [

	| expressionText buttonText |
	aMicViennaEvalBlock retrievePresenter.
	expressionText := aMicViennaEvalBlock bodyText.
	buttonText := ' run ' asText
		              addAttribute: (TextBackgroundColor color: (Color gray: 0.8));
		              addAttribute: (MicRichTextDoIt new
				               actOnClickBlock: [ aMicViennaEvalBlock execute ];
				               yourself);
		              yourself.
	canvas << expressionText << ' ' asText << buttonText.
	canvas << (self viennaWriteResult: aMicViennaEvalBlock).
	canvas << (self viennaWriteDiagrams: aMicViennaEvalBlock).
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaExec: aMicViennaExecBlock [

	| statementText buttonText |
	aMicViennaExecBlock retrievePresenter.
	statementText := aMicViennaExecBlock bodyText.
	buttonText := ' run ' asText
		              addAttribute: (TextBackgroundColor color: (Color gray: 0.8));
		              addAttribute: (MicRichTextDoIt new
				               actOnClickBlock: [ aMicViennaExecBlock execute ];
				               yourself);
		              yourself.
	canvas << statementText << ' ' asText << buttonText.
	canvas << (self viennaWriteResult: aMicViennaExecBlock).
	canvas << (self viennaWriteDiagrams: aMicViennaExecBlock).
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaSource: aMicViennaSourceBlock [

	aMicViennaSourceBlock retrievePresenter.
	aMicViennaSourceBlock execute.
	canvas << (self viennaWriteResultWithoutArrow: aMicViennaSourceBlock).
	canvas
		newLine;
		newLine
]

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> visitViennaTalkScript: aMicViennaTalkScriptBlock [

	| script resText |
	script := aMicViennaTalkScriptBlock body asString.
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
MicRichTextComposer >> visitViennaWatch: aMicViennaWatchBlock [

	aMicViennaWatchBlock retrievePresenter.
	aMicViennaWatchBlock execute.
	canvas << (self viennaWriteResult: aMicViennaWatchBlock).
	canvas
		newLine;
		newLine
]
