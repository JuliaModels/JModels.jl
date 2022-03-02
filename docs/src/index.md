# RFC: JModels.jl

This document specifies an lightweight interface for statistical Julia models.
The goal is to create a generic interface for many (wildly) different packages.

One main goal of this interface is as follows.
Suppose that there is a Julia cross-validation package called CV.jl satisfying the JModels interface.
This interface should make it possible to use CV.jl on models defined by organisations such as

- [MLJ](https://alan-turing-institute.github.io/MLJ.jl/dev/)
- [SciML](https://sciml.ai/)
- [Flux](https://fluxml.ai/)
- [Turing](https://turing.ml/)
- [JuliaStats](https://juliastats.org/)
- [JuliaML](https://juliaml.github.io/)
- [Soss](https://cscherrer.github.io/Soss.jl/)
- [Invenia](https://github.com/invenia/)

and more.

## Related Work

- [LearningStrategies.jl](https://github.com/JuliaML/LearningStrategies.jl) provides an abstract interface for iteratively training a model.
    Specifically, the package allows for a model `setup!`, iteratively `update!` and a `cleanup!`.
    It has been the foundation for [IterationControl.jl](https://github.com/JuliaAI/IterationControl.jl).
- [MLJModelInterface.jl](https://github.com/JuliaAI/MLJModelInterface.jl) provides an interface for statistical models.
    In comparison, `JModels` assumes less in order to make it easier for packages to satisfy the interface.

## Model Basics

Let `Rᵏ` denote `k` random variables.
In the most basic sense, we define a statistical `model` as an object that can convert $v$ random variables to $w$ random variables.
This is often called _predicting_, so:

```julia
function predict(fmodel, data::Rᵛ)::Rʷ
    ...
end
```

where `1 ≤ v`, `1 ≤ w` and `data` satisfies the assumptions of `fmodel`.
Here, `fmodel` is often called a _fitted_ or a _trained model_.
To obtain such a model, the model has been fitted on some training data:

```julia
fmodel = fit(model, training_data)
```

where `training_data::Rᵛ`.
This is often called _training a model_.

## Data Definition

This interface makes no assumptions about the datatype.
It is up to the package who implements the interface to decide what datatypes are allowed although in most cases the [Tables.jl interface](https://juliadata.github.io/Tables.jl/stable/) is the most suitable.
Note that this isn't mandatory since the Tables interface is not generic enough for statistical models.
For example, for image classifiers, the data cannot easily be contained in a table.

## Using the Interface

As briefly mentioned in the [Model Basics](@ref), the main functions for consuming compatible models are `fit` and `predict`.
Details about this and related methods are provided below:

```@docs
JModels.fit
JModels.fit!
JModels.predict
JModels.transform
JModels.inverse_transform
JModels.verify_model
```

## Implementing the Interface

To become a `JModels.jl` source, the following methods can be implemented; some of which are optional:

```@docs
JModels.ismodel
```
