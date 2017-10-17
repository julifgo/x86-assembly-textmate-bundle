; SYNTAX TEST "Packages/User/x86_64 Assembly.tmbundle/Syntaxes/x86_64 Assembly.sublime-syntax"

%if<condition> 
;<- punctuation.definition.keyword.preprocessor
;^^ keyword.control.preprocessor
    push %1
;   ^^^^ keyword.operator.word.mnemonic
;         ^ invalid.illegal
%elif<condition2> 
;<- punctuation.definition.keyword.preprocessor
;^^^^ keyword.control.preprocessor
%else 
;<- punctuation.definition.keyword.preprocessor
;^^^^ keyword.control.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%ifn
;<- punctuation.definition.keyword.preprocessor
;^^^ keyword.control.preprocessor
%elifn 
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%macro asdf 3
  %if %0
      push  %1
;     ^^^^ keyword.operator.word.mnemonic
;            ^ variable.other.preprocessor - invalid.illegal
  %endif
%endmacro

%ifdef DEBUG
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor
;      ^^^^^ entity.name.constant.preprocessor
    push %1
;   ^^^^ keyword.operator.word.mnemonic
;         ^ invalid.illegal
;^^^^^^^^^^ meta.block
%else
;<- punctuation.definition.keyword.preprocessor
;^^^^ keyword.control.preprocessor
    push %2
;   ^^^^ keyword.operator.word.mnemonic
;         ^ invalid.illegal
;^^^^^^^^^^ meta.block
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%ifndef DEBUG
;<- punctuation.definition.keyword.preprocessor
;^^^^^^ keyword.control.preprocessor
;       ^^^^^ entity.name.constant.preprocessor
%elifdef RELEASE
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^ keyword.control.preprocessor
;        ^^^^^^^ entity.name.constant.preprocessor
%elifndef TEST
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^ keyword.control.preprocessor
;         ^^^^ entity.name.constant.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%macro mymacro 2
%ifdef DEBUG
    push %1
;   ^^^^ keyword.operator.word.mnemonic
;         ^ variable.other.preprocessor - invalid.illegal
;^^^^^^^^^^ meta.block
%else
    push %2
;         ^ variable.other.preprocessor - invalid.illegal
;^^^^^^^^^^ meta.block
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor
%endmacro

%ifmacro MyMacro 1-3+.nolist
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^ keyword.control.preprocessor
;        ^^^^^^^ entity.name.function.preprocessor
;                ^^^ variable.parameter.preprocessor
;                   ^^^^^^^^ storage.modifier
     %error "MyMacro 1-3" causes a conflict with an existing macro. 
%else 
     %macro MyMacro 1-3+.nolist
             ; insert code to define the macro 
     %endmacro 
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%ifnmacro MyMacro 1-3+.nolist
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^ keyword.control.preprocessor
;         ^^^^^^^ entity.name.function.preprocessor
;                 ^^^ variable.parameter.preprocessor
;                    ^^^^^^^^ storage.modifier

%elifmacro MyMacro 1
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^^ keyword.control.preprocessor
;          ^^^^^^^ entity.name.function.preprocessor
;                  ^ variable.parameter.preprocessor

%elifnmacro MyMacro 2-*
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^^^ keyword.control.preprocessor
;           ^^^^^^^ entity.name.function.preprocessor
;                   ^^^ variable.parameter.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%ifctx ctx
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor
;      ^^^ entity.name.constant.preprocessor
%elifctx ctx
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^ keyword.control.preprocessor
;        ^^^ entity.name.constant.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%ifnctx ctx
;<- punctuation.definition.keyword.preprocessor
;^^^^^^ keyword.control.preprocessor
;       ^^^ entity.name.constant.preprocessor
%elifnctx ctx
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^ keyword.control.preprocessor
;         ^^^ entity.name.constant.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%macro if 1 
  %push if 
  j%-1  %$ifnot 
  %%label %0
%endmacro 
%macro else 0 
  %ifctx if 
        %repl   else 
        jmp     %$ifend 
        %$ifnot: 
  %else 
        %error  "expected `if' before `else'" 
  %endif 
  %%label %0
%endmacro 
%macro endif 0 
  %ifctx if 
        %$ifnot: 
        %pop 
  %elifctx      else 
        %$ifend: 
        %pop 
  %else 
        %error  "expected `if' or `else' before `endif'" 
  %endif 
  %%label %0
%endmacro

%ifidn text1,text2
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor
    push %1
;   ^^^^ keyword.operator.word.mnemonic
;         ^ invalid.illegal
%elifidn text1,text2
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^ keyword.control.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%ifidni text1,text2
;<- punctuation.definition.keyword.preprocessor
;^^^^^^ keyword.control.preprocessor
%elifidni text1,text2
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^ keyword.control.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%ifnidn text1,text2
;<- punctuation.definition.keyword.preprocessor
;^^^^^^ keyword.control.preprocessor
%elifnidn text1,text2
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^ keyword.control.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%ifnidni text1,text2
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^ keyword.control.preprocessor
%elifnidni text1,text2
;<- punctuation.definition.keyword.preprocessor
;^^^^^^^^^ keyword.control.preprocessor
%endif
;<- punctuation.definition.keyword.preprocessor
;^^^^^ keyword.control.preprocessor

%macro  pushparam 1 
  %%label %0
  %ifidni %1,ip 
        call    %%label 
        push    %1
;       ^^^^ keyword.operator.word.mnemonic
;                ^ variable.other.preprocessor - invalid.illegal
  %%label: 
  %else 
        push    %1 
  %endif 
  %%label %0
%endmacro
;^ - invalid.illegal

%else
;^^^^ invalid.illegal
%elif
;^^^^ invalid.illegal
%elifn
;^^^^^ invalid.illegal
%endif
;^^^^^ invalid.illegal
%elifdef RELEASE
;^^^^^^^ invalid.illegal
%elifndef RELEASE
;^^^^^^^^ invalid.illegal
%elifmacro MyMacro 1
;^^^^^^^^^ invalid.illegal
%elifnmacro MyMacro 2-*
;^^^^^^^^^^ invalid.illegal
%elifctx
;^^^^^^^ invalid.illegal
%elifnctx
;^^^^^^^^ invalid.illegal
%elifidn text1,text2
%elifidni text1,text2
%elifnidn text1,text2
%elifnidni text1,text2
