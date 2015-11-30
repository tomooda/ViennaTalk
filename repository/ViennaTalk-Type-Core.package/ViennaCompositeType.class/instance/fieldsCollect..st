private
fieldsCollect: aBlock
	^ (1 to: self size) collect: [ :index | aBlock valueWithArguments: (self at: index) ]