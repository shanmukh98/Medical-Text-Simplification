import plotly.plotly as py
import plotly.graph_objs as go

trace1 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[18.760, 18.687, 18.607],
    name='wordnet-ngrams'
)

trace2 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[20.920, 18.921, 20.202],
    name='wordnet-splitter'
)

trace3 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[18.946, 17.904, 18.631],
    name='umls-ngrams'
)

trace4 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[23.25, 19.521, 22.333],
    name='umls-splitter'
)

trace5 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[18.856, 17.765, 18.654],
    name='all-ngrams'
)

trace6 = go.Bar(
    x=['metamap', 'cliner', 'ctakes'],
    y=[23.111, 19.513, 22.047],
    name='all-splitter'
)

trace7 = go.Bar(
    x=['cmplt_trnd','mdcl_trnd','mdcl_no_fdk_trnd'],
    y=[16.387,17.289,17.394],
    name='machine-translation'
)


data = [trace1, trace2, trace3, trace4, trace5, trace6, trace7]
layout = go.Layout(
    barmode='group',
    font=dict(family='Courier New, monospace', size=24)
)

fig = go.Figure(data=data, layout=layout)
py.plot(fig, filename='grouped-bar')
