copying
postCopy
	super postCopy.
	self keys do: [ :key | self at: key put: (self at: key) copy ].
	self
		valuesDo: [ :module | 
			self
				keysDo: [ :key | 
					(module respondsTo: (key , ':') asSymbol)
						ifTrue: [ module perform: (key , ':') asSymbol with: (self at: key) ] ] ]