accessing
highlightedSource
	^ self source
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asString asText;
				parse: source asString;
				text ]