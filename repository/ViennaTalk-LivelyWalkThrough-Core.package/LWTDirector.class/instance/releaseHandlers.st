initialize-release
releaseHandlers
	Server ifNotNil: [ Server delegate prefixMap keysAndValuesRemove: [ :key :value | value == self ] ]