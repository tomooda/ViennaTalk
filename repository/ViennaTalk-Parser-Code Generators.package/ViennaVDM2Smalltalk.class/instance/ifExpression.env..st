code generation-expressions
ifExpression: aViennaNode env: aDictionary
	| conditionals default |
	conditionals := self generateAll: aViennaNode first env: aDictionary.
	default := self generate: aViennaNode second env: aDictionary.
	^ '('
		,
			(conditionals reverse
				inject: default
				into: [ :else :cond | cond first , ' ifTrue: [' , cond second , '] ifFalse: [' , else , ']' ]) , ')'