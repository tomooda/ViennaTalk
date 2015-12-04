parsers-statements
defStatement
	^ super defStatement
		==> [ :pair | 
			| defs expr vars |
			defs := pair first.
			expr := pair second.
			vars := Array new: defs size streamContents: [ :stream | defs do: [ :def | stream nextPutAll: def first first ] ].
			'[|' , (' ' join: vars) , '|'
				,
					('.'
						join:
							(defs
								collect: [ :def | 
									| left right |
									left := def first.
									right := def second.
									self binder: left second with: right vars: left first ])) , ' ifFalse: [ViennaNoMatch signal].' , expr
				, '] value' ]