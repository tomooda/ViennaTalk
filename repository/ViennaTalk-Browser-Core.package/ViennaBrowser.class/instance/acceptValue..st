value pane
acceptValue: aString
	^ self selectedModule
		ifNil: [ 
			self selectedField
				ifNil: [ self acceptGlobalBindings: aString asString ]
				ifNotNil: [ :field | self accept: aString asString var: field ] ]
		ifNotNil: [ :module | 
			self selectedField
				ifNil: [ self acceptBindings: aString asString in: module ]
				ifNotNil: [ :field | self accept: aString asString var: field in: module ] ]