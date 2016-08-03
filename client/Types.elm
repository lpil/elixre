module Types exposing (..)

import Test.State as Test


type alias Model =
    { testModel : Test.Model }


type alias Flags =
    { regexEndpoint : Test.EndpointUrl
    }


type Msg
    = TestMsg Test.Msg
