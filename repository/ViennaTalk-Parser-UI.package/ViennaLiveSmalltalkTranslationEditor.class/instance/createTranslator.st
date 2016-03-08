private
createTranslator
	^ [ :string | 
	ViennaVDM2SmalltalkScript
		translate: string
		ifError: [ 
			ViennaVDM2SmalltalkScript
				translateStatement: string
				ifError: [ ViennaVDM2SmalltalkScript translateExpression: string ifError: [ :err | err ] ] ] ]