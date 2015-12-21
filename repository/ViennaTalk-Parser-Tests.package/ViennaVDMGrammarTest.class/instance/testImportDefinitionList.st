tests-interfaces
testImportDefinitionList
	self
		assert: (grammar importDefinitionList end parse: 'imports from m1 values v1; v2 functions f ; values v, from m2 all')
		equals: #(#('m1' #(#(#('v1' nil nil) #('v2' nil nil)) #(#('f' nil nil)) #(#('v' nil nil)))) #('m2' 'all'))