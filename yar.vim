" Vim syntax file for yara rules
" Language:     yara
" Maintainer:   earada <earada@alienvault.com>
" Last Change:  2013 Mar 17
" Add the following line to you .vimrc:
" au BufNewfile,bufRead *.yar setf yar

syn	match		num			"\<[0-9]\+\(KB\|MB\)\=\>"
syn	match		numhex		"\<0x[0-9a-fA-F]\+\>"
syn	match		variable	"[\$@#]\([0-9a-zA-Z_]\+\*\=\)\="
syn	match		bytes		"{\s*\(\([0-9a-fA-F?]\{2\}\)\|\(\[[0-9a-fA-F-]*\]\)\|\((\([0-9a-fA-F?]\{2\}\||\|\s\)*)\)\|\s\)*}"
syn	match		contains	"\<contains\>"

syn	region		comments	start="\/\/" skip="\\$" end="$"
syn	region		comments	start="\/\*" skip="\\$" end="\*\/"
syn	region		strings		start="\"" end="\""
syn	region		regex		start="\/[^\/\*]" skip="\\/" end="\/"

syn	keyword		rules		rule private global include
syn	keyword		sections	condition strings meta
syn	keyword		casts		int8 int16 int32 uint8 uint16 uint32
syn	keyword		operand		in and at or not of false true
syn	keyword		res_word	all any index ascii indexes entrypoint matches filesize nocase fullword for rva section them wide

hi def link		variable	Keyword
hi def link		res_word	Keyword
hi def link		strings		String
hi def link		bytes		String
hi def link		rules		Identifier
hi def link		sections	Identifier
hi def link		regex		String
hi def link		operand		Conditional
hi def link		casts		Function
hi def link		comments	Comment
hi def link		numhex		Number
hi def link		num			numhex
hi def link		contains	res_word
