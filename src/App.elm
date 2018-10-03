import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style, id)
import Html.Events exposing (onClick)
import Http


main =
  Browser.element 
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view 
    }


type alias Model = 
  { currentSentence: String
  , allSentences: List String
  , nextIndex: Int
  }

type alias Sentences = 
  { 
    results: List String
  }

init : () -> (Model, Cmd Msg)
init _=
  (" ", Cmd.none)


type Msg
  = GetNewSentence
  | NewSentencesGenerated (Result Http.Error Sentences)




shouldRequestNewSentences : Model -> Bool
shouldRequestNewSentences model = (model.nextIndex == List.length model.allSentences)


getNewSentences : () -> Cmd Msg
getNewSentences =
  Http.get "https://d48oi7sm4b.execute-api.us-east-1.amazonaws.com/default/csel-survey-generator"


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetNewSentence -> 
      if shouldRequestNewSentences model then
        (model, )
    NewSentencesGenerated newData ->
      (model, Cmd.none)



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
    , button [id "button", onClick GetNewSentence ] [ text "Find Out!" ]
    ]