import plotly.plotly as py
import plotly.graph_objs as go

trace1 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.677, 0.726, 0.707],
    name='wordnet-ngrams'
)

trace2 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.599, 0.714, 0.632],
    name='wordnet-splitter'
)

trace3 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.672, 0.675, 0.712],
    name='umls-ngrams'
)

trace4 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.558, 0.670, 0.593],
    name='umls-splitter'
)

trace5 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.667, 0.671, 0.703],
    name='all-ngrams'
)

trace6 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.557, 0.668, 0.591],
    name='all-splitter'
)

trace7 = go.Bar(
    x=['cmplt_trnd','mdcl_trnd','mdcl_no_fdk_trnd'],
    y=[0.742,0.773,0.916],
    name='machine-translation'
)


data = [trace1, trace2, trace3, trace4, trace5, trace6, trace7]
layout = go.Layout(
    barmode='group',
    font=dict(family='Courier New, monospace', size=24)
)

fig = go.Figure(data=data, layout=layout)
py.plot(fig, filename='grouped-bar')
