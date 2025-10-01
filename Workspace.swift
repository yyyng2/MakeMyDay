import ProjectDescription

let workspace = Workspace(
    name: "MakeMyDay",
    projects: [
        "App",
        "Core",
        "Features/**",
        "Shared/**",
        "Services"
    ],
)

