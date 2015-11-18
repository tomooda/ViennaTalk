specs
defaultSpec
	<spec: #default>
	^ SpecLayout composed
		newRow: [ :c | 
					c
						add: #sourceText;
						addSplitter;
						add: #targetText ];
		yourself