Extension { #name : 'MicRichTextComposer' }

{ #category : '*ViennaTalk-Parser-Highlighters' }
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
