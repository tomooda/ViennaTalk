code pane
code
	^ self selectedScriptSelector
		ifNotNil: [ :selector | 
			(self director scriptAt: selector ifAbsent: [  ])
				ifNotNil: [ :script | (selector , String cr , script source) asText makeAllColor: Color black ]
				ifNil: [ self codeTemplate ] ]
		ifNil: [ self codeTemplate ]