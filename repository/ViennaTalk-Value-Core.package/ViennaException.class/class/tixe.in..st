controlling
tixe: anArrayOfAssociations in: aBlock
	| theBlock |
	theBlock := aBlock.
	^ [ theBlock value ]
		on: self
		do: [ :ex | 
			anArrayOfAssociations
				do: [ :assoc | 
					(assoc key value: ex expression)
						ifNotNil: [ :binding | 
							theBlock := [ assoc value value: binding ].
							ex retry ] ].
			ex pass ]