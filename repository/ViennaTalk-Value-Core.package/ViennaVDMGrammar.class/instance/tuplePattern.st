parsers-patterns
tuplePattern
	^ (((self reserved: 'mk_') , (self operator: $()) ==> [ :pair |  ]
		,
			((pattern , (self operator: $,)
				, ((pattern separatedBy: (self operator: $,)) withoutSeparators ==> [ :single | single ifNil: [ Array new ] ]))
				==> [ :triple | 
					Array
						new: triple third size + 1
						streamContents: [ :stream | 
							stream
								nextPut: triple first;
								nextPutAll: triple third ] ]) , (self operator: $))) ==> #second