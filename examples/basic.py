import marimo

__generated_with = "0.23.6"
app = marimo.App(width="medium")


@app.cell
def _():
    import marimo as mo

    return (mo,)


@app.cell
def _():
    from sigma_anywidget import SigmaWidget

    return (SigmaWidget,)


@app.cell
def _():
    star = """<?xml version="1.0" encoding="UTF-8"?>
     <!DOCTYPE svg>
     <svg xmlns="http://www.w3.org/2000/svg"
          width="304" height="290">
       <path d="M2,111 h300 l-242.7,176.3 92.7,-285.3 92.7,285.3 z" 
          style="fill:#FB2;stroke:#BBB;stroke-width:15;stroke-linejoin:round"/>
    </svg>
    """
    return (star,)


@app.cell
def _(star):
    nodes = {
        "a": {
            "x": 0,
            "y": 0,
            "size": 35,
            "color": "red",
        },
        "b": {
            "x": 5,
            "y": 10,
            "size": 20,
            "color": "#coffee",
        },
        "c": {
            "x": 10,
            "y": 0,
            "size": 50,
            "svg": star,
            "color": "#00000000",
        },
    }
    return (nodes,)


@app.cell
def _():
    # (source, dest, weight)
    edges = [
        ("a", "b", 2),
        ("b", "c", 4),
    ]
    return (edges,)


@app.cell
def _(SigmaWidget, edges, mo, nodes):
    graph_widget = mo.ui.anywidget(
        SigmaWidget(
            nodes=nodes,
            edges=edges,
        )
    )
    return (graph_widget,)


@app.cell
def _(graph_widget):
    graph_widget
    return


@app.cell
def _(graph_widget, mo):
    clr_button = mo.ui.button(
        label="Clear selection",
        on_click=lambda _: graph_widget.clear_selection(),
    )
    return (clr_button,)


@app.cell
def _(clr_button, graph_widget, mo):
    _result = mo.md("No nodes are selected")

    if graph_widget.selected:
        _result = mo.md(
            f"The following nodes are selected: {', '.join(graph_widget.selected)}\n\n {clr_button}"
        )

    _result
    return


if __name__ == "__main__":
    app.run()
