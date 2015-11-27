enumerating
fieldsDo: aBlock
	1 to: self basicSize do: [ :index | aBlock valueWithArguments: (self at: index) ]