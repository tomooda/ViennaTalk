parsers-types
unionType
	^ (type , ($| asParser trim , type) plus)
		==> [ :pair | 
			Array
				new: pair second size + 1
				streamContents: [ :stream | 
					stream nextPut: pair first.
					pair second do: [ :second | stream nextPut: second second ] ] ]