code pane
code
	^ self selectedActionSelector
		ifNotNilDo: [ :selector | 
			(self director actionAt: selector ifAbsent: [  ])
				ifNotNilDo: [ :action | (selector , String cr , action source) asText makeAllColor: Color black ]
				ifNil: [ self codeTemplate ] ]
		ifNil: [ self codeTemplate ]