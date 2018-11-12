import plotly.plotly as py
import plotly.graph_objs as go

trace1 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.843, 0.703, 0.878],
    name='wordnet-ngrams'
)

trace2 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.886, 0.717, 0.903],
    name='wordnet-splitter'
)

trace3 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.852, 0.835, 0.866],
    name='umls-ngrams'
)

trace4 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.929, 0.784, 0.919],
    name='umls-splitter'
)

trace5 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.863, 0.855, 0.888],
    name='all-ngrams'
)

trace6 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.932, 0.802, 0.923],
    name='all-splitter'
)

trace7 = go.Bar(
    x=['cmplt_trnd','mdcl_trnd','mdcl_no_fdk_trnd'],
    y=[0.839,0.668,0.615],
    name='machine-translation'
)


data = [trace1, trace2, trace3, trace4, trace5, trace6, trace7]
layout = go.Layout(
    barmode='group',
    font=dict(family='Courier New, monospace', size=24)
)

fig = go.Figure(data=data, layout=layout)
py.plot(fig, filename='grouped-bar')
