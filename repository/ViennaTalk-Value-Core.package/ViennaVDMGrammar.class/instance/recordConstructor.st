parsers-expressions
recordConstructor
	^ ('mk_' asParser , name , (self operator: $()
		, ((expression delimitedBy: (self operator: $,)) withoutSeparators optional ==> [ :args | args ifNil: [ Array new ] ])
		, (self operator: $)))
		==> [ :array | 
			{(array second).
			(array fourth)} ]