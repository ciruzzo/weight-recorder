{-# LANGUAGE OverloadedStrings #-}

module Web.Action.Register (registerAction) where

import Control.Monad  (when)
import Model.User     (NewUser (NewUser), insertUser)
import Web.Core       (WRAction, runSqlite)
import Web.Spock      (param')
import Web.View.Start (startView)

registerAction :: WRAction a
registerAction = do
  name <- param' "name"
  password <- param' "password"
  when (null name || null password) $ startView (Just "There are empty items")
  n <- runSqlite $ insertUser (NewUser name password)
  when (n <= 0) $ startView (Just "Register failed")
  startView (Just "Registered. please login.")
