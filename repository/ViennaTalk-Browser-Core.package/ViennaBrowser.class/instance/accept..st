value pane menu
accept: aTextOrString
	selectedModule
		ifNil: [ ^ false ]
		ifNotNil: [ :module | selectedField ifNil: [ ^ false ] ifNotNil: [ vdmc plainAt: module , '`' , selectedField put: aTextOrString asString ] ].
	self updateContents.
	^ true