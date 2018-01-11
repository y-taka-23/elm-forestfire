module Update exposing (update)

import Random
import Matrix exposing (Matrix)
import Matrix.Extra as Matrix
import Model exposing (..)


transit : Outcome -> Model -> Int -> Int -> Site -> Site
transit out model x y site =
    case site of
        Tree ->
            if Matrix.neighboursFour x y model.field |> List.member Fire then
                Fire
            else
                case Matrix.get x y out of
                    Nothing ->
                        Tree

                    Just prob ->
                        if prob < model.lightning then
                            Fire
                        else
                            Tree

        Fire ->
            Empty

        Empty ->
            case Matrix.get x y out of
                Nothing ->
                    Empty

                Just prob ->
                    if prob < model.growth then
                        Tree
                    else
                        Empty


step : Outcome -> Model -> Field
step out model =
    Matrix.indexedMap (transit out model) model.field


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewFrame _ ->
            ( model, Random.generate StepField outcome )

        StepField out ->
            ( { model | field = step out model }, Cmd.none )

        SetGrowth prob ->
            ( { model | growth = prob }, Cmd.none )

        SetLightning prob ->
            ( { model | lightning = prob }, Cmd.none )

        SetFps fps ->
            ( { model | fps = fps }, Cmd.none )
