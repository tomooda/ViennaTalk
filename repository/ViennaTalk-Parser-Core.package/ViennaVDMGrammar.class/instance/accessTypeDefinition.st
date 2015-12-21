parsers-definitions
accessTypeDefinition
	| static |
	static := self reserved: 'static'.
	^ (((access , static optional)
		==> [ :pair | 
			{(pair second).
			(pair first)} ]) / (static optional , access optional) , self typeDefinition)
		==> [ :pair | 
			{(pair first reject: #isNil).
			(pair second)} ]