module Results.View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)


root : Html a
root =
    div [ class "results" ]
        [ pre [] [ text "Hello, world!" ]
        ]



-- <div ng-controller="resultsController" class="results">
--   <pre><div class="results__error"
--             ng-if="return.error"
--             ng-bind="'Compilation Error! \n' + (return.error | json)"></div
--             ><div class="results__regex"
--             ng-if="return.regex"
--             ng-bind="'# ' + return.regex + '\n\n'"></div
--             ><div class="results__result"
--             ng-repeat="case in return.results"
--             ><result data="case"></div></pre>
-- </div>
