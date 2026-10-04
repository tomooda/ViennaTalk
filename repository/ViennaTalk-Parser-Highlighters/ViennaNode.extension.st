Extension { #name : 'ViennaNode' }

{ #category : '*ViennaTalk-Parser-Highlighters' }
ViennaNode >> highlightedSource [

	^ ViennaVDMHighlightingFormatter format: self
]

{ #category : '*ViennaTalk-Parser-Highlighters' }
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
