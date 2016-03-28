formatting
formatAll: aViennaNodeOrArray
	| array |
	array := Array new: aViennaNodeOrArray size.
	1 to: array size do: [ :i | array at: i put: (self format: (aViennaNodeOrArray at: i)) ].
	^ array