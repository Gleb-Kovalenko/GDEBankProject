import ProjectDescription
import ProjectDescriptionHelpers

let projectName = CoreTargets.GDEBankCore.name
let project = ProjectConfigurator.project(
    name: projectName,
    targets: [
        CoreTargets.GDEBankCore.target
    ]
)
