parsers-statements
traps
	^ (lbrace
		,
			((pattern , self mapletArrow , statement)
				==> [ :triple | 
					{triple first.
					triple third} ] separatedBy: comma) withoutSeparators , rbrace)
		==> [ :triple | 
			| array |
			array := Array new: triple second size * 2.
			triple second
				keysAndValuesDo: [ :index :pair | 
					array at: index * 2 - 1 put: pair first.
					array at: index * 2 put: pair second ].
			array ]