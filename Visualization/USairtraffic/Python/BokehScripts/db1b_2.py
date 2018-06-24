import pandas as pd
import numpy as np
from bokeh.io import output_notebook, curdoc
from bokeh.models import (
    ColumnDataSource,
    HoverTool,
    LinearColorMapper,
    BasicTicker,
    PrintfTickFormatter,
    ColorBar,
    FactorRange,
    Div
)
from bokeh.plotting import figure, show, output_file
from bokeh.palettes import BuPu
import matplotlib.cm as cm
import matplotlib as mpl
from bokeh.layouts import gridplot, layout, widgetbox, column, row, widgetbox
from bokeh.models.widgets import Select, Slider, DataTable, TableColumn, Dropdown, CheckboxGroup, Tabs
from os.path import dirname, join
## Read filtered data for all quarters ##

db1b_q1 = pd.read_csv('db1b_q1.csv')
db1b_q2 = pd.read_csv('db1b_q2.csv')
db1b_q3 = pd.read_csv('db1b_q3.csv')
db1b_q4 = pd.read_csv('db1b_q4.csv')


def calculate_columns(*args):
    """
    Receives a number of dataframe for different quarter.
    Returns a combined dataframe with  actual number of passengers.
    """
    list_df = list(args)
    final_df = pd.DataFrame()
    for i in range(0, len(list_df)):
        list_df[i]["ACTUAL_PASSENGERS"] = list_df[i]["PASSENGERS"]*10
        # list_df[i]["QUARTER_Actual"]=i+1
        final_df = final_df.append(list_df[i])
    return final_df


quarter_all = calculate_columns(db1b_q1, db1b_q2, db1b_q3, db1b_q4)

print("quarter_all head", quarter_all.head())

## Traffic between two airports for the entire year of 2017 ##

traffic_2017 = quarter_all.groupby(["ORIGIN", "DEST"]).agg(
    {'PASSENGERS': sum}).reset_index()


# Create Input Controls

percentile = Slider(title=" In terms of US overall traffic markets with traffic flow greater than the following percentile",
                    start=0.5, end=0.95, value=0.5, step=0.05)


# Create ColumnDataSouce

source = ColumnDataSource(data=dict(ORIGIN=[],
                                    DEST=[],
                                    PASSENGERS=[]
                                    ))

hover = HoverTool(tooltips=[
    ("ORIGIN", "@ORIGIN"),
    ("DEST", "@DEST"),
    ("PASSENGERS", "@PASSENGERS")
])

passenger_min = traffic_2017.PASSENGERS.min()
passenger_max = traffic_2017.PASSENGERS.max()

colormap = cm.get_cmap("BuPu")
bokehpalette = [mpl.colors.rgb2hex(m)
                for m in colormap(np.arange(colormap.N))]

color_mapper=LinearColorMapper(
        palette=bokehpalette,low=passenger_min,high=passenger_max)
origin = []
dest = []

z = figure(title="US traffic density between airports", x_range=origin, y_range=dest, toolbar_location='right',
           toolbar_sticky=False, tools=[hover, 'pan', 'wheel_zoom', 'box_zoom', 'reset'], plot_width=1145, plot_height=1100)
z.rect(x='ORIGIN', y='DEST', width=1, height=1, source=source, fill_color={
    'field': 'PASSENGERS', 'transform': color_mapper}, line_color=None)


color_bar = ColorBar(color_mapper=color_mapper, major_label_text_font_size="7pt",
        ticker=BasicTicker(desired_num_ticks=8), label_standoff=6, border_line_color=None, location=(0, 0))
z.add_layout(color_bar, 'right')

quarter_map = {
    "First Quarter": 1,
    "Second Quarter": 2,
    "Third Quarter": 3,
    "Fourth Quarter": 4,
    "OverallYear": "OverallYear"
}
quarter = Select(title="Time Period", options=list(quarter_map.keys()))


def select_df():
    percentile_val = percentile.value
    quarter_val = quarter_map[quarter.value]
    print("percentile_val:", percentile_val)
    print("quarter_val:", quarter_val)
    if quarter.value == "OverallYear":
        selected_df = traffic_2017.loc[traffic_2017['PASSENGERS']
                                       >= traffic_2017.PASSENGERS.quantile(percentile_val)]
        print("Selected DF Overall Year:", selected_df.head())
    else:
        selected_df = quarter_all.loc[(quarter_all["QUARTER"] == quarter_val) & (quarter_all["PASSENGERS"]
                                                                                 >= quarter_all.PASSENGERS.quantile(percentile_val))]
    print("Selected DF Quarter:", selected_df.head())
    return selected_df


def update(attr, old, new):
    df = select_df()
    print(df.head())
    print(df.shape)
    passenger_min = df.PASSENGERS.min()
    passenger_max = df.PASSENGERS.max()
    origin = list(df.ORIGIN.unique())
    dest = list(df.DEST.unique())
    source.data = dict(
        ORIGIN=df["ORIGIN"],
        DEST=df["DEST"],
        PASSENGERS=df["PASSENGERS"]
    )
    z.x_range.factors = origin
    z.y_range.factors = dest
    color_mapper.low = passenger_min
    color_mapper.high = passenger_max
    


percentile.on_change('value', update)
quarter.on_change('value', update)



quarter_widget = widgetbox(quarter, width=200)
percentile_widget = widgetbox(percentile, width=200)
desc = Div(text=open(join(dirname(__file__), "descriptionheatmap.html")).read(), width=1000)
desc2= Div(text=open(join(dirname(__file__), "twitter.html")).read(), width=1000)
layout = column(desc,row(column(percentile_widget, quarter_widget), z),desc2)


z.xaxis.axis_label = 'Origin'
z.yaxis.axis_label = 'Destination'
z.xaxis.major_label_orientation = 1.6


curdoc().add_root(layout)

