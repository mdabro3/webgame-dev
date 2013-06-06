-module(drawing, [Id]).
-compile(export_all).

-has({point, many, [{module, point}]}).
