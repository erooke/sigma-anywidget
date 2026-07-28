from pathlib import Path

import anywidget
import traitlets

_STATIC_ROOT: Path = Path(__file__).parent / "static"


class SigmaWidget(anywidget.AnyWidget):
    _esm = _STATIC_ROOT / "widget.js"
    _css = _STATIC_ROOT / "widget.css"
    nodes = traitlets.Dict(dict()).tag(sync=True)
    edges = traitlets.List(list()).tag(sync=True)
    selected = traitlets.List(list()).tag(sync=True)
    node_scale = traitlets.Float(1).tag(sync=True)
    edge_scale = traitlets.Float(1).tag(sync=True)

    def clear_selection(self):
        self.send({"type": "clear_selection"})
