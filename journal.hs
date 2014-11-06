------------------------------------------------------------------------------
-- |
--  Module      : Main
--  Description : an example site using Hakyll Journal
--  Copyright   : (c) 2014, Travis Cardwell and Rob Nugen
--  License     : MIT
--  Maintainer  : Travis Cardwell <travis.cardwell@extellisys.com>
--  Stability   : experimental
--
-- This is an example site using Hakyll Journal, a Hakyll module for adding a
-- journal/diary to your static website.
------------------------------------------------------------------------------

module Main where

-- [HP] http://hackage.haskell.org/package/base
import Data.Monoid ((<>))

-- http://hackage.haskell.org/package/hakyll
import Hakyll

--------------------------------------------------------------------------------
-- main

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
      route idRoute
      compile copyFileCompiler

    match "css/*" $ do
      route idRoute
      compile compressCssCompiler

    match (fromList ["about.md", "contact.md"]) $ do
      route $ setExtension "html"
      compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/default.html" defaultContext
        >>= relativizeUrls

    match "posts/*" $ do
      route $ setExtension "html"
      compile $ pandocCompiler
        >>= loadAndApplyTemplate "templates/post.html" postCtx
        >>= loadAndApplyTemplate "templates/default.html" postCtx
        >>= relativizeUrls

    create ["archive.html"] $ do
      route idRoute
      compile $ do
        posts <- recentFirst =<< loadAll "posts/*"
        let archiveCtx = listField "posts" postCtx (return posts) <>
                         constField "title" "Archives" <>
                         defaultContext
        makeItem ""
          >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
          >>= loadAndApplyTemplate "templates/default.html" archiveCtx
          >>= relativizeUrls

    match "index.html" $ do
      route idRoute
      compile $ do
        posts <- recentFirst =<< loadAll "posts/*"
        let indexCtx = listField "posts" postCtx (return posts) <>
                       constField "title" "Home" <>
                       defaultContext
        getResourceBody
          >>= applyAsTemplate indexCtx
          >>= loadAndApplyTemplate "templates/default.html" indexCtx
          >>= relativizeUrls

    match "templates/*" $ compile templateCompiler

--------------------------------------------------------------------------------
-- contexts

postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" <>
    defaultContext
