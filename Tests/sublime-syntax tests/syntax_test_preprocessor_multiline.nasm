; SYNTAX TEST "Packages/User/x86_64 Assembly.tmbundle/Syntaxes/x86_64 Assembly.sublime-syntax"

%macro  silly  2
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.import
;       ^^^^^ entity.name.function
;              ^ variable.parameter
    %2: db      %1
;   ^ punctuation.definition.variable
;    ^ variable.other.preprocessor
;^^^^^^^^^^^^^^^^^ meta.preprocessor.macro
%endmacro 
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^ keyword.control.import
        silly 'a', letter_a             ; letter_a:  db 'a'
        silly 'ab', string_ab           ; string_ab: db 'ab'
        silly {13,10}, crlf             ; crlf:      db 13,10
        %1                              ; should be invalid outside of multi-line macro
;        ^ invalid.illegal
%macro  retz 0
        jnz     %%skip
;               ^^ punctuation.definition.keyword.preprocessor
;                 ^^^^ entity.name.constant
        ret
    %%skip:
;   ^^ punctuation.definition.keyword.preprocessor
;     ^^^^ entity.name.constant
;         ^ punctuation.separator
%endmacro
    %%macro_label: ; invalid outside of macro
;     ^^^^^^^^^^^ invalid.illegal

%macro  level1  0
    %%level1_label:

    %macro      level2  0
        %%level2_label:
    %endmacro

    %%still_level1_label:
%endmacro
%%and_now_its_invalid:

%macro  writefile 2+
;                  ^ storage.modifier
        jmp     %%endstr 
  %%str:        db      %2 
  %%endstr: 
        mov     dx,%%str 
        mov     cx,%%endstr-%%str 
        mov     bx,%1 
        mov     ah,0x40 
        int     0x21 
%endmacro
writefile [filehandle],"hello, world",13,10
writefile [filehandle], {"hello, world",13,10}

%macro mpar 1-*
;           ^^^ variable.parameter
;            ^ keyword.operator
     db %{3:%[__BITS__]}
;       ^^ meta.preprocessor
;       ^ punctuation.definition
;        ^ punctuation.section.braces.begin
;          ^ punctuation.separator
;        ^^^^^^^^^^^^^^^ meta.braces
;            ^^^^^^^^^^ meta.brackets
;                      ^ punctuation.section.braces.end
%endmacro 
mpar 1,2,3,4,5,6

%macro  die 0-1 "Painful program death has occurred." 
        writefile 2,%1 
        mov     ax,0x4c01 
        int     0x21 
%endmacro

%macro foobar 1-3 mov,eax,[ebx+2]
%endmacro

%macro die 0-1+ "Painful program death has occurred.",13,10
%endmacro