tests
testIncludes
	self assert: (bool2nat includes: Dictionary new).
	self
		assert:
			(bool2nat
				includes:
					(Dictionary new
						at: true put: 1;
						at: false put: 0;
						yourself)).
	self
		assert:
			(bool2nat
				includes:
					(Dictionary new
						at: true put: 0;
						at: false put: 0;
						yourself)).
	self
		deny:
			(bool2nat
				includes:
					(Dictionary new
						at: true put: 1;
						at: false put: 0.2;
						yourself))