accessing
allVariables
	^ memberMatchers inject: #() into: [ :vars :matcher | vars , matcher allVariables ]