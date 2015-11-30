private
indicesAndFieldsDo: aBlock
	1 to: self size do: [ :index | 
		| field |
		field := self at: index.
		aBlock
			value: index
			value: field first
			value: field second
			value: field third ]