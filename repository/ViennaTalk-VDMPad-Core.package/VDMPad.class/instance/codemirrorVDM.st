request handling-javascript
codemirrorVDM
	^ self
		responseJS:
			'CodeMirror.defineMode("vdm", function() {

  var words = {
    "<:" : "keyword",
    "<-:" : "keyword",
    ":>" : "keyword",
    ":->" : "keyword",
    "==>" : "keyword",
    "==" : "keyword",
    "|->" : "keyword",
    ":" : "keyword",
    ":=" : "keyword",
    "++" : "keyword",
    "#act" : "atom",
    "#active" : "atom",
    "#fin" : "atom",
    "#req" : "atom",
    "#waiting" : "atom",
    "abs" : "builtin",
    "all" : "keyword",
    "always" : "keyword",
    "and" : "operator",
    "as" : "keyword",
    "async" : "keyword",
    "atomic" : "keyword",
    "be" : "keyword",
    "bool" : "builtin",
    "by" : "keyword",
    "card" : "operator",
    "cases" : "keyword",
    "char" : "builtin",
    "class" : "keyword",
    "comp" : "builtin",
    "compose" : "keyword",
    "conc" : "operator",
    "cycles" : "keyword",
    "decl" : "keyword",
    "def" : "keyword",
    "definitions" : "keyword",
    "dinter" : "operator",
    "div" : "operator",
    "dlmodule" : "keyword",
    "do" : "keyword",
    "dom" : "builtin",
    "dunion" : "operator",
    "duration" : "keyword",
    "elems" : "operator",
    "else" : "keyword",
    "elseif" : "keyword",
    "end" : "keyword",
    "error" : "keyword",
    "errs" : "keyword",
    "exists" : "keyword",
    "exists1" : "keyword",
    "exit" : "keyword",
    "exports" : "keyword",
    "ext" : "keyword",
    "false" : "atom",
    "floor" : "builtin",
    "for" : "keyword",
    "forall" : "keyword",
    "from" : "keyword",
    "functions" : "keyword",
    "hd" : "operator",
    "if" : "keyword",
    "in" : "keyword",
    "inds" : "operator",
    "inmap" : "builtin",
    "instance" : "keyword",
    "int" : "builtin",
    "inter" : "builtin",
    "imports" : "keyword",
    "init" : "keyword",
    "inv" : "keyword",
    "inverse" : "builtin",
    "iota" : "keyword",
    "is" : "keyword",
    "isofbaseclass" : "builtin",
    "isofclass" : "builtin",
    "lambda" : "keyword",
    "len" : "operator",
    "let" : "keyword",
    "map" : "builtin",
    "measure" : "keyword",
    "merge" : "builtin",
    "mod" : "operator",
    "module" : "keyword",
    "mu" : "keyword",
    "munion" : "builtin",
    "mutex" : "keyword",
    "nat" : "builtin",
    "nat1" : "builtin",
    "new" : "keyword",
    "nil" : "atom",
    "not" : "operator",
    "of" : "keyword",
    "old" : "keyword",
    "operations" : "keyword",
    "or" : "operator",
    "others" : "keyword",
    "per" : "keyword",
    "periodic" : "keyword",
    "post" : "keyword",
    "power" : "operator",
    "pre" : "keyword",
    "private" : "keyword",
    "protected" : "keyword",
    "psubset" : "operator",
    "public" : "keyword",
    "rat" : "builtin",
    "rd" : "keyword",
    "real" : "builtin",
    "rem" : "keyword",
    "renamed" : "keyword",
    "responsibility" : "keyword",
    "return" : "keyword",
    "reverse" : "keyword",
    "rng" : "operator",
    "samebaseclass" : "builtin",
    "sameclass" : "keyword",
    "self" : "atom",
    "seq" : "builtin",
    "seq1" : "builtin",
    "set" : "builtin",
    "skip" : "keyword",
    "specified" : "keyword",
    "st" : "keyword",
    "start" : "keyword",
    "startlist" : "keyword",
    "state" : "keyword",
    "struct" : "keyword",
    "subclass" : "keyword",
    "subset" : "operator",
    "sync" : "keyword",
    "system" : "keyword",
    "then" : "keyword",
    "thread" : "keyword",
    "threadid" : "keyword",
    "time" : "atom",
    "tixe" : "keyword",
    "tl" : "operator",
    "to" : "keyword",
    "token" : "builtin",
    "traces" : "keyword",
    "trap" : "keyword",
    "true" : "atom",
    "types" : "keyword",
    "undefined" : "keyword",
    "union" : "operator",
    "uselib" : "keyword",
    "values" : "keyword",
    "variables" : "keyword",
    "while" : "keyword",
    "with" : "keyword",
    "wr" : "keyword",
    "yet" : "keyword",
    "RESULT" : "keyword",
    };

  function tokenBase(stream, state) {
    var ch = stream.next();
    if (ch === "(") return "variable";
    if (ch === ")") return "variable";
    if (ch === "{") return "variable";
    if (ch === "}") return "variable";
    if (ch === "[") return "variable";
    if (ch === "]") return "variable";
    if (ch === ''"'') {
      state.tokenize = tokenString;
      return state.tokenize(stream, state);
    }
    if (ch === "/") {
      if (stream.eat("*")) {
        state.commentLevel++;
        state.tokenize = tokenComment;
        return state.tokenize(stream, state);
      }
    }
    if (/\d/.test(ch)) {
      stream.eatWhile(/[\d]/);
      if (stream.eat(".")) {
        stream.eatWhile(/[\d]/);
      }
      return "number";
    }
    if ( /[+\-*&%:=<>!?|]/.test(ch)) {
      stream.eatWhile( /[+\-*&%=<>!?|]/);
      var cur = stream.current();
      if (cur.substring(0,2) == "--") {
          while (!stream.eol()) stream.next();
          return "comment";
      }
      return words[cur] || "operator";
    }
    stream.eatWhile(/\w/);
    var cur = stream.current();
    var cur3 = cur.substring(0, 3);
    var cur4 = cur.substring(0, 4);
    var cur5 = cur.substring(0, 5);
    if (cur3 == "mk_" || cur3 == "is_" || cur4 == "inv_" || cur4 == "pre_" || cur5 == "init_" || cur5 == "post_")
        return "variable-2"
    return words[cur] || "variable";
  }

  function tokenString(stream, state) {
    var next, end = false, escaped = false;
    while ((next = stream.next()) != null) {
      if (next === ''"'' && !escaped) {
        end = true;
        break;
      }
      escaped = !escaped && next === "\\";
    }
    if (end && !escaped) {
      state.tokenize = tokenBase;
    }
    return "string";
  };

  function tokenComment(stream, state) {
    var prev, next;
    while(state.commentLevel > 0 && (next = stream.next()) != null) {
      if (prev === "/" && next === "*") state.commentLevel++;
      if (prev === "*" && next === "/") state.commentLevel--;
      prev = next;
    }
    if (state.commentLevel <= 0) {
      state.tokenize = tokenBase;
    }
    return "comment";
  }

  return {
    startState: function() {return {tokenize: tokenBase, commentLevel: 0};},
    token: function(stream, state) {
      if (stream.eatSpace()) return null;
      return state.tokenize(stream, state);
    },

    blockCommentStart: "/*",
    blockCommentEnd: "*/"
  };
});

CodeMirror.defineMIME("text/x-vdm", "vdm");
'