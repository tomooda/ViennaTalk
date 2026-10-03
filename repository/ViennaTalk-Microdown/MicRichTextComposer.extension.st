Extension { #name : 'MicRichTextComposer' }

{ #category : '*ViennaTalk-Microdown' }
MicRichTextComposer >> viennaWriteResult: aScriptBlock [

	aScriptBlock resultString ifNotNil: [ :resultString |
			^ (' ' , resultString , ' ') asText
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
	aScriptBlock moduleName ifNotNil: [ :moduleName | expressionText addAttribute: (ViennaMicModuleReference moduleName: moduleName) ].
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
	aScriptBlock moduleName ifNotNil: [ :moduleName | statementText addAttribute: (ViennaMicModuleReference moduleName: moduleName) ].
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

	| sourceText |
	aScriptBlock retrievePresenter.
	aScriptBlock execute.
	sourceText := self viennaWriteResultWithoutArrow: aScriptBlock.
	aScriptBlock bodyNode
		ifNil: [
		aScriptBlock moduleName ifNotNil: [ :moduleName | sourceText addAttribute: (ViennaMicModuleReference moduleName: moduleName) ] ]
		ifNotNil: [ :nameNode |
				nameNode isViennaGlobalNameNode
					ifTrue: [
					sourceText addAttribute: (ViennaMicTopLevelReference moduleName: nameNode moduleIdentifier identifier: nameNode identifier) ]
					ifFalse: [
							aScriptBlock moduleName
								ifNil: [ sourceText addAttribute: (ViennaMicModuleReference moduleName: nameNode identifier) ]
								ifNotNil: [ :moduleName |
								sourceText addAttribute: (ViennaMicTopLevelReference moduleName: moduleName identifier: nameNode identifier) ] ] ].
	canvas << sourceText.
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

	| result |
	aScriptBlock retrievePresenter.
	aScriptBlock execute.
	result := self viennaWriteResult: aScriptBlock.
	aScriptBlock bodyNode ifNotNil: [ :nameNode |
			nameNode isViennaGlobalNameNode
				ifTrue: [
				result addAttribute: (ViennaMicTopLevelReference moduleName: nameNode moduleIdentifier identifier: nameNode identifier) ]
				ifFalse: [
						aScriptBlock moduleName ifNotNil: [ :moduleName |
							result addAttribute: (ViennaMicTopLevelReference moduleName: moduleName identifier: nameNode identifier) ] ] ].
	canvas << result.
	canvas
		newLine;
		newLine
]
