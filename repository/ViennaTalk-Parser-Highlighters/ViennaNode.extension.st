Extension { #name : #ViennaNode }

{ #category : #'*ViennaTalk-Parser-Highlighters' }
ViennaNode >> highlightedSource [
	^ self source
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asString asText;
				parse: source asString;
				text ]
]

{ #category : #'*ViennaTalk-Parser-Highlighters' }
ViennaNode >> tracingHighlightedSource [

	| text source whole |
	text := ViennaVDMTracingHighligtingFormatter format: self.
	source := text string.
	source mergeSources.
	whole := 1 to: source size.
	source sources addAll:
		(self allParents collect: [ :node | whole -> node ]).
	^ text
]
