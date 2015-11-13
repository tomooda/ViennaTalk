*ViennaTalk-Value-Core
precedence: aBlock do: actionBlock
	parser := ((aBlock value: parser) ==> actionBlock) / parser