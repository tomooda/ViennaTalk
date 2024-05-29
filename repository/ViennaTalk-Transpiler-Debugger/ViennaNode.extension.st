Extension { #name : 'ViennaNode' }

{ #category : '*ViennaTalk-Transpiler-Debugger' }
ViennaNode >> debuggerSource [
	^ (ViennaVDMTracingFormatter format: self)
		in: [ :source | 
			ViennaVDMHighlighter new
				text: source asString asText;
				parse: source asString;
				text ]
]

{ #category : '*ViennaTalk-Transpiler-Debugger' }
ViennaNode >> tracingSource [
	| source whole |
	source := (ViennaVDMTracingFormatter format: self)
		asViennaTracingString.
	source mergeSources.
	whole := 1 to: source size.
	source sources
		addAll: (self allParents collect: [ :node | whole -> node ]).
	^ source
]
