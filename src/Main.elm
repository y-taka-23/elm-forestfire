module Main exposing (main)

import Html exposing (program)
import Model exposing (..)
import Subscriptions exposing (..)
import Update exposing (..)
import View exposing (..)


main : Program Never Model Msg
main =
    program
        { init = ( initModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
