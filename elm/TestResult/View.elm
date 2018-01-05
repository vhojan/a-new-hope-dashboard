module TestResult.View exposing (view)

import AppStyles exposing (..)
import TestResult.Model exposing (..)

import Element
import Element.Attributes exposing (px, padding, spacing, alignRight, width, height)
import Element.Events exposing (onMouseEnter, onMouseLeave)



-- VIEW

view : Config msg -> Model -> Element.Element AppStyles.DashboardStyles variation msg
view config model =
    let
        testResultStyle = if model.result.result then Success else Failure
    in
        Element.column (TestResultStyle testResultStyle)
            [ onMouseEnter config.toggleMsg
            , onMouseLeave config.toggleMsg
            , width (px 400)
            , height (px 300)
            , padding 20
            , spacing 20
            ]
            [ testResultTitle model.showDetails model.result.name
            , testSubResults model.showDetails model.result.result model.result.results
            ]

testResultTitle showDetails title =
    let
        detailsStatusStyle = if showDetails then DetailsShown else DetailsHidden
    in
        Element.el (TestResultTitleStyle detailsStatusStyle)
            []
            (Element.text title)

testSubResults showDetails overallResult subResults =
    Element.when
        showDetails
        ( Element.column TestResultListStyle
            [ spacing 2 ]
            (subResults
                |> List.map (\r ->
                    testSubResult overallResult r)) )

testSubResult overallResult subResult =
    let
        testResultItemStyle =
            if overallResult then Good
            else if subResult.result then OK
            else Bad
    in
        Element.el (TestResultItemStyle testResultItemStyle)
            []
            (Element.text subResult.name)