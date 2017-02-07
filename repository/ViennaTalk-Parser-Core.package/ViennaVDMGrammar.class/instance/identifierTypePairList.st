parsers-definitions
identifierTypePairList
	^ (identifier trim , colon , type separatedBy: comma) withoutSeparators optional
		==> [ :triples | 
			triples
				ifNil: [ Array new ]
				ifNotNil: [ | array |
					array := Array new: triples size * 2.
					1 to: triples size do: [ :index | 
						array at: index * 2 - 1 put: (triples at: index) first.
						array at: index * 2 put: (triples at: index) third ].
					array ] ]