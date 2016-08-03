module Types exposing (..)

import Input.State as Input


type alias Model =
    { inputModel : Input.Model }


type alias Flags =
    { regexEndpoint : Input.EndpointUrl
    }


type Msg
    = InputMsg Input.Msg
