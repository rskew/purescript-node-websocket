module Node.Websocket.Request where

import Prelude
import Effect (Effect)

import Data.Nullable (Nullable)
import Node.HTTP.Client (Request)
import Node.URL (URL)
import Node.Websocket.Types (WSConnection, WSRequest)

foreign import httpRequest :: WSRequest -> Request

foreign import host :: WSRequest -> String

foreign import resource :: WSRequest -> String

foreign import resourceURL :: WSRequest -> URL

foreign import remoteAddress :: WSRequest -> String

foreign import webSocketVersion :: WSRequest -> Number

foreign import origin :: WSRequest -> Nullable String

foreign import requestedProtocols :: WSRequest -> Array String

foreign import accept :: WSRequest -> Nullable String -> Nullable String -> Effect WSConnection

foreign import reject :: WSRequest -> Nullable Int -> Nullable String -> Effect Unit

type RequestAcceptedCallback e = WSConnection -> Effect Unit

foreign import onRequestAccepted :: forall e. WSRequest -> RequestAcceptedCallback e -> Effect Unit

type RequestRejectedCallback e = Effect Unit

foreign import onRequestRejected :: forall e. WSRequest -> RequestRejectedCallback e -> Effect Unit
