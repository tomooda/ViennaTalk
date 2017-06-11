utilities
defineInitTypeMethodForTypeNames: typeNames in: aClass protocol: protocol node: aViennaNode
	self
		defineMethod:
			'initTypes '
				,
					('. '
						join:
							(typeNames
								collect: [ :typeName | typeName , ' := self ' , typeName , ' removeTypeHolders' ]))
		in: aClass
		protocol: protocol
		node: aViennaNode