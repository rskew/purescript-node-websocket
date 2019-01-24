module Node.Websocket.Server where

import Prelude
import Effect (Effect)

import Node.Websocket.Types (CloseDescription, CloseReason, ServerConfig, WSConnection, WSRequest, WSServer)

foreign import newWebsocketServer :: ServerConfig -> Effect WSServer

type RequestCallback e = WSRequest -> Effect Unit

foreign import onRequest :: forall e. WSServer -> RequestCallback e -> Effect Unit

type ConnectCallback e = WSConnection -> Effect Unit

foreign import onConnect :: forall e. WSServer -> ConnectCallback e -> Effect Unit

type CloseCallback e =
  WSConnection -> CloseReason -> CloseDescription -> Effect Unit

foreign import onClose :: forall e. WSServer -> CloseCallback e -> Effect Unit
