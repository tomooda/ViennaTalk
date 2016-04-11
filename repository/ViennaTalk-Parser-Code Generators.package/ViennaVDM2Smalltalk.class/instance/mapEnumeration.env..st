code generation-expressions
mapEnumeration: aViennaNode env: aDictionary
	| pairs |
	pairs := self generateAll: aViennaNode env: aDictionary.
	^ '{' , (' . ' join: (pairs collect: [ :pair | pair first , ' -> ' , pair second ])) , '} asDictionary'