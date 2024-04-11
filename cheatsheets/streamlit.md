```python
# Installation
pip install streamlit

# Import Streamlit
import streamlit as st

# Text Elements
st.title('Title')
st.header('Header')
st.subheader('Subheader')
st.text('Text')
st.markdown('Markdown **formatted** text')
st.latex(r''' e^{i\pi} + 1 = 0 ''')
st.write('Write any element')

# Data Display
st.dataframe(df)
st.table(data)
st.json(json_data)
st.metric(label, value, delta=None)

# Charts and Plots
st.line_chart(data)
st.area_chart(data)
st.bar_chart(data)
st.pyplot(fig)
st.altair_chart(chart)
st.vega_lite_chart(chart_spec)
st.plotly_chart(figure_or_data)
st.bokeh_chart(figure)
st.pydeck_chart(pydeck_obj)
st.deck_gl_chart(viewport)
st.graphviz_chart(figure_or_dot)
st.map(data)

# Widgets
st.button('Button')
st.checkbox('Checkbox')
st.radio('Radio', options)
st.selectbox('Select', options)
st.multiselect('Multi Select', options)
st.slider('Slider', min_value, max_value, value)
st.select_slider('Select Slider', options)
st.text_input('Text Input')
st.number_input('Number Input')
st.text_area('Text Area')
st.date_input('Date Input')
st.time_input('Time Input')
st.file_uploader('File Uploader')
st.color_picker('Color Picker')

# Layout
st.container()
st.columns(spec)
st.expander('Expander')
st.empty()
st.sidebar
st.tabs(tabs)
with st.container():
    # Content inside the container
with st.columns(spec):
    # Content inside the columns
with st.expander('Expander'):
    # Content inside the expander

# Control Flow
if st.button('Click'):
    # Perform action
for item in items:
    # Iterate over items
selected = st.radio('Select', options)
if selected == 'Option 1':
    # Perform action for Option 1
else:
    # Perform action for other options

# Media
st.image(image, caption=None, width=None, use_column_width=None)
st.audio(data, format='audio/wav', start_time=0)
st.video(data, format='video/mp4', start_time=0)

# Displaying Code
st.code(code, language='python')
with st.echo():
    # Code block

# Progress and Status
st.progress(progress)
st.spinner('Loading...')
st.success('Success!')
st.info('Information')
st.warning('Warning')
st.error('Error')
st.exception(exception)

# Placeholders and Caching
placeholder = st.empty()
placeholder.text('Loading...')
@st.cache(allow_output_mutation=True, suppress_st_warning=True)
def expensive_computation(arg):
    # Perform expensive computation
    return result

# Themes
st.set_page_config(page_title=None, page_icon=None, layout="centered", initial_sidebar_state="auto", menu_items=None)
```

This cheatsheet covers the most commonly used functions and features of Streamlit, including:

- Installation and importing Streamlit
- Text elements for displaying text and formatted content
- Data display functions for showing dataframes, tables, and JSON data
- Charts and plots for visualizing data using various libraries
- Widgets for creating interactive elements like buttons, sliders, and inputs
- Layout functions for organizing content using containers, columns, and expanders
- Control flow statements for conditional rendering and iteration
- Media functions for displaying images, audio, and video
- Code display and echo for showing code snippets
- Progress and status indicators
- Placeholders and caching for optimizing performance
- Themes for customizing the appearance of the app

Remember to run your Streamlit app using the following command:

```
streamlit run app.py
```

Replace `app.py` with the name of your Python file containing the Streamlit code.

Refer to the official Streamlit documentation (https://docs.streamlit.io/) for more detailed information on each function and feature, as well as additional examples and use cases.