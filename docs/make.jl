using HashCode2014Solution
using Documenter

DocMeta.setdocmeta!(HashCode2014Solution, :DocTestSetup, :(using HashCode2014Solution); recursive=true)

makedocs(;
    modules=[HashCode2014Solution],
    authors="timurUyu <timurUyu@github.com> and contributors",
    repo="https://github.com/timurUyu/HashCode2014Solution.jl/blob/{commit}{path}#{line}",
    sitename="HashCode2014Solution.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://timurUyu.github.io/HashCode2014Solution.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/timurUyu/HashCode2014Solution.jl",
    devbranch="main",
)
