### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# ╔═╡ 0d7e9e2a-9a1e-11ec-3f58-5938aac102fc
begin
    using Pkg
    Pkg.activate(; temp=true)
	packages = [
		PackageSpec(; name="CairoMakie", version="0.7")
		PackageSpec(; name="ColorTypes", version="0.11")
	]
    Pkg.add(packages)
	Pkg.develop(; path=dirname(dirname(dirname(@__DIR__))))
end

# ╔═╡ 59e351d0-8df4-4016-898e-3c4c6f554d17
using CairoMakie, ColorTypes, JModels

# ╔═╡ a88ccce3-34d3-483f-b313-595bab69ac07
md"""
This notebook generates the JModels logo and favicon.
Credits go to Makie.jl for making it easy to create a nice PNG with a transparent background.
"""

# ╔═╡ 91ae0221-d73e-44c5-a672-d7e360937e2e
julia_color = Dict(
	"blue" => RGB(77/255, 101/255, 175/255),
	"red" => RGB(201/255, 60/255, 50/255),
	"green" => RGB(59/255, 150/255, 71/255),
	"purple" => RGB(145/255, 89/255, 162/255)
)

# ╔═╡ 79c539d4-8788-43e0-bdd9-1065159a5a1d
size = 480;

# ╔═╡ 0990b969-b28d-45d2-89b1-2a1a8eb57ac4
logo = let
	fig = Figure(; resolution=(size, size), backgroundcolor=:transparent)
	ax = Axis(fig[1, 1]; backgroundcolor=:transparent)

	cluster(x::Int, y::Int) = Point2f.([x - 1, x, x + 1], [y, y + 2, y]) 

	markersize = 50
	
	scatter!(ax, cluster(2, 2); color=julia_color["red"], markersize)
	scatter!(ax, cluster(5, 4); color=julia_color["green"], markersize)
	scatter!(ax, cluster(8, 6); color=julia_color["purple"], markersize)

	limits!(ax, 0, 10, 1, 9)

	lines!(ax, [0.2, 9.8], [1.2, 8.8]; color=julia_color["blue"], linewidth=8)

	hidespines!(ax)
	hidedecorations!(ax)
	
	fig
end

# ╔═╡ 97d8d81c-0cf1-4102-ab83-0becfad30453
favicon_path = joinpath(pkgdir(JModels), "docs", "src", "assets", "favicon.png");

# ╔═╡ 3c461c35-d8d4-4dce-8b1b-276a64152b02
# Favicons are usually around 48x48.
let
	save(favicon_path, logo, px_per_unit=48/size)
	cd(dirname(favicon_path)) do
		# Documenter.jl wants an ico file.
		cp("favicon.png", "favicon.ico"; force=true)
	end
end;

# ╔═╡ d0c67ad2-ef24-4405-b01a-b3f11e623383
logo_path = let
	path = joinpath(pkgdir(JModels), "docs", "src", "assets", "logo.png")
	mkpath(dirname(path))
	path
end

# ╔═╡ cd996076-d3c9-47e3-874a-fc70fa38ad86
save(logo_path, logo; px_per_unit=240/size);

# ╔═╡ Cell order:
# ╠═a88ccce3-34d3-483f-b313-595bab69ac07
# ╠═0d7e9e2a-9a1e-11ec-3f58-5938aac102fc
# ╠═59e351d0-8df4-4016-898e-3c4c6f554d17
# ╠═91ae0221-d73e-44c5-a672-d7e360937e2e
# ╠═79c539d4-8788-43e0-bdd9-1065159a5a1d
# ╠═0990b969-b28d-45d2-89b1-2a1a8eb57ac4
# ╠═97d8d81c-0cf1-4102-ab83-0becfad30453
# ╠═3c461c35-d8d4-4dce-8b1b-276a64152b02
# ╠═d0c67ad2-ef24-4405-b01a-b3f11e623383
# ╠═cd996076-d3c9-47e3-874a-fc70fa38ad86
