*ViennaTalk-Value-Core
power
	| array size power |
	array := self asArray.
	size := array size.
	power := self species new: 1 << size.
	0 to: (1 << size) - 1 do: [ :index | 
		| member |
		member := self species new: size.
		1 to: array size do: [ :bit | 
			(index bitAt: bit) = 0
				ifTrue: [ member add: (array at: bit) ] ].
		power add: member ].
	^ power