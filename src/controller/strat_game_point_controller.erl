-module(strat_game_point_controller, [Req]).
-compile(export_all).

events('GET', []) ->
	Fn = fun(X) -> [{x,X:x()},{y,X:y()}] end,
	Points = lists:map(Fn, boss_db:find(point, [], all, 0, n, num_ascending)),
	TimeStamp = boss_mq:now("events"),
	{json, [{event, [{type, 'create'}, {data, Points}]}, {timestamp, TimeStamp}]};

events('GET', [LastTimestamp]) ->
	{ok, Timestamp, [Event|_]} = boss_mq:pull("events", list_to_integer(LastTimestamp)),
	{json, [{timestamp, Timestamp}, {event, Event}]}.

points('POST', []) ->
	[Drawing|_] = boss_db:find(drawing, []),
	X = Req:post_param("x"),
	Y = Req:post_param("y"),
	N = boss_db:count(point),
	Point = point:new(id, X, Y, N, Drawing:id()),
	{ok, SavedPoint} = Point:save(),
	%{redirect, "/drawing/draw"}.
	%{redirect, [{action, "events"}]}.
	{json, [{status, 'ok'}]}.

clear('POST', []) ->
	Fn = fun(X) -> boss_db:delete(X:id()) end,
	Res = lists:map(Fn, boss_db:find(point, [])),
	boss_mq:push("events", [{type, 'clear'}]),
	%{redirect, [{action, "events"}]};
	{json, [{status, 'ok'}]};

clear('GET', []) ->
	LastTimestamp = boss_mq:now("clear"),
	{ok, Timestamp, Del} = boss_mq:pull("clear", LastTimestamp),
	{json, [{timestamp, Timestamp}, {clear, 'true'}]}.
