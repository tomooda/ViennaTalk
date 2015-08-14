code pane
codeSelection: anInterval
	codeSelection := anInterval.
	[ 
	self director
		selectedWidgets:
			((self director morphNamed: codePane textMorph editor selection asString ifAbsent: [ nil ])
				ifNil: [ #() ]
				ifNotNil: [ :morph | Array with: morph ]) ]
		on: Error
		do: [ :ex | self director selectedWidgets: #() ]