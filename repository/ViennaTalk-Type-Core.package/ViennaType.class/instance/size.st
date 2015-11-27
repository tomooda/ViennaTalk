accessing
size
	| count |
	count := 0.
	self do: [ :value | count := count + 1 ].
	^ count