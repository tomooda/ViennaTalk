enumerating
basicDo: aBlock
	basetypes do: [ :type | type do: aBlock ]