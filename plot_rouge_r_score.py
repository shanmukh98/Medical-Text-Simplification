import plotly.plotly as py
import plotly.graph_objs as go

trace1 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.697, 0.781, 0.711],
    name='wordnet-ngrams'
)

trace2 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.695, 0.780, 0.717],
    name='wordnet-splitter'
)

trace3 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.694, 0.712, 0.717],
    name='umls-ngrams'
)

trace4 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.713, 0.760, 0.729],
    name='umls-splitter'
)

trace5 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.687, 0.708, 0.707],
    name='all-ngrams'
)

trace6 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[0.711, 0.757, 0.726],
    name='all-splitter'
)

trace7 = go.Bar(
    x=['cmplt_trnd','mdcl_trnd','mdcl_no_fdk_trnd'],
    y=[0.637,0.741,0.845],
    name='machine-translation'
)


data = [trace1, trace2, trace3, trace4, trace5, trace6, trace7]
layout = go.Layout(
    barmode='group',
    font=dict(family='Courier New, monospace', size=24)
)

fig = go.Figure(data=data, layout=layout)
py.plot(fig, filename='grouped-bar')
