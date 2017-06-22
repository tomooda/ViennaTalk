utilities
stringStreamContents: aBlock
	| tracingString |
	tracingString := ViennaTracingString new.
	aBlock value: tracingString.
	^ tracingString