json
scriptsToJsonObject
	| json |
	json := Dictionary new.
	scripts valuesDo: [ :dict | dict valuesDo: [ :script | json at: script name put: script source ] ].
	^ json