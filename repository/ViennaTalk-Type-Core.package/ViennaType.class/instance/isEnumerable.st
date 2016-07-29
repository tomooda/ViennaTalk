testing
isEnumerable
	^ runtimeSet notNil or: [ self basicIsEnumerable ]