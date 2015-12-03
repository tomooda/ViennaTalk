enumerating
collect: aBlock
	^ (1 to: self size) collect: [ :index | aBlock value: (self at: index) ]