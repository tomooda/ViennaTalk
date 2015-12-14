converting
asArray
	| array |
	array := Array new: self size.
	1 to: self size do: [ :i | array at: i put: (self at: i) ].
	^ array