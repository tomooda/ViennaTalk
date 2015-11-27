enumerating
fieldsCollect: aBlock
	^ (1 to: self basicSize) collect: [ :index | aBlock valueWithArguments: (self at: index) ]