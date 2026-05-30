import type { RenderProps, InitializeProps } from "@anywidget/types";
import "./widget.css";

import Graph from "graphology";
import Sigma from "sigma";
import { NodePointProgram } from "sigma/rendering";
import { EdgeDisplayData, NodeDisplayData } from "sigma/types";
import { NodeImageProgram } from "@sigma/node-image";

interface WidgetModel {
  nodes: object;
  edges: Array<[string, string, number]>;
  selected: Array<string>;
}

function svgToDataURI(svg: string): string {
  const blob = new Blob([svg], { type: "image/svg+xml" });
  return URL.createObjectURL(blob);
}

export default async () => {
  var graph = new Graph();
  return {
    initialize({ model }: InitializeProps<WidgetModel>) {
      for (const [key, value] of Object.entries(model.get("nodes"))) {
        const svg_string = value["svg"];

        if (svg_string !== undefined) {
          value["image"] = svgToDataURI(svg_string);
          value["type"] = "image";
        }

        graph.addNode(key, value);
      }

      for (const edge of model.get("edges")) {
        graph.addEdge(edge[0], edge[1], { size: edge[2] });
      }
    },

    render({ model, el }: RenderProps<WidgetModel>) {
      // Set up the container for sigma js
      let container = document.createElement("div");
      container.style.height = "600px";
      container.style.width = "100%";
      el.classList.add("graph_widget");
      el.appendChild(container);

      // Create the renderer
      const renderer = new Sigma(graph, container, {
        itemSizesReference: "screen",
        defaultNodeType: "point",
        nodeProgramClasses: {
          point: NodePointProgram,
          image: NodeImageProgram,
        },
      });

      function toggle_node_selection({ node }) {
        var nodes = [...model.get("selected")];
        const ind = nodes.indexOf(node);
        if (ind == -1) {
          nodes.push(node);
        } else {
          nodes.splice(ind, 1);
        }
        model.set("selected", nodes);
        model.save_changes();
        // TODO: this is technically slow, we can tell sigma what we didn't change
        renderer.refresh();
      }

      renderer.on("clickNode", toggle_node_selection);

      function clear_selection() {
        model.set("selected", []);
        model.save_changes();
        // TODO: this is technically slow, we can tell sigma what we didn't change
        renderer.refresh();
      }

      model.on("msg:custom", (msg) => {
        if (msg?.type === "clear_selection") {
          return clear_selection();
        }
      });

      renderer.setSetting("nodeReducer", (node, data) => {
        const res: Partial<NodeDisplayData> = { ...data };

        const selected = model.get("selected");
        if (selected.length == 0) {
          // Nothing is selected yet, there is nothing to do drawing wise
          return res;
        }
        const ind = selected.indexOf(node);
        if (ind == -1) {
          res.color = "#f6f6f6";
          res.type = "point";
        }
        return res;
      });

      renderer.setSetting("edgeReducer", (edge, data) => {
        const res: Partial<EdgeDisplayData> = { ...data };

        const selected = model.get("selected");
        if (selected.length == 0) {
          return res;
        }
        const ext = graph.extremities(edge);
        for (const node of selected) {
          if (node == ext[0] || node == ext[1]) {
            return res;
          }
        }
        res["hidden"] = true;
        return res;
      });

      return () => {
        renderer.kill();
      };
    },
  };
};
