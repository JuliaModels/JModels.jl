var documenterSearchIndex = {"docs":
[{"location":"#RFC:-JModels.jl","page":"JModels","title":"RFC: JModels.jl","text":"","category":"section"},{"location":"","page":"JModels","title":"JModels","text":"This document specifies an interface for statistical Julia packages. The goal is to create a generic interface for many (wildly) different packages.","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"One main goal of this interface is as follows. Suppose that there is a Julia cross-validation package called CV.jl satisfying the JModels interface. This interface should make it possible to use CV.jl on models defined by organisations such as","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"MLJ\nSciML\nFlux\nTuring\nJuliaStats\nJuliaML\nInvenia","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"and more.","category":"page"},{"location":"#Related-work","page":"JModels","title":"Related work","text":"","category":"section"},{"location":"","page":"JModels","title":"JModels","text":"LearningStrategies.jl provides an abstract interface for iteratively training a model.   Specifically, the package allows for a model setup!, iteratively update! and a cleanup!.   It has been the foundation for IterationControl.jl.","category":"page"},{"location":"#Model-definition","page":"JModels","title":"Model definition","text":"","category":"section"},{"location":"","page":"JModels","title":"JModels","text":"Let R^k denote k random variables. We define a statistical model m with parameters p as a mapping from v random variables to w random variables:","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"m_p(X  R^v)  R^w","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"where 1 leq v and 1 leq w and X satisfies the assumptions of m_p. Here, m_p is often called a trained model. Let such a model be obtained by passing u random variables to m:","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"m_p = m(T  R^u)","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"This is often called training a model.","category":"page"},{"location":"#Data-definition","page":"JModels","title":"Data definition","text":"","category":"section"},{"location":"","page":"JModels","title":"JModels","text":"This interface makes no assumptions about the datatype. It is up to the package who implements the interface to decide what datatypes are allowed.","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"Note that, in the case of statistical models, the Tables.jl interface is not generic enough. For example, for image classifiers, the data cannot easily be contained in a table.","category":"page"},{"location":"#API-Reference","page":"JModels","title":"API Reference","text":"","category":"section"},{"location":"","page":"JModels","title":"JModels","text":"All the methods listed below are considered public, that is, can be used or extended.","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"JModels.fit\nJModels.fit!\nJModels.apply\nJModels.ismodel\nJModels.verify_model","category":"page"},{"location":"#JModels.fit","page":"JModels","title":"JModels.fit","text":"JModels.fit(t, x; kwargs...)\n\nReturn a fitted model of type t on data. Implementing this function is encouraged but optional. Without implementing this function, things such as model evaluation where your model is fitted and applyd multiple times are not possible.\n\nIt is advised to assign default values to all keyword arguments. This makes it easier for people to compare different models.\n\n\n\n\n\n","category":"function"},{"location":"#JModels.fit!","page":"JModels","title":"JModels.fit!","text":"JModels.fit!(model, data; kwargs...)\n\nFit an existing model on data by mutating model. In contrast to fit, this method is more flexible in configuring the model since a predefined model can be passed to be fitted. Also, this method can offer more performance if the model is trained in multiple steps.\n\n\n\n\n\n","category":"function"},{"location":"#JModels.apply","page":"JModels","title":"JModels.apply","text":"JModels.apply(model, data[, mode::AbstractMode=PredictMode]; kwargs...)\n\nApply model on data in mode. The extra argument mode is needed because some fitted models can transform the data in more than one way.\n\n\n\n\n\n","category":"function"},{"location":"#JModels.ismodel","page":"JModels","title":"JModels.ismodel","text":"JModels.ismodel(x) -> Bool\n\nCheck if an object x has defined that it is a statistical model and has implemented the JModels interface.\n\n\n\n\n\n","category":"function"},{"location":"#JModels.verify_model","page":"JModels","title":"JModels.verify_model","text":"JModels.verify_model(x)\n\nThrow an error if !ismodel(x).\n\n\n\n\n\n","category":"function"},{"location":"#Model-evaluation","page":"JModels","title":"Model evaluation","text":"","category":"section"},{"location":"","page":"JModels","title":"JModels","text":"As an example, this section discusses how cross-validation (CV) could be applied to different Julia models via this interface. CV for labeled data can be defined as evaluating the model m_p for k datasets, that is, k sets of random variables X_i  R^v. Specifically, it requires the collection","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"Y =  m_p(X_i  R^v) text for  i text in  1k ","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"which can then be evaluated by applying an scoring function textscore to each outcome Y_i in Y:","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"textaggregate( textscore(Y_i) text for  Y_i text in  Y )","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"For a collection of model types MT and data, this could be implemented via something like (yes, an actual implementation is needed to verify correctness):","category":"page"},{"location":"","page":"JModels","title":"JModels","text":"function cross_validate(mt, data)\n    return map(train_test_splits(data)) do (train, test)\n        model = fit(mt, train)\n        predictions = apply(model, test.x)\n        root_mean_squared_error(test.x, test.y)\n    end\nend\n\nscores = [aggregate(cross_validate(mt, data)) for mt in MT]","category":"page"},{"location":"notebooks/glm/","page":"GLM","title":"GLM","text":"<style>\n    table {\n        display: table !important;\n        margin: 2rem auto !important;\n        border-top: 2pt solid rgba(0,0,0,0.2);\n        border-bottom: 2pt solid rgba(0,0,0,0.2);\n    }\n\n    pre, div {\n        margin-top: 1.4rem !important;\n        margin-bottom: 1.4rem !important;\n    }\n</style>\n\n<!-- PlutoStaticHTML.Begin -->\n<!--\n    # This information is used for caching.\n    [PlutoStaticHTML.State]\n    input_sha = \"089954474e0612e86e116060dafa00d4ec8accfda5a8848633370c7199a78422\"\n    julia_version = \"1.7.2\"\n-->\n\n<div class=\"markdown\"><h1>GLM</h1>\n<p>This page demonstrates an example implementation of the <code>JModels.jl</code> interface for <code>GLM.jl</code> and applies <code>GLM.jl</code> via the interface.</p>\n</div>\n\n\n\n\n\n\n\n<pre class='language-julia'><code class='language-julia'>using GLM</code></pre>\n\n\n<pre class='language-julia'><code class='language-julia'>using GLM: AbstractGLM</code></pre>\n\n\n\n<div class=\"markdown\"><h2>Implementation of JModels</h2>\n<p>This is an example implementation which could live inside <code>GLM.jl</code>.</p>\n</div>\n\n<pre class='language-julia'><code class='language-julia'>import JModels</code></pre>\n\n\n<pre class='language-julia'><code class='language-julia'>JModels.ismodel(AbstractGLM) = true</code></pre>\n\n\n<pre class='language-julia'><code class='language-julia'>function JModels.fit(\n        mt::Type{GeneralizedLinearModel},\n        data;\n        formula=FormulaTerm(term(:y), term(:x)),\n        family=Binomial(),\n        link=LogitLink()\n\t)\n    return glm(formula, data, family, link)\nend</code></pre>\n\n\n<pre class='language-julia'><code class='language-julia'>function JModels.apply(\n        model::Union{AbstractGLM,LinearModel,RegressionModel},\n        data;\n        kwargs...\n    )\n    return predict(model, data; kwargs...)\nend</code></pre>\n\n\n\n<div class=\"markdown\"><h2>Example usage</h2>\n</div>\n\n<pre class='language-julia'><code class='language-julia'>data = (; x = 1:3, y = rand(3));</code></pre>\n\n\n<pre class='language-julia'><code class='language-julia'>model = JModels.fit(GeneralizedLinearModel, data)</code></pre>\n<pre id='var-model' class='pre-class'><code class='code-output'>StatsModels.TableRegressionModel{GeneralizedLinearModel{GLM.GlmResp{Vector{Float64}, Binomial{Float64}, LogitLink}, GLM.DensePredChol{Float64, LinearAlgebra.Cholesky{Float64, Matrix{Float64}}}}, Matrix{Float64}}\n\ny ~ 1 + x\n\nCoefficients:\n─────────────────────────────────────────────────────────────────────────\n                 Coef.  Std. Error      z  Pr(>|z|)  Lower 95%  Upper 95%\n─────────────────────────────────────────────────────────────────────────\n(Intercept)  -1.43931      3.27049  -0.44    0.6599   -7.84935    4.97073\nx             0.921507     1.59599   0.58    0.5637   -2.20657    4.04959\n─────────────────────────────────────────────────────────────────────────</code></pre>\n\n<pre class='language-julia'><code class='language-julia'>GeneralizedLinearModel &lt;: AbstractGLM</code></pre>\n<pre id='var-hash639038' class='pre-class'><code class='code-output'>true</code></pre>\n\n<pre class='language-julia'><code class='language-julia'>Type{GeneralizedLinearModel} &lt;: Type{&lt;:AbstractGLM}</code></pre>\n<pre id='var-hash666904' class='pre-class'><code class='code-output'>true</code></pre>\n\n<pre class='language-julia'><code class='language-julia'>JModels.apply(model, data)</code></pre>\n<pre id='var-hash752650' class='pre-class'><code class='code-output'>3-element Vector{Union{Missing, Float64}}:\n 0.3733666083276657\n 0.5995778347494777\n 0.7900478153152545</code></pre>\n\n<!-- PlutoStaticHTML.End -->","category":"page"}]
}
