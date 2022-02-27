module JModels

"""
    JModels.fit(t, x; kwargs...)

Return a fitted model of type `t` on `data`. Implementing this function is encouraged but
optional. Without implementing this function, things such as model evaluation where your
model is `fit`ted and `apply`d multiple times are not possible.

It is advised to assign default values to all keyword arguments. This makes it easier for
people to compare different models.
"""
function fit(t, data; kwargs...)
    verify_model(t)
    error("JModels.fit is not implemented for $t")
end

"""
    JModels.fit!(model, data; kwargs...)

Fit an existing `model` on `data` by mutating `model`. In contrast to [`fit`](@ref), this
method is more flexible in configuring the model since a predefined model can be passed to
be `fit`ted. Also, this method can offer more performance if the model is trained in
multiple steps.
"""
function fit!(model, data; kwargs...)
    verify_model(model)
    error("JModels.fit! is not implemented for $typeof(model)")
end

abstract type AbstractMode end

"""
    PredictMode

The default mode in which a model operates when applied.
"""
struct PredictMode <: AbstractMode end

"""
    JModels.apply(model, data[, mode::AbstractMode=PredictMode]; kwargs...)

Apply `model` on `data` in `mode`. The extra argument `mode` is needed because some fitted
models can transform the data in more than one way.
"""
function apply(model, data, mode::AbstractMode=PredictMode; kwargs...)
    verify_model(model)
    error("JModels.apply is not implemented for $typeof(model)")
end

"""
    JModels.ismodel(x) -> Bool

Check if an object `x` has defined that it is a statistical model and has implemented the
JModels interface.
"""
function ismodel end

ismodel(x) = false

"""
    JModels.verify_model(x)

Throw an error if `!ismodel(x)`.
"""
function verify_model(m)
    if !ismodel(m)
        T = typeof(m)
        error("JModels.ismodel(::$T) = true not implemented for $T which is either a bug or means that $T doesn't satisfy the JModels interface")
    end
end

end # module
