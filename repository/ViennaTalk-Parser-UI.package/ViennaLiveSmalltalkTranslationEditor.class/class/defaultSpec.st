specs
defaultSpec
	<spec: #default>
	^ SpecLayout composed
		newColumn: [ :c | 
					c
						newRow: [ :row | 
									row
										add: #sourceText;
										addSplitter;
										add: #targetText ];
						addSplitter;
						newRow: [ :row | row add: #codeText ];
						yourself ];
		yourself