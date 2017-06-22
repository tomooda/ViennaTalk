accessing
highlightedSource
	^ self source
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asText;
				parse: source;
				text ]