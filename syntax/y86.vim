" Vim syntax file
" Language: y86 Assembly .ys
" Maintainer: Will Toher
" Latest Revision: 13 Oct 2017
" Filenames: *.ys

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn region y86Comment start="#" end="$" contains=y86Todo
syn region y86Comment start="/\*" end="\*/" contains=y86Todo
syn keyword y86Todo containedin=y86Comment contained    TODO FIXME XXX NOTE
syn match y86Comment contains=y86Todo                   "#.*$"  " Match #, then any number of characters, then the end of the line

syn match y86Divider +|+
syn match y86InstructionAddrEmpty "^0x[0-9a-f]*:\s*|" containedin=ALLBUT,y86Comment
syn match y86InstructionAddr "^0x[0-9a-f]*:" containedin=ALLBUT,y86Comment

syn keyword y86BasicInstructions       halt nop
syn match y86MoveInstructions          "rrmov\(l\|q\)\|irmov\(l\|q\)\|rmmov\(l\|q\)\|mrmov\(l\|q\)"
syn match y86OperationInstructions     "add\(l\|q\)\|sub\(l\|q\)\|and\(l\|q\)\|xor\(l\|q\)"
syn keyword y86OperationInstructions   iaddq
syn keyword y86BranchInstructions      jmp jle jl je jne jge jg
syn keyword y86TransferInstructions    cmovle cmovl cmove cmovne cmovge cmovg
syn keyword y86StackInstructions       call ret 
syn match y86StackInstructions         "push\(l\|q\)\|pop\(l\|q\)"
syn keyword y86AssemblerDirectives     .pos .align .long .quad
syn match y86MemoryAccession "(\|)"

syn match y86Registers      "%\(r\|e\)\([a-d]x\|[sd]i\|[sb]p\)"  " Match %, then 'r' or 'e', then (a through d)x or (s or d)i or (s or b)p
syn match y86Registers      "%r\([8-9]\|1[0-4]\)"

syn match y86Label "^[^#]*:" containedin=ALLBUT,y86Comment       " Any number of non-'#' characters at the beginning of a line, followed by ':'
syn match y86Literal "\$-\=[0-9]*"          " Match '$', followed by 0 or 1 '-' characters, followed by any number of decimal digits
syn match y86Literal "\$-\=0x[0-9,a-f,A-F]*"
syn match y86Hex "0x-\=[0-9,a-f,A-F]*"      " Match '0x', followed by 0 or 1 '-' characters, followed by any number of hex digits

let b:current_syntax = "y86"


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_dis_syntax_inits")
  if version < 508
    let did_dis_syntax_inits = 1
    command -nargs=+ HiLink highlight link <args>
  else
    command -nargs=+ HiLink highlight def link <args>
  endif

  " Constant: String, Character, Number, Boolean, Float
  " Identifier: Function
  " Statement: Conditional, Repeat, Label, Operator, Keyword, Exception
  " PreProc: Include, Define, Macro, PreCondit
  " Type: StorageClass, Structure, Typedef
  " Special: SpecialChar, Tag, Delimiter, SpecialComment, Debug

  HiLink y86Comment                 Comment
  HiLink y86Todo                    Todo
  HiLink y86Hex                     Constant
  HiLink y86Literal                 Constant
  HiLink y86Registers               Identifier
  HiLink y86BasicInstructions       Type
  HiLink y86MoveInstructions        Type
  HiLink y86BranchInstructions      Type
  HiLink y86OperationInstructions   Type
  HiLink y86TransferInstructions    Type
  HiLink y86StackInstructions       Type
  HiLink y86MemoryAccession         PreProc
  HiLink y86Label                   PreProc
  HiLink y86AssemblerDirectives     PreProc
  " HiLink disHexDump     Identifier
  " HiLink disTitle       Typedef
  " Underlined
  " Ignore
  " Error
  " Todo

  delcommand HiLink
endif

let &cpo = s:cpo_save
unlet s:cpo_save

