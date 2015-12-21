tests-interfaces
testimportDefinition
	self
		assert: (grammar importDefinition end parse: 'from m values v1; v2 functions f ; values v')
		equals: #('m' #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil)) #(#('v' nil nil)))).
	self assert: (grammar importDefinition end parse: 'from m all') equals: #('m' 'all')