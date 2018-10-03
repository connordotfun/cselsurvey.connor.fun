import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
  Browser.element 
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view 
    }


type alias Model = String

init : (Model, Cmd Msg)
init =
  ("", Cmd.none)


type Msg = Increment | Decrement

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model ++ "", Cmd.none)

    Decrement ->
      (model ++ "", Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text model ]
    , button [ onClick Increment ] [ text "+" ]
    ]