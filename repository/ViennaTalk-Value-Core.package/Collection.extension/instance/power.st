*ViennaTalk-Value-Core
power
	| power powerSet |
	power := self asArray power.
	powerSet := self species new: power size * 3 // 2.
	powerSet addAll: power.
	^ powerSet