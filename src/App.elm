import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style, id)
import Html.Events exposing (onClick)


main =
  Browser.element 
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view 
    }


type alias Model = String

init : () -> (Model, Cmd Msg)
init _=
  (" ", Cmd.none)


type Msg = NewSentance

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NewSentance -> 
      ("This is an example sentance", Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

view : Model -> Html Msg
view model =
  div [id "container"]
    [ div [id "content"] 
      [
        div [id "header"] [ text "What do students think about CSEL?" ]
        , text model
      ]
    , button [id "button", onClick NewSentance ] [ text "Find Out!" ]
    ]