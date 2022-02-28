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

"""
    JModels.predict(model, data; kwargs...)

Predict with `model` on `data`. For example, a k-means clustering model can predict target
labels.
"""
function predict(model, data; kwargs...)
    verify_model(model)
    error("JModels.predict is not implemented for $typeof(model)")
end

"""
    JModels.transform(model, data; kwargs...)

Transform `data` via `model`. For example, a k-means clustering model reduce
dimensionality.
"""
function transform(model, data; kwargs...)
    verify_model(model)
    error("JModels.transform is not implemented for $typeof(model)")
end

"""
    JModels.inverse_transform(model, data; kwargs...)

Inversely transform `data` via `model`.
"""
function inverse_transform(model, data; kwargs...)
    verify_model(model)
    error("JModels.inverse_transform is not implemented for $typeof(model)")
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
