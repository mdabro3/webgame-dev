-module(point, [Id, X, Y, N, DrawingId]).
-compile(export_all).
-belongs_to(drawing).

after_create() ->
	boss_mq:push("events", [{type, 'create'}, {data, [THIS]}]).
