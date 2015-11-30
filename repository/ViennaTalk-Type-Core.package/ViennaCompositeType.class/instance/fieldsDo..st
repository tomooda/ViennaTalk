private
fieldsDo: aBlock
	1 to: self size do: [ :index | aBlock valueWithArguments: (self at: index) ]