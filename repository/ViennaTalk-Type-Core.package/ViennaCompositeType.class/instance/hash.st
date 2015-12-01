comparing
hash
	^ (1 to: self size) inject: constructorName hash into: [ :hash :field | hash bitXor: field hash ]