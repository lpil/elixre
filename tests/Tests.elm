module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, tuple, string)
import String
import SubjectResultTests


all : Test
all =
    describe "all tests"
        [ SubjectResultTests.all ]
