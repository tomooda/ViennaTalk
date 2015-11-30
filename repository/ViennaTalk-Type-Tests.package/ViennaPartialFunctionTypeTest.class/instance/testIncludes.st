tests
testIncludes
	self assert: (bool -> bool includes: [ :b | b not ]).
	self deny: (bool -> bool includes: [ :b1 :b2 | b1 and: [ b2 ] ]).
	self
		deny:
			(bool -> bool
				includes:
					(Dictionary new
						at: true put: false;
						at: false put: true;
						yourself)).
	self assert: (bool -> bool includes: [ :n | n + 1 ])