parsers-definitions
accessTypeDefinition
	| static |
	static := self reserved: 'static'.
	^ (access , static optional)
		/
			((static optional , access optional)
				==> [ :pair | 
					{(pair second).
					(pair first)} ]) , typeDefinition