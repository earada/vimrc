" Vim syntax file for 88110 emulator
" Language:     ens
" Maintainer:   earada <edu@hardcoders.org>
" Last Change:  2011 Nov 25

"Memory address
syn 	match 		numeros						"-\=[0-9]*,\="
syn 	match 		hexadecimal					"0x[0-9A-Fa-f]*,\="
syn		match		registros					"\(r[1-2][0-9],\=\|r30,\=\|r31,\=\|r[0-9],\=\)"
syn 	match 		etiquetas					"^[a-zA-Z_][a-zA-Z0-9_]*:"
syn		match		instrucciones_logicas		"\(\(xor\|and\|or\)\(.[cu]\)\=\|masku\=\)"
syn		match		instrucciones_aritmeticas	"\(addu\=\(.cio\|.co\|.ci\)\=\|subu\=\|cmp\|\(mul\|div\)s\|\(mul\|div\)u\(.d\)\=\)"
syn		match		instrucciones_bifucacion	"\(bb[0-1]\|bs\=r\|jmp\|jsr\)"
syn		match		instrucciones_transferencia	"\(\(ld\|st\)cr\|\(ld\|st\)\(.[bhd]u\=\)\=\|xmem\)"
syn		match		instrucciones_cbit			"\(clr\|set\|extu\=\|mak\|rot\|stop\)"
syn		match		instrucciones_float			"\(f\(add\|sub\|mul\|div\).[sd][sd][sd]\|fcvt.\(sd\|ds\)\|flt.[sd]s\|int.s[sd]\|fcmp.s[sd][sd]\)"

"Comments
syn 	region  	comentario   				start="\;" skip="\\$" end="$"
syn 	region  	cadena   					start="\"" end="\""

"Reserved words (keywords)
syn		keyword 	palabras_reservadas 		org data MACRO ENDMACRO high low
syn		keyword 	comparacion			 		nh he nb be hs lo ls hi ge lt le gt ne eq

"Format
hi def link 		comentario     				Comment
hi def 				registros					ctermfg=green
hi def  			palabras_reservadas			ctermfg=red
hi def				etiquetas					ctermfg=blue
hi def link 		comparacion					Statement
hi def link 		instrucciones_logicas		Statement
hi def link 		instrucciones_aritmeticas	Statement
hi def link 		instrucciones_bifucacion	Statement
hi def link 		instrucciones_transferencia	Statement
hi def link 		instrucciones_cbit			Statement
hi def link 		instrucciones_float			Statement
hi def 				numeros						ctermfg=green
hi def 				cadena						ctermfg=yellow
hi def 				hexadecimal					ctermfg=green
