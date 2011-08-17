" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
syntax/javascript.vim
258
" Vim syntax file
" Language:     JavaScript
" Maintainer:   Yi Zhao (ZHAOYI) <zzlinux AT hotmail DOT com>
" Last Change By: Marc Harter
" Last Change:  February 18, 2011
" Version:      0.7.9
" Changes:      Updates JSDoc syntax
"
" TODO:
"  - Add the HTML syntax inside the JSDoc

if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
endif

"" Drop fold if it set but VIM doesn't support it.
let b:javascript_fold='true'
if version < 600    " Don't support the old version
  unlet! b:javascript_fold
endif

"" dollar sigh is permittd anywhere in an identifier
setlocal iskeyword+=$

syntax sync fromstart

"" JavaScript comments
syntax keyword javaScriptCommentTodo    TODO FIXME XXX TBD contained
syntax region  javaScriptLineComment    start=+\/\/+ end=+$+ keepend contains=javaScriptCommentTodo,@Spell
syntax region  javaScriptEnvComment     start="\%^#!" end="$" display
syntax region  javaScriptLineComment    start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ keepend contains=javaScriptCommentTodo,@Spell fold
syntax region  javaScriptCvsTag         start="\$\cid:" end="\$" oneline contained
syntax region  javaScriptComment        start="/\*"  end="\*/" contains=javaScriptCommentTodo,javaScriptCvsTag,@Spell fold

"" JSDoc / JSDoc Toolkit
if !exists("javascript_ignore_javaScriptdoc")
  syntax case ignore

  "" syntax coloring for javadoc comments (HTML)
  "syntax include @javaHtml <sfile>:p:h/html.vim
  "unlet b:current_syntax

  syntax region javaScriptDocComment      matchgroup=javaScriptComment start="/\*\*\s*"  end="\*/" contains=javaScriptDocTags,javaScriptCommentTodo,javaScriptCvsTag,@javaScriptHtml,@Spell fold

  " tags containing a param
  syntax match  javaScriptDocTags         contained "@\(augments\|base\|borrows\|class\|constructs\|default\|exception\|exports\|extends\|file\|member\|memberOf\|module\|name\|namespace\|optional\|requires\|title\|throws\|version\)\>" nextgroup=javaScriptDocParam skipwhite
  " tags containing type and param
  syntax match  javaScriptDocTags         contained "@\(argument\|param\|property\)\>" nextgroup=javaScriptDocType skipwhite
  " tags containing type but no param
  syntax match  javaScriptDocTags         contained "@\(type\|return\|returns\)\>" nextgroup=javaScriptDocTypeNoParam skipwhite
  " tags containing references
  syntax match  javaScriptDocTags         contained "@\(lends\|link\|see\)\>" nextgroup=javaScriptDocSeeTag skipwhite
  " other tags (no extra syntax)
  syntax match  javaScriptDocTags         contained "@\(access\|addon\|alias\|author\|beta\|constant\|constructor\|copyright\|deprecated\|description\|event\|example\|exec\|field\|fileOverview\|fileoverview\|function\|global\|ignore\|inner\|license\|overview\|private\|protected\|project\|public\|readonly\|since\|static\)\>"

  syntax region javaScriptDocType         start="{" end="}" oneline contained nextgroup=javaScriptDocParam skipwhite
  syntax match  javaScriptDocType         contained "\%(#\|\"\|\w\|\.\|:\|\/\)\+" nextgroup=javaScriptDocParam skipwhite
  syntax region javaScriptDocTypeNoParam  start="{" end="}" oneline contained
  syntax match  javaScriptDocTypeNoParam  contained "\%(#\|\"\|\w\|\.\|:\|\/\)\+"
  syntax match  javaScriptDocParam        contained "\%(#\|\"\|{\|}\|\w\|\.\|:\|\/\)\+"
  syntax region javaScriptDocSeeTag       contained matchgroup=javaScriptDocSeeTag start="{" end="}" contains=javaScriptDocTags

  syntax case match
