json
scriptsFromJsonObject: aDictionary
	scripts := Dictionary new.
	aDictionary
		keysAndValuesDo: [ :selector :source | 
			(LWTLivetalkScript
				named: selector
				on: self
				source: source
				ifFail: [  ]) ifNotNil: [ :script | self addScript: script ] ].
	self classicChanged: #scriptSelectors