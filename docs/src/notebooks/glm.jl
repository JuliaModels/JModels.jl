### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ 79eb61d4-9635-11ec-19d4-7b61646ffe23
# hideall
begin
    using Pkg
    Pkg.activate(; temp=true)
    Pkg.add([
        "GLM"
    ])
    Pkg.develop(; path=dirname(dirname(dirname(@__DIR__))))
end

# ╔═╡ f2855237-a2dd-4c11-ad8e-2fa58a0eae9d
# hideall
try using Revise catch end

# ╔═╡ 84652bbd-f82a-4af3-ab1d-89b9a79da966
using GLM

# ╔═╡ 04507b23-fb11-43bb-aea0-02f9eddd75c5
using GLM: AbstractGLM

# ╔═╡ 4d83954a-0d01-46d2-9a80-09212bbd8c33
md"""
# GLM

This page demonstrates an example implementation of the `JModels.jl` interface for `GLM.jl` and applies `GLM.jl` via the interface.
"""

# ╔═╡ 75c323c8-9ff5-48e6-923b-0eb02f7ef9df
md"""
## Implementation of JModels

This is an example implementation which could live inside `GLM.jl`.
"""

# ╔═╡ 1e6c881f-ae0a-4393-ac42-cd212428f20b
import JModels

# ╔═╡ 78d45aff-63ff-468d-8ca5-b70669dce442
JModels.ismodel(AbstractGLM) = true

# ╔═╡ a3dff183-54ae-4215-9f0c-0456bbe9f30b
function JModels.fit(
        mt::Type{GeneralizedLinearModel},
        data;
        settings = (;
			formula=FormulaTerm(term(:y), term(:x)),
        	family=Binomial(),
	        link=LogitLink()
		)
    )
    return glm(settings.formula, data, settings.family, settings.link)
end

# ╔═╡ 369f5d90-f796-44c7-9e6c-f7396078053a
function JModels.predict(
        model::Union{AbstractGLM,LinearModel,RegressionModel},
        data;
        settings=NamedTuple()
    )
    return GLM.predict(model, data; settings...)
end

# ╔═╡ 2868f696-a892-47e9-b6c9-9bdf53aeed39
md"""
## Example usage
"""

# ╔═╡ 318832b4-a04c-4709-9783-442da4f4fc9f
data = (; x = 1:3, y = rand(3));

# ╔═╡ 1e2e759f-8a1f-43a4-98c7-81dee72f5160
model = JModels.fit(GeneralizedLinearModel, data)

# ╔═╡ 14ae9587-e62b-479b-a32b-5686272df916
JModels.predict(model, data)

# ╔═╡ Cell order:
# ╠═4d83954a-0d01-46d2-9a80-09212bbd8c33
# ╠═79eb61d4-9635-11ec-19d4-7b61646ffe23
# ╠═f2855237-a2dd-4c11-ad8e-2fa58a0eae9d
# ╠═84652bbd-f82a-4af3-ab1d-89b9a79da966
# ╠═04507b23-fb11-43bb-aea0-02f9eddd75c5
# ╠═75c323c8-9ff5-48e6-923b-0eb02f7ef9df
# ╠═1e6c881f-ae0a-4393-ac42-cd212428f20b
# ╠═78d45aff-63ff-468d-8ca5-b70669dce442
# ╠═a3dff183-54ae-4215-9f0c-0456bbe9f30b
# ╠═369f5d90-f796-44c7-9e6c-f7396078053a
# ╠═2868f696-a892-47e9-b6c9-9bdf53aeed39
# ╠═318832b4-a04c-4709-9783-442da4f4fc9f
# ╠═1e2e759f-8a1f-43a4-98c7-81dee72f5160
# ╠═14ae9587-e62b-479b-a32b-5686272df916
