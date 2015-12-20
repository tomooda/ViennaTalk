parsers-symbols
keyword
	^ self keywords inject: (self reserved: 'abs') into: [ :p :t | p / (self reserved: t) ]