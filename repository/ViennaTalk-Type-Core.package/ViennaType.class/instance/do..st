enumerating
do: aBlock
	runtimeSet ifNotNil: [ runtimeSet do: aBlock ] ifNil: [ self basicDo: aBlock ]