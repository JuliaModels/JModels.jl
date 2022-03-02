using Documenter
using JModels
using PlutoStaticHTML

notebooks = [
    "GLM",
    "Logo"
]

include("build.jl")

# In most cases during development, building the notebooks is not necessary.
if get(ENV, "CI", "false") == "true"
    build()
end
md_files = markdown_files()
T = [t => f for (t, f) in zip(notebooks, md_files)]

sitename = "JModels.jl"
pages = [
    "JModels" => "index.md",
    "Details" => T
]

prettyurls = get(ENV, "CI", nothing) == "true"
assets = [ "assets/favicon.ico" ]
format = Documenter.HTML(; assets, prettyurls)
modules = [JModels]
strict = true
checkdocs = :none
makedocs(; sitename, pages, format, modules, strict, checkdocs)

deploydocs(;
    devbranch="main",
    repo="github.com/JuliaModels/JModels.jl.git",
    push_preview=false
)
