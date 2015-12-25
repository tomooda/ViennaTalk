accessing
allVariables
	^ elementMatchers inject: #() into: [ :vars :matcher | vars , matcher allVariables ]