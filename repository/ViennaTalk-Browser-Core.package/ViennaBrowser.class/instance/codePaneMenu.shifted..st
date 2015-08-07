code pane menu
codePaneMenu: aMenu shifted: aBoolean
	aMenu
		addList:
			{{('copy (c)' translated).
			#copySelection}.
			{('cut (x)' translated).
			#cut}.
			{('paste (v)' translated).
			#paste}.
			{('paste...' translated).
			#pasteRecent}.
			#-.
			{('find...(f)' translated).
			#find}.
			{('find again (g)' translated).
			#findAgain}.
			{('set search string (h)' translated).
			#setSearchString}.
			#-.
			{('undo (z)' translated).
			#undo}.
			#-.
			{('do it (d)' translated).
			#codePaneDoIt}.
			{('print it (p)' translated).
			#codePanePrintIt}.
			#-.
			{('accept (s)' translated).
			#accept}.
			{('cancel (l)' translated).
			#cancel}.
			#-.
			{('save contents to file...' translated).
			#saveContentsInFile}.
			#-.
			{('set font... (k)' translated).
			#offerFontMenu}.
			{('set style... (K)' translated).
			#changeStyle}.
			{('set alignment... (u)' translated).
			#chooseAlignment}}.
	^ aMenu