# RFC: JModels.jl

This document specifies an interface for statistical Julia packages.
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
- [Invenia](https://github.com/invenia/)

and more.

## Related work

- [LearningStrategies.jl](https://github.com/JuliaML/LearningStrategies.jl) provides an abstract interface for iteratively training a model.
    Specifically, the package allows for a model `setup!`, iteratively `update!` and a `cleanup!`.
    It has been the foundation for [IterationControl.jl](https://github.com/JuliaAI/IterationControl.jl).

## Model definition

Let $R^k$ denote $k$ random variables.
We define a statistical model $m$ with parameters $p$ as a mapping from $v$ random variables to $w$ random variables:

$$m_p(X :: R^v) :: R^w,$$

where $1 \leq v$ and $1 \leq w$ and $X$ satisfies the assumptions of $m_p$.
Here, $m_p$ is often called a _trained model_.
Let such a model be obtained by passing $u$ random variables to $m$:

$$m_p = m(T :: R^u).$$

This is often called _training a model_.

## Data definition

This interface makes no assumptions about the datatype.
It is up to the package who implements the interface to decide what datatypes are allowed.

Note that, in the case of statistical models, the [Tables.jl interface](https://juliadata.github.io/Tables.jl/stable/) is not generic enough.
For example, for image classifiers, the data cannot easily be contained in a table.

## API Reference

All the methods listed below are considered public, that is, can be used or extended.

```@docs
JModels.fit
JModels.fit!
JModels.predict
JModels.transform
JModels.inverse_transform
JModels.ismodel
JModels.verify_model
```

## Model evaluation

As an example, this section discusses how cross-validation (CV) could be applied to different Julia models via this interface.
CV for labeled data can be defined as evaluating the model $m_p$ for $k$ datasets, that is, $k$ sets of random variables $X_i :: R^v$.
Specifically, it requires the collection

$$Y = [ m_p(X_i :: R^v) \text{ for } i \text{ in } 1:k ],$$

which can then be evaluated by applying an scoring function $\text{score}$ to each outcome $Y_i \in Y$:

$$\text{aggregate}([ \text{score}(Y_i) \text{ for } Y_i \text{ in } Y ]).$$

For a collection of model types `MT` and `data`, this could be implemented via something
like (yes, an actual implementation is needed to verify correctness):

```julia
function cross_validate(mt, data)
    return map(train_test_splits(data)) do (train, test)
        model = fit(mt, train)
        predictions = apply(model, test.x)
        root_mean_squared_error(test.x, test.y)
    end
end

scores = [aggregate(cross_validate(mt, data)) for mt in MT]
```

