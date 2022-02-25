using Documenter
using JModels

sitename = "JModels.jl"
pages = [
    "JModels" => "index.md"
]

prettyurls = get(ENV, "CI", nothing) == "true"
format = Documenter.HTML(; prettyurls)
modules = [JModels]
strict = true
checkdocs = :none
makedocs(; sitename, pages, format, modules, strict, checkdocs)
