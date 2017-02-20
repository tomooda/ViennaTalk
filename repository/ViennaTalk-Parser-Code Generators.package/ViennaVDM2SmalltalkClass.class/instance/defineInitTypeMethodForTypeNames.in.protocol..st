utilities
defineInitTypeMethodForTypeNames: typeNames in: aClass protocol: protocol
	self
		defineMethod:
			'initTypes '
				,
					('. '
						join: (typeNames collect: [ :typeName | typeName , ' := self ' , typeName , ' removeTypeHolders' ]))
		in: aClass
		protocol: protocol