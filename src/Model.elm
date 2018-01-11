module Model exposing (..)

import Matrix exposing (Matrix)
import Random exposing (Generator)
import Random.Array as Random
import Time exposing (Time)


fieldWidth : Int
fieldWidth =
    50


fieldHeight : Int
fieldHeight =
    50


type alias Model =
    { field : Field
    , growth : Probability
    , lightning : Probability
    , fps : Float
    }


type alias Field =
    Matrix Site


type alias Probability =
    Float


type alias Outcome =
    Matrix Probability


probability : Generator Probability
probability =
    Random.float 0 1


outcome : Generator Outcome
outcome =
    Random.array (fieldWidth * fieldHeight) probability
        |> Random.map (Matrix ( fieldWidth, fieldHeight ))


type Site
    = Empty
    | Tree
    | Fire


initModel : Model
initModel =
    { field = Matrix.repeat fieldWidth fieldHeight Empty
    , growth = 0.01
    , lightning = 0.0001
    , fps = 10
    }


type Msg
    = NewFrame Time
    | StepField Outcome
    | SetGrowth Probability
    | SetLightning Probability
    | SetFps Float
