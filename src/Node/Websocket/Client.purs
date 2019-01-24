module Node.Websocket.Client where

import Prelude
import Effect (Effect)

import Foreign (Foreign)
import Data.Nullable (Nullable)
import Node.HTTP as HTTP
import Node.Websocket.Types (ClientConfig, ErrorDescription, WSClient, WSConnection)

foreign import newWebsocketClient :: ClientConfig -> Effect WSClient

foreign import connect :: WSClient -> String -> Nullable (Array String) -> Nullable String -> Nullable Foreign -> Nullable Foreign -> Effect Unit

foreign import abort :: WSClient -> Effect Unit

type ConnectCallback = WSConnection -> Effect Unit

foreign import onConnect :: WSClient -> ConnectCallback -> Effect Unit

type ConnectFailedCallback = ErrorDescription -> Effect Unit

foreign import onConnectFailed :: WSClient -> ConnectFailedCallback -> Effect Unit

type HttpResponseCallback =  HTTP.Response -> WSClient -> Effect Unit

foreign import onHttpResponse :: WSClient -> HttpResponseCallback -> Effect Unit
