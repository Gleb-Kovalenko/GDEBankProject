import ProjectDescription
import ProjectDescriptionHelpers

let projectsPaths = AppTargets.allCases.map(\.projectName) + CoreTargets.allCases.map(\.name)
let workspace = Workspace(
    name: "GDEBank",
    projects: projectsPaths.map { .path($0) }
)
