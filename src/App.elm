import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style, id)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Url.Builder as Url
import Debug


main =
  Browser.element 
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view 
    }


type alias Model = List String


init : () -> (Model, Cmd Msg)
init _=
  ([""], Cmd.none)


type Msg
  = GetNewSentence
  | NewSentencesGenerated (Result Http.Error (List String))


getNewSentences : Cmd Msg
getNewSentences =
  Http.send NewSentencesGenerated (Http.get getGeneratorUrl decodeSentences)


getGeneratorUrl: String
getGeneratorUrl = 
  Url.crossOrigin "https://d48oi7sm4b.execute-api.us-east-1.amazonaws.com" ["default", "csel-survey-generator"] []

decodeSentences : Decode.Decoder (List String)
decodeSentences = 
  Decode.at ["data"] (Decode.list Decode.string)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetNewSentence -> 
      getNextSentence model
    NewSentencesGenerated newData ->
      (handleModelUpdate newData, Cmd.none)


getNextSentence : Model -> (Model, Cmd Msg)
getNextSentence model =
  case model of
    _::[] -> (["..."], getNewSentences)
    _::tail -> (tail, Cmd.none)
    [] -> (["..."], getNewSentences)
    


handleModelUpdate: Result Http.Error (List String) -> List String
handleModelUpdate result =
  case result of
    Ok data -> data
    Err error -> 
      case error of
        Http.BadPayload s (_) ->
          ["JSON PARSE ERROR OCCURED: " ++ s]
        _ ->
          ["HTTP ERROR OCCURED"]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

test = 
  "[\"It\\u2019s always extremely loud to the point that I am going to spend hours per week in a small corner, and it's always so crowded and sometimes its difficult to find their TAs, which discourages them from coming to office hours.\", \"While it still exists, the room Windows would be willing to help out everyone is awesome.\", \"Csel is an awesome resource, but it isn't used very well.\", \"Replace all the furniture takes up most of my peers in CS meet in the idea forge because it was a far more open and positive place to study there a lot of potential but I feel my hands cramp up with arthritis.\"]"

view : Model -> Html Msg
view model =
  div [id "container"]
    [ div [id "content"] 
      [
        div [id "header"] [ text "What do students think about CSEL?" ]
        , text (getSentenceToRender model)
      ]
    , button [id "button", onClick GetNewSentence ] [ text "Find Out!" ]
    ]
  
getSentenceToRender : Model -> String
getSentenceToRender model = 
  case List.head model of 
    Just s -> s
    Nothing -> ""