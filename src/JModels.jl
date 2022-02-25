module JModels

"""
    JModels.fit(t, x; kwargs...)

Return a fitted model of type `t` on data `x`. Implementing this function is encouraged but
optional. Without implementing this function, things such as model evaluation where your
model is `fit`ted and `apply`d multiple times are not possible.

It is advised to assign default values to all keyword arguments. This makes it easier for
people to compare different models.
"""
function fit(t, x; kwargs...)
    _verify_model(t)
    error("JModels.fit is not implemented for $typeof(m)")
end

"""
    JModels.fit!(m, x; kwargs...)

Fit an existing model `m` on data `x` by mutating `m`. See [`fit`](@ref) for more
information.
"""
function fit!(m, x; kwargs...)
    _verify_model(m)
    error("JModels.fit! is not implemented for $typeof(m)")
end

"""
    JModels.apply(m, x; kwargs...)

Apply model `m` on data `x`.

Note that this function would be called `predict` in many machine learning applications. The
word "predict" implies that the model will estimate a future event. However, it is also
common to verify a model on (historic) training data. Therefore, to avoid confusion, the name
"apply" seems more appropriate.
"""
function apply(m; kwargs...)
    _verify_model(m)
    error("JModels.apply is not implemented for $typeof(m)")
end

"""
    JModels.ismodel(x) -> Bool

Check if an object `x` has defined that it is a statistical model and has implemented the
JModels interface.
"""
function ismodel end

ismodel(x) = false

"""
    JModels.verify_model(m)

Throw an error if `!ismodel(m)`.
"""
function verify_model(m)
    if !ismodel(m)
        T = typeof(m)
        error("JModels.isdata(::$T) = true not implemented for $T which is either a bug or means that $T doesn't satisfy the JModels interface")
    end
end

end # module
