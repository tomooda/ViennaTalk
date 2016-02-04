*ViennaTalk-Value-Core
power
	| power |
	power := self species new: 2 << self size.
	0 to: (1 << self size) - 1 do: [ :index | 
		| i member |
		i := 0.
		1 to: self size do: [ :bit | 
			(index bitAt: bit) = 0
				ifTrue: [ i := i + 1 ] ].
		member := self species new: i.
		i := 0.
		1 to: self size do: [ :bit | 
			(index bitAt: bit) = 0
				ifTrue: [ member at: (i := i + 1) put: (self at: bit) ] ].
		power at: index + 1 put: member ].
	^ power