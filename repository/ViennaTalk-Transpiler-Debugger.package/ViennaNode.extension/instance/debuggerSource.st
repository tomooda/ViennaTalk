*ViennaTalk-Transpiler-Debugger
debuggerSource
	^ (ViennaVDMTracingFormatter format: self)
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asString asText;
				parse: source asString;
				text ]