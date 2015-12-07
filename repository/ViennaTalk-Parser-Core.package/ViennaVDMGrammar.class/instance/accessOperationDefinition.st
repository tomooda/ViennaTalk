parsers-definitions
accessOperationDefinition
	| pure async static |
	pure := self reserved: 'pure'.
	async := self reserved: 'async'.
	static := self reserved: 'static'.
	^ (pure optional , async optional
		,
			((static , access optional)
				/
					((access optional , static optional)
						==> [ :pair | 
							{(pair second).
							(pair first)} ])) , operationDefinition)
		==> [ :quatro | 
			{({(quatro first).
			(quatro second).
			(quatro third first).
			(quatro third second)} reject: #isNil).
			(quatro fourth)} ]