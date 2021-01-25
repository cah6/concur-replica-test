{-# LANGUAGE OverloadedStrings #-}

module Main where

import Concur.Core
import Concur.Replica
import Concur.Replica.DOM
import qualified Data.Map                   as M
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import Network.WebSockets.Connection (defaultConnectionOptions)

import Prelude hiding (div)

counter :: Int -> Widget HTML a
counter x = do
  click <- div []
    [ Left  <$> div [ onClick ] [ text "-" ]
    , text $ T.pack $ show x
    , Right <$> button [ onClick ] [ text "+" ]
    ]

  case click of
    Left _  -> counter (x - 1)
    Right _ -> counter (x + 1)

main :: IO ()
main = run 8080 indexHtml defaultConnectionOptions Prelude.id $ \_ctx ->
  (counter 0)

indexHtml :: HTML
indexHtml =
  [ VLeaf "!doctype" (fl [("html", ABool True)]) Nothing
  , VNode "html" mempty Nothing
      [ VNode "head" mempty Nothing $
          [ VLeaf "meta" (fl [("charset", AText "utf-8")]) Nothing
          , VNode "title" mempty Nothing [VText "concur-replica-test"]
          , VNode "link" mempty Nothing
            [ VNode "rel" mempty Nothing [VText "stylesheet"]
            , VNode "href" mempty Nothing [VText "https://cdn.jsdelivr.net/npm/bulma@0.8.0/css/bulma.min.css"]
            ]
          ]
      , VNode "body" mempty Nothing
          [ VNode "script" (fl [("language", AText "javascript")]) Nothing
              [ VRawText $ T.decodeUtf8 clientDriver ]
          ]
      ]
  ]
  where
    fl = M.fromList
