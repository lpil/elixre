module Input.State exposing (EndpointUrl, Model, init)


type alias EndpointUrl =
    String


type alias Model =
    { regexEndpoint : EndpointUrl
    }


init : EndpointUrl -> Model
init url =
    { regexEndpoint = url
    }
