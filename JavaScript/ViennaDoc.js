const opaque = document.body.style.opacity;
document.body.style.opacity = 0;

const loadAsset = (type, url) => new Promise((resolve, reject) => {
  if (type === 'script') {
    const script = document.createElement('script');
    script.src = url;
    script.async = false;
    script.onload = () => resolve();
    script.onerror = () => reject(new Error(`Failed to load: ${url}`));
    document.head.appendChild(script);
  } else if (type === 'link') {
    const link = document.createElement('link');
    link.rel = 'stylesheet';
    link.href = url;
    document.head.appendChild(link);
    resolve();
  }
});

// Assets are loaded asynchronously
await loadAsset('script', 'https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js');
await loadAsset('link', 'https://viennatalk.org/ViennaDoc/ViennaDoc.css');
await loadAsset('script', './ViennaClient.js');

document.body.style.opacity = 1;

export const ViennaDoc = {};
ViennaDoc.value_prefix = '\u261E ';
ViennaDoc.source = "";
ViennaDoc.states = {};
ViennaDoc.watch = [];

String.prototype.vienna_globalName = function (module = "DEFAULT") {
    if (this.includes("`")) {
        return this.toString();
    }
    return `${module}\`${this}`;
};

ViennaDoc.eval = async function(expression, prestates = {}, module = "DEFAULT") {
    for (const [varname, val] of Object.entries(prestates)) {
        if (val) {
            ViennaDoc.states[varname.vienna_globalName(module)] = val;
        }
    }
    const result = await ViennaDoc.source.vienna_eval(expression, ViennaDoc.states, module);
    ViennaDoc.states = result.poststates;
    
    ViennaDoc.watch.forEach((node) => {
        const mod = node.getAttribute("module") || "DEFAULT";
        let key = node.innerText;
        if (!key.includes('`')) {
            key = `${mod}\`${key}`;
        }
        node.nextSibling.innerText = ViennaDoc.value_prefix + ViennaDoc.states[key];
    });
    return result;
};

ViennaDoc.evalShow = async function(node, expression, prestates, poststates, module = "DEFAULT") {
    const result = await ViennaDoc.eval(expression, prestates, module);
    let text = "";
    
    const preKeys = Object.keys(prestates);
    if (preKeys.length > 0) {
        const preStateStr = preKeys.map(v => 
            `${v}=${result.prestates[v.vienna_globalName(module)]}`
        ).join(',');
        text += ` {${preStateStr}} ${expression} \u261E `;
    }
    
    if (result.message === "") {
        text += result.value;
        const postKeys = Object.keys(poststates);
        if (postKeys.length > 0) {
            const postStateStr = postKeys.map(v => 
                `${v}=${result.poststates[v.vienna_globalName(module)]}`
            ).join(',');
            text += ` {${postStateStr}} `;
        }
    } else {
        text += "ERROR! ";
    }
    node.innerText = text;
};

ViennaDoc.valueShow = async function(node, expression, module = "DEFAULT") {
    const result = await ViennaDoc.eval(expression, {}, module);
    let text = "";
    if (result.message === "") {
        text = ` \u261E ${result.value}`;
    } else {
        text = " \u261E ERROR! ";
    }
    node.innerText = text;
};

ViennaDoc.parseStates = function (str, module) {
    const states = {};
    if (str) {
        str.split(",")
           .map(s => s.trim())
           .filter(Boolean)
           .forEach((bind) => {
               const [varname, val] = bind.split("=").map(s => s.trim());
               states[varname] = val !== undefined ? val : null;
           });
    }
    return states;
};

ViennaDoc.initializeViennaSourceNode = function(node) {
    const preNode = document.createElement("pre");
    node.parentNode.insertBefore(preNode, node.nextSibling);
    preNode.appendChild(node);
    
    const srcAttr = node.getAttribute("src");
    const src = srcAttr != null ? (ViennaDoc.sources[srcAttr] || "") : (ViennaDoc.source || "");
    
    node.innerHTML = hljs.highlightAuto(src).value;
    node.style.backgroundColor = "#eee";
    node.style.display = "block";
};

ViennaDoc.initializeViennaEvalNode = function(node) {
    const expr = node.innerText;
    const module = node.getAttribute("module") || "DEFAULT";
    const prestates = ViennaDoc.parseStates(node.getAttribute("prestates"), module);
    const poststates = ViennaDoc.parseStates(node.getAttribute("poststates"), module);
    const nextNode = node.nextSibling;
    
    const buttonNode = document.createElement("input");
    const valueNode = document.createElement("code");
    
    node.style.backgroundColor = "#eee";
    buttonNode.type = "button";
    buttonNode.value = "run";
    
    buttonNode.onclick = async () => {
        await ViennaDoc.evalShow(valueNode, expr, prestates, poststates, module);
    };
    
    valueNode.className = "vdm";
    valueNode.style.backgroundColor = "#eee";
    valueNode.style.cursor = "pointer";
    valueNode.onclick = function() { this.innerText = ""; };
    
    node.parentNode.insertBefore(buttonNode, nextNode);
    node.parentNode.insertBefore(valueNode, nextNode);
};

