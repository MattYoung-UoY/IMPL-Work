-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParMLang where
import AbsMLang
import LexMLang
import ErrM

}

%name pListMPro ListMPro
%name pMPro MPro
%name pCom Com
%name pIns Ins
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  ':' { PT _ (TS _ 1) }
  ';' { PT _ (TS _ 2) }
  'I' { PT _ (TS _ 3) }

L_quoted { PT _ (TL $$) }


%%

String  :: { String }  : L_quoted {  $1 }

ListMPro :: { [MPro] }
ListMPro : MPro { (:[]) $1 } | MPro ';' ListMPro { (:) $1 $3 }
MPro :: { MPro }
MPro : Com { AbsMLang.Program $1 }
Com :: { Com }
Com : Ins { AbsMLang.Command $1 }
    | String ':' Com { AbsMLang.IString $1 $3 }
Ins :: { Ins }
Ins : 'I' { AbsMLang.Instruction }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    t:_ -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens
}
