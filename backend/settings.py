S = ParametricPlot3D[ (Cos[t/2]^2 + Sin[s/2] + 2*Cos[s]*Sin[t]) {Cos[t] Sin[s], 
     Sin[t] Sin[s], Cos[s]}/2, {t, 0, 2 Pi}, {s, 0, Pi}, 
  PlotStyle -> Directive[Opacity[0.7], Blue, Specularity[White, 10]], 
  MeshStyle -> {{Yellow, Thickness[0.001]}, {Orange, 
     Thickness[0.001]}}, Axes -> False, Boxed -> False]