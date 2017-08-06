context
vdmRangeForContext: aContext
	| currentNode formattedSource |
	currentNode := self vdmPcNodeForContext: aContext.
	currentNode ifNil: [ ^ 1 to: 0 ].
	[ formattedSource := ViennaVDMTracingFormatter new
		format: aContext specificationContext specification.
	formattedSource asViennaTracingString sources
		do: [ :assoc | 
			assoc value == currentNode
				ifTrue: [ ^ assoc key ] ].
	currentNode := currentNode parent.
	currentNode notNil ] whileTrue.
	^ 1 to: 0