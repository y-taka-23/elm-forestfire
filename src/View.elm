module View exposing (view)

import Array
import Html exposing (..)
import Html.Attributes as Html
import Html.Events as Html
import Matrix
import Model exposing (..)


view : Model -> Html Msg
view model =
    div [ Html.id "outer-pane" ]
        [ fieldPane model.field
        , controlPane model
        ]


toCell : ( ( Int, Int ), Site ) -> Html msg
toCell ( ( x, y ), site ) =
    let
        cls =
            String.join " "
                [ "cell"
                , "x-" ++ toString x
                , "y-" ++ toString y
                , String.toLower <| toString site
                ]
    in
        div [ Html.class cls ] []


fieldPane : Field -> Html msg
fieldPane field =
    div [ Html.id "field-pane" ]
        [ div [ Html.id "field" ] <| cells field ]


cells : Field -> List (Html msg)
cells field =
    Matrix.toIndexedArray field
        |> Array.map toCell
        |> Array.toList


controlPane : Model -> Html Msg
controlPane model =
    div [ Html.id "control-pane" ] <|
        growthSlider model
            ++ lightningSlider model
            ++ fpsSlider model


floatSlider : String -> Float -> Float -> Float -> Float -> (Float -> msg) -> Html msg
floatSlider id min max step value handler =
    input
        [ Html.id id
        , Html.type_ "range"
        , Html.min <| toString min
        , Html.max <| toString max
        , Html.step <| toString step
        , Html.value <| toString value
        , Html.onInput <| toFloatMsg handler
        ]
        []


toFloatMsg : (Float -> msg) -> String -> msg
toFloatMsg handler str =
    String.toFloat str
        |> Result.withDefault 0
        |> handler


growthSlider : Model -> List (Html Msg)
growthSlider model =
    [ label [ Html.for "growth" ]
        [ text <| "Growth Rate (p) : " ++ toString model.growth ]
    , floatSlider "growth" 0 0.1 0.001 model.growth SetGrowth
    ]


lightningSlider : Model -> List (Html Msg)
lightningSlider model =
    [ label [ Html.for "lightning" ]
        [ text <| "Lightning Rate (f) : " ++ toString model.lightning ]
    , floatSlider "lightning" 0 0.001 0.00001 model.lightning SetLightning
    ]


fpsSlider : Model -> List (Html Msg)
fpsSlider model =
    [ label [ Html.for "fps" ]
        [ text <| "Frame Rate (fps) : " ++ toString model.fps ]
    , floatSlider "fps" 0 30 1 model.fps SetFps
    ]
