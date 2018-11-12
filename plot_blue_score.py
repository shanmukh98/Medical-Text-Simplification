import plotly.plotly as py
import plotly.graph_objs as go

trace1 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.443, 0.550, 0.481],
    name='wordnet-ngrams'
)

trace2 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.412, 0.544, 0.451],
    name='wordnet-splitter'
)

trace3 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.441, 0.484, 0.487],
    name='umls-ngrams'
)

trace4 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.383, 0.496, 0.425],
    name='umls-splitter'
)

trace5 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.434, 0.477, 0.473],
    name='all-ngrams'
)

trace6 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.380, 0.493, 0.421],
    name='all-splitter'
)

trace7 = go.Bar(
    x=['cmplt_trnd','mdcl_trnd','mdcl_no_fdk_trnd'],
    y=[0.440,0.565,0.703],
    name='machine-translation'
)


data = [trace1, trace2, trace3, trace4, trace5, trace6, trace7]
layout = go.Layout(
    barmode='group',
    font=dict(family='Courier New, monospace', size=24)
)

fig = go.Figure(data=data, layout=layout)
py.plot(fig, filename='grouped-bar')