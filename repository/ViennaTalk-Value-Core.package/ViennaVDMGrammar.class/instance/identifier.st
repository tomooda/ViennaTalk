parsers-symbols
identifier
	^ ('mk_' asParser not , 'pre_' asParser not , 'post_' asParser not , 'is_' asParser not , 'obj_' asParser not
		, 'lambda' asParser not , 'mu' asParser not , initialLetter , followingLetter star) flatten