module Test.Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Nullable (toNullable)
import Node.HTTP (listen)
import Node.HTTP as HTTP
import Node.Websocket (ConnectionClose, ConnectionMessage, EventProxy(EventProxy), Request, on)
import Node.Websocket.Connection (remoteAddress, sendMessage)
import Node.Websocket.Request (accept, origin)
import Node.Websocket.Server (newWebsocketServer)
import Node.Websocket.Types (TextFrame(..), defaultServerConfig)

data AppState

-- Echo websocket server
main :: Effect Unit
main = do

  httpServer <- HTTP.createServer \ _ _ -> log "Server created"
  listen
    httpServer
    {hostname: "localhost", port: 2718, backlog: Nothing} do
      log "Server now listening"

  wsServer <- newWebsocketServer (defaultServerConfig httpServer)

  on request wsServer \ req -> do
    log do
      "New connection from: " <> show (origin req)
    conn <- accept req (toNullable Nothing) (origin req)

    log "New connection accepted"

    on message conn \ msg -> do

      case msg of
        Left (TextFrame {utf8Data}) -> do
          log ("Received message: " <> utf8Data)
          pure unit
        Right _ -> pure unit

      sendMessage conn msg

    on close conn \ _ _ -> do
      log ("Peer disconnected " <> remoteAddress conn)
  where
    close = EventProxy :: EventProxy ConnectionClose
    message = EventProxy :: EventProxy ConnectionMessage
    request = EventProxy :: EventProxy Request
