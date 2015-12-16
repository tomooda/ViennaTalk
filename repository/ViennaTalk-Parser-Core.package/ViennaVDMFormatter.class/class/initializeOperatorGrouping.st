class initialization
initializeOperatorGrouping
	OperatorGrouping := Dictionary new
		at: 'Iterate' put: #right;
		at: 'Composition' put: #right;
		at: 'Subsequence' put: #left;
		at: 'Apply' put: #left;
		at: 'FunctionTypeInstantiation' put: #left;
		at: 'FieldSelect' put: #left;
		at: 'MapRangeRestrictedBy' put: #left;
		at: 'MapRangeRestrictedTo' put: #left;
		at: 'MapDomainRestrictedBy' put: #right;
		at: 'MapDomainRestrictedTo' put: #right;
		at: 'ArithmeticDivide' put: #left;
		at: 'ArithmeticRem' put: #left;
		at: 'ArithmeticMod' put: #left;
		at: 'ArithmeticIntegerDivision' put: #left;
		at: 'ArithmeticMinus' put: #left;
		at: 'SetDifference' put: #left;
		at: 'MapMerge' put: #left;
		at: 'MapOrSequenceModify' put: #left;
		at: 'SequenceConcatenate' put: #left;
		at: 'Imply' put: #right;
		at: 'PartialFunctionType' put: #right;
		at: 'TotalFunctionType' put: #right;
		yourself