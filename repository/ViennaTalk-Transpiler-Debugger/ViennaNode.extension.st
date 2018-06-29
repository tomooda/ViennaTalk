Extension { #name : #ViennaNode }

{ #category : #'*ViennaTalk-Transpiler-Debugger' }
ViennaNode >> debuggerSource [
	^ (ViennaVDMTracingFormatter format: self)
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asString asText;
				parse: source asString;
				text ]
]
