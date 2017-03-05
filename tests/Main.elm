port module Main exposing (..)

import Test
import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import SubjectResultTests


main : TestProgram
main =
    [ SubjectResultTests.all ]
        |> Test.describe "all tests"
        |> run emit


port emit : ( String, Value ) -> Cmd msg
