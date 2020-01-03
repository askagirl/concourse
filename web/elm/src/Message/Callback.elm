module Message.Callback exposing
    ( ApiEntity(..)
    , Callback(..)
    , TooltipPolicy(..)
    , Route(..)
    )

import Browser.Dom
import Concourse
import Concourse.Pagination exposing (Page, Paginated)
import Http
import Json.Encode
import Message.Message
    exposing
        ( VersionId
        , VersionToggleAction
        , VisibilityAction
        )
import Time


type alias Fetched a =
    Result Http.Error a


type Route
    = RouteJob Concourse.JobIdentifier
    | RouteJobs Concourse.PipelineIdentifier


type ApiEntity
    = Job Concourse.Job
    | Jobs (List Concourse.Job)


type Callback
    = EmptyCallback
    | ApiResponse Route (Fetched ApiEntity)
    | GotCurrentTime Time.Posix
    | GotCurrentTimeZone Time.Zone
    | BuildTriggered (Fetched Concourse.Build)
    | JobBuildsFetched (Fetched (Paginated Concourse.Build))
    | JobsFetched (Fetched Json.Encode.Value)
    | PipelineFetched (Fetched Concourse.Pipeline)
    | PipelineToggled Concourse.PipelineIdentifier (Fetched ())
    | UserFetched (Fetched Concourse.User)
    | ResourcesFetched (Fetched Json.Encode.Value)
    | BuildResourcesFetched (Fetched ( Int, Concourse.BuildResources ))
    | ResourceFetched (Fetched Concourse.Resource)
    | VersionedResourcesFetched (Fetched ( Maybe Page, Paginated Concourse.VersionedResource ))
    | ClusterInfoFetched (Fetched Concourse.ClusterInfo)
    | PausedToggled (Fetched ())
    | InputToFetched (Fetched ( VersionId, List Concourse.Build ))
    | OutputOfFetched (Fetched ( VersionId, List Concourse.Build ))
    | VersionPinned (Fetched ())
    | VersionUnpinned (Fetched ())
    | VersionToggled VersionToggleAction VersionId (Fetched ())
    | Checked (Fetched Concourse.Check)
    | CommentSet (Fetched ())
    | APIDataFetched (Fetched ( Time.Posix, Concourse.APIData ))
    | LoggedOut (Fetched ())
    | ScreenResized Browser.Dom.Viewport
    | BuildFetched (Fetched Concourse.Build)
    | BuildPrepFetched (Fetched Concourse.BuildPrep)
    | BuildHistoryFetched (Fetched (Paginated Concourse.Build))
    | PlanAndResourcesFetched Int (Fetched ( Concourse.BuildPlan, Concourse.BuildResources ))
    | BuildAborted (Fetched ())
    | VisibilityChanged VisibilityAction Concourse.PipelineIdentifier (Fetched ())
    | PipelinesFetched (Fetched (List Concourse.Pipeline))
    | GotViewport TooltipPolicy (Result Browser.Dom.Error Browser.Dom.Viewport)
    | GotElement (Result Browser.Dom.Error Browser.Dom.Element)


type TooltipPolicy
    = AlwaysShow
    | OnlyShowWhenOverflowing