endif   "" JSDoc end

syntax case match

"" Syntax in the JavaScript code
syntax match   javaScriptSpecial        "\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\."
syntax region  javaScriptStringD        start=+"+  skip=+\\\\\|\\$"+  end=+"+  contains=javaScriptSpecial,@htmlPreproc
syntax region  javaScriptStringS        start=+'+  skip=+\\\\\|\\$'+  end=+'+  contains=javaScriptSpecial,@htmlPreproc
syntax region  javaScriptRegexpCharClass start=+\[\]\|\[^\]\|\[+ end=+\]+ contained
syntax region  javaScriptRegexpString   start=+\(\(\(return\|case\)\s\+\)\@<=\|\(\([)\]"']\|\d\|\w\)\s*\)\@<!\)/\(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{,3}+ contains=javaScriptSpecial,javaScriptRegexpCharClass,@htmlPreproc oneline
syntax match   javaScriptNumber         /\<-\=\d\+L\=\>\|\<0[xX]\x\+\>/
syntax match   javaScriptFloat          /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
syntax match   javaScriptLabel          /\(?\s*\)\@<!\<\w\+\(\s*:\)\@=/

"" JavaScript Prototype
syntax keyword javaScriptPrototype      prototype

"" Programm Keywords
syntax keyword javaScriptSource         import export
syntax keyword javaScriptType           const undefined var void yield 
syntax keyword javaScriptOperator       delete new in instanceof let typeof
syntax keyword javaScriptBoolean        true false
syntax keyword javaScriptNull           null
syntax keyword javaScriptThis           this

"" Statement Keywords
syntax keyword javaScriptConditional    if else
syntax keyword javaScriptRepeat         do while for
syntax keyword javaScriptBranch         break continue switch case default return
syntax keyword javaScriptStatement      try catch throw with finally

syntax keyword javaScriptGlobalObjects  Array Boolean Date Function Infinity JavaArray JavaClass JavaObject JavaPackage Math Number NaN Object Packages RegExp String Undefined java netscape sun

syntax keyword javaScriptExceptions     Error EvalError RangeError ReferenceError SyntaxError TypeError URIError

syntax keyword javaScriptFutureKeys     abstract enum int short boolean export interface static byte extends long super char final native synchronized class float package throws goto private transient debugger implements protected volatile double import public

"" DOM/HTML/CSS specified things

  " DOM2 Objects
  syntax keyword javaScriptGlobalObjects  DOMImplementation DocumentFragment Document Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction
  syntax keyword javaScriptExceptions     DOMException

  " DOM2 CONSTANT
  syntax keyword javaScriptDomErrNo       INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
  syntax keyword javaScriptDomNodeConsts  ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE

  " HTML events and internal variables
  syntax case ignore
  syntax keyword javaScriptHtmlEvents     onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize
  syntax case match

" Follow stuff should be highligh within a special context
" While it can't be handled with context depended with Regex based highlight
" So, turn it off by default
if exists("javascript_enable_domhtmlcss")

    " DOM2 things
    syntax match javaScriptDomElemAttrs     contained /\%(nodeName\|nodeValue\|nodeType\|parentNode\|childNodes\|firstChild\|lastChild\|previousSibling\|nextSibling\|attributes\|ownerDocument\|namespaceURI\|prefix\|localName\|tagName\)\>/
    syntax match javaScriptDomElemFuncs     contained /\%(insertBefore\|replaceChild\|removeChild\|appendChild\|hasChildNodes\|cloneNode\|normalize\|isSupported\|hasAttributes\|getAttribute\|setAttribute\|removeAttribute\|getAttributeNode\|setAttributeNode\|removeAttributeNode\|getElementsByTagName\|getAttributeNS\|setAttributeNS\|removeAttributeNS\|getAttributeNodeNS\|setAttributeNodeNS\|getElementsByTagNameNS\|hasAttribute\|hasAttributeNS\)\>/ nextgroup=javaScriptParen skipwhite
    " HTML things
    syntax match javaScriptHtmlElemAttrs    contained /\%(className\|clientHeight\|clientLeft\|clientTop\|clientWidth\|dir\|id\|innerHTML\|lang\|length\|offsetHeight\|offsetLeft\|offsetParent\|offsetTop\|offsetWidth\|scrollHeight\|scrollLeft\|scrollTop\|scrollWidth\|style\|tabIndex\|title\)\>/
    syntax match javaScriptHtmlElemFuncs    contained /\%(blur\|click\|focus\|scrollIntoView\|addEventListener\|dispatchEvent\|removeEventListener\|item\)\>/ nextgroup=javaScriptParen skipwhite

    " CSS Styles in JavaScript
    syntax keyword javaScriptCssStyles      contained color font fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant fontWeight letterSpacing lineBreak lineHeight quotes rubyAlign rubyOverhang rubyPosition
    syntax keyword javaScriptCssStyles      contained textAlign textAlignLast textAutospace textDecoration textIndent textJustify textJustifyTrim textKashidaSpace textOverflowW6 textShadow textTransform textUnderlinePosition
    syntax keyword javaScriptCssStyles      contained unicodeBidi whiteSpace wordBreak wordSpacing wordWrap writingMode
    syntax keyword javaScriptCssStyles      contained bottom height left position right top width zIndex
    syntax keyword javaScriptCssStyles      contained border borderBottom borderLeft borderRight borderTop borderBottomColor borderLeftColor borderTopColor borderBottomStyle borderLeftStyle borderRightStyle borderTopStyle borderBottomWidth borderLeftWidth borderRightWidth borderTopWidth borderColor borderStyle borderWidth borderCollapse borderSpacing captionSide emptyCells tableLayout
    syntax keyword javaScriptCssStyles      contained margin marginBottom marginLeft marginRight marginTop outline outlineColor outlineStyle outlineWidth padding paddingBottom paddingLeft paddingRight paddingTop
    syntax keyword javaScriptCssStyles      contained listStyle listStyleImage listStylePosition listStyleType
    syntax keyword javaScriptCssStyles      contained background backgroundAttachment backgroundColor backgroundImage gackgroundPosition backgroundPositionX backgroundPositionY backgroundRepeat
    syntax keyword javaScriptCssStyles      contained clear clip clipBottom clipLeft clipRight clipTop content counterIncrement counterReset cssFloat cursor direction display filter layoutGrid layoutGridChar layoutGridLine layoutGridMode layoutGridType
    syntax keyword javaScriptCssStyles      contained marks maxHeight maxWidth minHeight minWidth opacity MozOpacity overflow overflowX overflowY verticalAlign visibility zoom cssText
    syntax keyword javaScriptCssStyles      contained scrollbar3dLightColor scrollbarArrowColor scrollbarBaseColor scrollbarDarkShadowColor scrollbarFaceColor scrollbarHighlightColor scrollbarShadowColor scrollbarTrackColor

    " Highlight ways
    syntax match javaScriptDotNotation      "\." nextgroup=javaScriptPrototype,javaScriptDomElemAttrs,javaScriptDomElemFuncs,javaScriptHtmlElemAttrs,javaScriptHtmlElemFuncs
    syntax match javaScriptDotNotation      "\.style\." nextgroup=javaScriptCssStyles

endif "DOM/HTML/CSS

"" end DOM/HTML/CSS specified things


"" Code blocks
syntax cluster javaScriptAll       contains=javaScriptComment,javaScriptLineComment,javaScriptDocComment,javaScriptStringD,javaScriptStringS,javaScriptRegexpString,javaScriptNumber,javaScriptFloat,javaScriptLabel,javaScriptSource,javaScriptThis,javaScriptType,javaScriptOperator,javaScriptBoolean,javaScriptNull,javaScriptFunction,javaScriptConditional,javaScriptRepeat,javaScriptBranch,javaScriptStatement,javaScriptGlobalObjects,javaScriptExceptions,javaScriptFutureKeys,javaScriptDomErrNo,javaScriptDomNodeConsts,javaScriptHtmlEvents,javaScriptDotNotation
syntax region  javaScriptBracket   matchgroup=javaScriptBracket transparent start="\[" end="\]" contains=@javaScriptAll,javaScriptParensErrB,javaScriptParensErrC,javaScriptBracket,javaScriptParen,javaScriptBlock,@htmlPreproc
syntax region  javaScriptParen     matchgroup=javaScriptParen   transparent start="("  end=")"  contains=@javaScriptAll,javaScriptParensErrA,javaScriptParensErrC,javaScriptParen,javaScriptBracket,javaScriptBlock,@htmlPreproc
syntax region  javaScriptBlock     matchgroup=javaScriptBlock   transparent start="{"  end="}"  contains=@javaScriptAll,javaScriptParensErrA,javaScriptParensErrB,javaScriptParen,javaScriptBracket,javaScriptBlock,@htmlPreproc 

"" catch errors caused by wrong parenthesis
syntax match   javaScriptParensError    ")\|}\|\]"
syntax match   javaScriptParensErrA     contained "\]"
syntax match   javaScriptParensErrB     contained ")"
syntax match   javaScriptParensErrC     contained "}"

if main_syntax == "javascript"
  syntax sync clear
  syntax sync ccomment javaScriptComment minlines=200
  syntax sync match javaScriptHighlight grouphere javaScriptBlock /{/
endif

"" Fold control
if exists("b:javascript_fold")
    syntax match   javaScriptFunction       /\<function\>/ nextgroup=javaScriptFuncName skipwhite
    syntax match   javaScriptOpAssign       /=\@<!=/ nextgroup=javaScriptFuncBlock skipwhite skipempty
    syntax region  javaScriptFuncName       contained matchgroup=javaScriptFuncName start=/\%(\$\|\w\)*\s*(/ end=/)/ contains=javaScriptLineComment,javaScriptComment nextgroup=javaScriptFuncBlock skipwhite skipempty
    syntax region  javaScriptFuncBlock      contained matchgroup=javaScriptFuncBlock start="{" end="}" contains=@javaScriptAll,javaScriptParensErrA,javaScriptParensErrB,javaScriptParen,javaScriptBracket,javaScriptBlock fold
else
    syntax keyword javaScriptFunction       function
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink javaScriptComment              Comment
  HiLink javaScriptLineComment          Comment
  HiLink javaScriptEnvComment           PreProc
  HiLink javaScriptDocComment           Comment
  HiLink javaScriptCommentTodo          Todo
  HiLink javaScriptCvsTag               Function
  HiLink javaScriptDocTags              Special
  HiLink javaScriptDocSeeTag            Function
  HiLink javaScriptDocType              Type
  HiLink javaScriptDocTypeNoParam       Type
  HiLink javaScriptDocParam             Label
  HiLink javaScriptStringS              String
  HiLink javaScriptStringD              String
  HiLink javaScriptRegexpString         String
  HiLink javaScriptRegexpCharClass      Character
  HiLink javaScriptCharacter            Character
  HiLink javaScriptPrototype            Type
  HiLink javaScriptConditional          Conditional
  HiLink javaScriptBranch               Conditional
  HiLink javaScriptRepeat               Repeat
  HiLink javaScriptStatement            Statement
  HiLink javaScriptFunction             Function
  HiLink javaScriptError                Error
  HiLink javaScriptParensError          Error
  HiLink javaScriptParensErrA           Error
  HiLink javaScriptParensErrB           Error
  HiLink javaScriptParensErrC           Error
  HiLink javaScriptOperator             Operator
  HiLink javaScriptType                 Type
  HiLink javaScriptThis                 Type
  HiLink javaScriptNull                 Type
  HiLink javaScriptNumber               Number
  HiLink javaScriptFloat                Number
  HiLink javaScriptBoolean              Boolean
  HiLink javaScriptLabel                Label
  HiLink javaScriptSpecial              Special
  HiLink javaScriptSource               Special
  HiLink javaScriptGlobalObjects        Special
  HiLink javaScriptExceptions           Special

  HiLink javaScriptDomErrNo             Constant
  HiLink javaScriptDomNodeConsts        Constant
  HiLink javaScriptDomElemAttrs         Label
  HiLink javaScriptDomElemFuncs         PreProc

  HiLink javaScriptHtmlEvents           Special
  HiLink javaScriptHtmlElemAttrs        Label
  HiLink javaScriptHtmlElemFuncs        PreProc

  HiLink javaScriptCssStyles            Label

  delcommand HiLink
endif

" Define the htmlJavaScript for HTML syntax html.vim
"syntax clear htmlJavaScript
"syntax clear javaScriptExpression
syntax cluster  htmlJavaScript contains=@javaScriptAll,javaScriptBracket,javaScriptParen,javaScriptBlock,javaScriptParenError
syntax cluster  javaScriptExpression contains=@javaScriptAll,javaScriptBracket,javaScriptParen,javaScriptBlock,javaScriptParenError,@htmlPreproc

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif

" vim: ts=4
indent/javascript.vim
328
" Vim indent file
" Language:		Javascript
" Maintainer:		Darrick Wiebe <darrick at innatesoftware.com>
" URL:			http://github.com/pangloss/vim-javascript
" Version:              1.0.0
" Last Change:          August 31, 2009
" Acknowledgement:      Based off of vim-ruby maintained by Nikolai Weibull http://vim-ruby.rubyforge.org

" 0. Initialization {{{1
" =================

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal nosmartindent

" Now, set up our indentation expression and keys that trigger it.
setlocal indentexpr=GetJavascriptIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e

" Only define the function once.
if exists("*GetJavascriptIndent")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" 1. Variables {{{1
" ============

" Regex of syntax group names that are or delimit string or are comments.
let s:syng_strcom = 'javaScript\%(String\|RegexpString\|CommentTodo\|LineComment\|Comment\|DocComment\)'

" Regex of syntax group names that are strings.
let s:syng_string = 'javaScript\%(RegexpString\)'

" Regex of syntax group names that are strings or documentation.
let s:syng_stringdoc = 'javaScriptDocComment\|javaScriptComment'

" Expression used to check whether we should skip a match with searchpair().
let s:skip_expr = "synIDattr(synID(line('.'),col('.'),1),'name') =~ '".s:syng_strcom."'"

let s:line_term = '\s*\%(\%(\/\/\).*\)\=$'

" Regex that defines continuation lines, not including (, {, or [.
let s:continuation_regex = '\%([\\*+/.:]\|\%(<%\)\@<![=-]\|\W[|&?]\|||\|&&\)' . s:line_term

" Regex that defines continuation lines.
" TODO: this needs to deal with if ...: and so on
let s:msl_regex = '\%([\\*+/.:([]\|\%(<%\)\@<![=-]\|\W[|&?]\|||\|&&\)' . s:line_term

let s:one_line_scope_regex = '\<\%(if\|else\|for\|while\)\>[^{;]*' . s:line_term

" Regex that defines blocks.
let s:block_regex = '\%({\)\s*\%(|\%([*@]\=\h\w*,\=\s*\)\%(,\s*[*@]\=\h\w*\)*|\)\=' . s:line_term

" 2. Auxiliary Functions {{{1
" ======================

" Check if the character at lnum:col is inside a string, comment, or is ascii.
function s:IsInStringOrComment(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~ s:syng_strcom
endfunction

" Check if the character at lnum:col is inside a string.
function s:IsInString(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~ s:syng_string
endfunction

" Check if the character at lnum:col is inside a string or documentation.
function s:IsInStringOrDocumentation(lnum, col)
  return synIDattr(synID(a:lnum, a:col, 1), 'name') =~ s:syng_stringdoc
endfunction

" Find line above 'lnum' that isn't empty, in a comment, or in a string.
function s:PrevNonBlankNonString(lnum)
  let in_block = 0
  let lnum = prevnonblank(a:lnum)
  while lnum > 0
    " Go in and out of blocks comments as necessary.
    " If the line isn't empty (with opt. comment) or in a string, end search.
    let line = getline(lnum)
    if line =~ '/\*'
      if in_block
        let in_block = 0
      else
        break
      endif
    elseif !in_block && line =~ '\*/'
      let in_block = 1
    elseif !in_block && line !~ '^\s*\%(//\).*$' && !(s:IsInStringOrComment(lnum, 1) && s:IsInStringOrComment(lnum, strlen(line)))
      break
    endif
    let lnum = prevnonblank(lnum - 1)
  endwhile
  return lnum
endfunction

" Find line above 'lnum' that started the continuation 'lnum' may be part of.
function s:GetMSL(lnum, in_one_line_scope)
  " Start on the line we're at and use its indent.
  let msl = a:lnum
  let lnum = s:PrevNonBlankNonString(a:lnum - 1)
  while lnum > 0
    " If we have a continuation line, or we're in a string, use line as MSL.
    " Otherwise, terminate search as we have found our MSL already.
    let line = getline(lnum)
    let col = match(line, s:msl_regex) + 1
    if (col > 0 && !s:IsInStringOrComment(lnum, col)) || s:IsInString(lnum, strlen(line))
      let msl = lnum
    else
      " Don't use lines that are part of a one line scope as msl unless the
      " flag in_one_line_scope is set to 1
      "
      if a:in_one_line_scope 
	break
      end
      let msl_one_line = s:Match(lnum, s:one_line_scope_regex)
      if msl_one_line == 0
	break
      endif
    endif
    let lnum = s:PrevNonBlankNonString(lnum - 1)
  endwhile
  return msl
endfunction

" Check if line 'lnum' has more opening brackets than closing ones.
function s:LineHasOpeningBrackets(lnum)
  let open_0 = 0
  let open_2 = 0
  let open_4 = 0
  let line = getline(a:lnum)
  let pos = match(line, '[][(){}]', 0)
  while pos != -1
    if !s:IsInStringOrComment(a:lnum, pos + 1)
      let idx = stridx('(){}[]', line[pos])
      if idx % 2 == 0
        let open_{idx} = open_{idx} + 1
      else
        let open_{idx - 1} = open_{idx - 1} - 1
      endif
    endif
    let pos = match(line, '[][(){}]', pos + 1)
  endwhile
  return (open_0 > 0) . (open_2 > 0) . (open_4 > 0)
endfunction

function s:Match(lnum, regex)
  let col = match(getline(a:lnum), a:regex) + 1
  return col > 0 && !s:IsInStringOrComment(a:lnum, col) ? col : 0
endfunction

function s:IndentWithContinuation(lnum, ind, width)
  " Set up variables to use and search for MSL to the previous line.
  let p_lnum = a:lnum
  let lnum = s:GetMSL(a:lnum, 1)
  let line = getline(line)

  " If the previous line wasn't a MSL and is continuation return its indent.
  " TODO: the || s:IsInString() thing worries me a bit.
  if p_lnum != lnum
    if s:Match(p_lnum,s:continuation_regex)||s:IsInString(p_lnum,strlen(line))
      return a:ind
    endif
  endif

  " Set up more variables now that we know we aren't continuation bound.
  let msl_ind = indent(lnum)

  " If the previous line ended with [*+/.-=], start a continuation that
  " indents an extra level.
  if s:Match(lnum, s:continuation_regex)
    if lnum == p_lnum
      return msl_ind + a:width
    else
      return msl_ind
    endif
  endif

  return a:ind
endfunction

function s:InOneLineScope(lnum)
  let msl = s:GetMSL(a:lnum, 1)
  if msl > 0 && s:Match(msl, s:one_line_scope_regex)
    return msl
  endif
  return 0
endfunction

function s:ExitingOneLineScope(lnum)
  let msl = s:GetMSL(a:lnum, 1)
  if msl > 0
    " if the current line is in a one line scope ..
    if s:Match(msl, s:one_line_scope_regex)
      return 0
    else
      let prev_msl = s:GetMSL(msl - 1, 1)
      if s:Match(prev_msl, s:one_line_scope_regex)
	return prev_msl
      endif
    endif
  endif
  return 0
endfunction

" 3. GetJavascriptIndent Function {{{1
" =========================

function GetJavascriptIndent()
  " 3.1. Setup {{{2
  " ----------

  " Set up variables for restoring position in file.  Could use v:lnum here.
  let vcol = col('.')

  " 3.2. Work on the current line {{{2
  " -----------------------------

  " Get the current line.
  let line = getline(v:lnum)
  let ind = -1


  " If we got a closing bracket on an empty line, find its match and indent
  " according to it.  For parentheses we indent to its column - 1, for the
  " others we indent to the containing line's MSL's level.  Return -1 if fail.
  let col = matchend(line, '^\s*[]})]')
  if col > 0 && !s:IsInStringOrComment(v:lnum, col)
    call cursor(v:lnum, col)
    let bs = strpart('(){}[]', stridx(')}]', line[col - 1]) * 2, 2)
    if searchpair(escape(bs[0], '\['), '', bs[1], 'bW', s:skip_expr) > 0
      if line[col-1]==')' && col('.') != col('$') - 1
        let ind = virtcol('.')-1
      else
        let ind = indent(s:GetMSL(line('.'), 0))
      endif
    endif
    return ind
  endif

  " If we have a /* or */ set indent to first column.
  if match(line, '^\s*\%(/\*\|\*/\)$') != -1
    return 0
  endif

  " If we are in a multi-line string or line-comment, don't do anything to it.
  if s:IsInStringOrDocumentation(v:lnum, matchend(line, '^\s*') + 1)
    return indent('.')
  endif

  " 3.3. Work on the previous line. {{{2
  " -------------------------------

  " Find a non-blank, non-multi-line string line above the current line.
  let lnum = s:PrevNonBlankNonString(v:lnum - 1)

  " If the line is empty and inside a string, use the previous line.
  if line =~ '^\s*$' && lnum != prevnonblank(v:lnum - 1)
    return indent(prevnonblank(v:lnum))
  endif

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  " Set up variables for current line.
  let line = getline(lnum)
  let ind = indent(lnum)

  " If the previous line ended with a block opening, add a level of indent.
  if s:Match(lnum, s:block_regex)
    return indent(s:GetMSL(lnum, 0)) + &sw
  endif

  " If the previous line contained an opening bracket, and we are still in it,
  " add indent depending on the bracket type.
  if line =~ '[[({]'
    let counts = s:LineHasOpeningBrackets(lnum)
    if counts[0] == '1' && searchpair('(', '', ')', 'bW', s:skip_expr) > 0
      if col('.') + 1 == col('$')
        return ind + &sw
      else
        return virtcol('.')
      endif
    elseif counts[1] == '1' || counts[2] == '1'
      return ind + &sw
    else
      call cursor(v:lnum, vcol)
    end
  endif

  " 3.4. Work on the MSL line. {{{2
  " --------------------------

  let ind_con = ind
  let ind = s:IndentWithContinuation(lnum, ind_con, &sw)

  " }}}2
  "
  "
  let ols = s:InOneLineScope(lnum)
  if ols > 0
    let ind = ind + &sw
  else
    let ols = s:ExitingOneLineScope(lnum)
    while ols > 0 && ind > 0
      let ind = ind - &sw
      let ols = s:InOneLineScope(ols - 1)
    endwhile
  endif

  return ind
endfunction

" }}}1

let &cpo = s:cpo_save
unlet s:cpo_save

" vim:set sw=2 sts=2 ts=8 noet:

