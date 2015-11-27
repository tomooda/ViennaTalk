comparing
hash
	^ basetypes inject: 0 into: [ :h :t | h bitXor: t hash ]