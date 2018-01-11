module Subscriptions exposing (subscriptions)

import Time
import Model exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every ((1 / model.fps) * Time.second) NewFrame
