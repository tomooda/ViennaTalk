accessing
allVariables
	^ matchers inject: #() into: [ :vars :assoc | vars , assoc value allVariables ]