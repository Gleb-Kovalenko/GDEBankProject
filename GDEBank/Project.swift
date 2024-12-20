import ProjectDescription
import ProjectDescriptionHelpers

let projectName = AppTargets.GDEBank.projectName
let project = ProjectConfigurator.project(
    name: projectName,
    targets: [
        AppTargets.GDEBank.target
    ]
)