ViennaDoc.initializeViennaValueNode = function(node) {
    const expr = node.innerText;
    const module = node.getAttribute("module") || "DEFAULT";
    const nextNode = node.nextSibling;
    
    const buttonNode = document.createElement("input");
    const valueNode = document.createElement("code");
    
    node.style.backgroundColor = "#eee";
    buttonNode.type = "button";
    buttonNode.value = "run";
    
    buttonNode.onclick = async () => {
        await ViennaDoc.valueShow(valueNode, expr, module);
    };
    
    valueNode.className = "vdm";
    valueNode.style.backgroundColor = "#eee";
    valueNode.style.cursor = "pointer";
    valueNode.onclick = function() { this.innerText = ""; };
    
    node.parentNode.insertBefore(buttonNode, nextNode);
    node.parentNode.insertBefore(valueNode, nextNode);
};

ViennaDoc.initializeViennaWatchNode = function(node) {
    const valueNode = document.createElement("code");
    node.style.backgroundColor = "#eee";
    valueNode.className = "vdm";
    valueNode.style.backgroundColor = "#eee";
    node.parentNode.insertBefore(valueNode, node.nextSibling);
    ViennaDoc.watch.push(node);
};

ViennaDoc.initializeViennaAssertNode = async function(node) {
    const savedStates = { ...ViennaDoc.states };
    const expected = node.innerText;
    const module = node.getAttribute("module") || "DEFAULT";
    const prestates = ViennaDoc.parseStates(node.getAttribute("prestates"), module);
    const expression = node.getAttribute("eval");
    
    if (!expression) {
        const warningNode = document.createElement("span");
        warningNode.innerText = " [not validated]";
        warningNode.style.color = "#800000";
        node.parentNode.insertBefore(warningNode, node.nextSibling);
        return false;
    }
    
    const result = await ViennaDoc.eval(expression, prestates, module);
    ViennaDoc.states = savedStates;
    const actual = result.value;
    
    if (result.message || actual != expected) {
        const warningNode = document.createElement("span");
        let text = " [invalid: ";
        const preKeys = Object.keys(prestates);
        if (preKeys.length > 0) {
            const preStateStr = preKeys.map(v => 
                `${v}=${result.prestates[v.vienna_globalName(module)]}`
            ).join(',');
            text += ` {${preStateStr}} ${expression} \u261E `;
        }
        
        if (result.message === "") {
            text += result.value;
        } else {
            text += "ERROR! ";
        }
        text += "]";
        warningNode.innerText = text;
        warningNode.style.color = "#800000";
        node.parentNode.insertBefore(warningNode, node.nextSibling);
        return false;
    }
    return true;
};

document.addEventListener('DOMContentLoaded', async (event) => {
    ViennaDoc.watch = [];
    
    const nodes = Array.from(document.querySelectorAll('code.vdm'));
    for (const node of nodes) {
        const vienna = node.getAttribute("vienna");
        if (vienna === "source") {
            ViennaDoc.initializeViennaSourceNode(node);
        }
        if (vienna === "eval") {
            ViennaDoc.initializeViennaEvalNode(node);
        }
        if (vienna === "value") {
            ViennaDoc.initializeViennaValueNode(node);
        }
        if (vienna === "watch") {
            ViennaDoc.initializeViennaWatchNode(node);
        }
        if (vienna === "assert") {
            await ViennaDoc.initializeViennaAssertNode(node);
        }
        
        if (node.parentNode.tagName.toLowerCase() !== "pre") {
            hljs.highlightElement(node);
            node.style.display = "inline-block";
            node.style.margin = "0 2px";
            node.style.padding = "1px 3px";
        }
    }
    await ViennaDoc.eval("nil");
});

hljs.registerLanguage('vdm', function(hljsApi) {
  const VDM_KEYWORDS = {
    keyword: 
      'state compose  inv init pre post types values functions operations traces ' +
      'to return definitions exports imports' +
      ' module end pure ' +
      'if then else elseif let in be st cases of lambda default ' +
      'forall exists exists1 mu iota dcl',
    literal: 
      'true false nil',
    type: 
      'nat nat1 int rat real char bool map set seq of token',
  };

  return {
    name: 'VDM',
    aliases: ['vdmsl'],
    keywords: VDM_KEYWORDS,
    contains: [
      {
        className: 'comment',
        begin: '--', end: '$'
      },
      {
        className: 'comment',
        begin: '/\\*', end: '\\*/'
      },
      {
        className: 'string',
        begin: '"', end: '"',
        illegal: '\\n'
      },
      {
        className: 'keyword',
        begin: '(pre_|is_|mk_|inv_|post_)'
      },
      {
        className: 'number',
        begin: '\\b\\d+(\\.\\d+)?\\b'
      },
      {
        className: 'symbol',
        begin: '(\\==>|\\==|\\->|\\|\\->|\\=>|\\:\\=|\\:\\:|\\||\\+|\\-|\\*|\\/|\\=|\\#|<|>|<=|>=)'
      },
      {
        className: 'variable',
        begin: '\\b[a-zA-Z_][a-zA-Z0-9_]*\\b',
        keywords: VDM_KEYWORDS
      }
    ]
  };
});
