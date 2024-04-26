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

	^ self tracingSource in: [ :source |
		  ViennaVDMHighlighter new
			  text: source asText;
			  parse: source asString;
			  text ]
]
