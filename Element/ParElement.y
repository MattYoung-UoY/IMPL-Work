-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParElement where
import AbsElement
import LexElement
import ErrM

}

%name pListElement ListElement
%name pElement Element
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token

L_CIdent { PT _ (T_CIdent $$) }
L_TeX { PT _ (T_TeX $$) }
L_Weird { PT _ (T_Weird $$) }
L_Subscript { PT _ (T_Subscript $$) }


%%

CIdent    :: { CIdent} : L_CIdent { CIdent ($1)}
TeX    :: { TeX} : L_TeX { TeX ($1)}
Weird    :: { Weird} : L_Weird { Weird ($1)}
Subscript    :: { Subscript} : L_Subscript { Subscript ($1)}

ListElement :: { [Element] }
ListElement : {- empty -} { [] }
            | ListElement Element { flip (:) $1 $2 }
Element :: { Element }
Element : CIdent { AbsElement.Cid $1 }
        | TeX { AbsElement.Tex $1 }
        | Weird { AbsElement.Wrd $1 }
        | Subscript { AbsElement.Sub $1 }
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

