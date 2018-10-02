module App exposing (..)

import Html exposing (Html, div, text)


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


type Msg
    = NoOp

view : Model -> Html Msg
view model =
    div []
        [ text model ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


main =
    { init = init
    , view = view
    , update = update
    }