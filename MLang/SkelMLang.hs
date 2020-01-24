module SkelMLang where

-- Haskell module generated by the BNF converter

import AbsMLang
import ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transMPro :: MPro -> Result
transMPro x = case x of
  Program com -> failure x
transCom :: Com -> Result
transCom x = case x of
  Command ins -> failure x
  IString string com -> failure x
transIns :: Ins -> Result
transIns x = case x of
  Instruction -> failure x

