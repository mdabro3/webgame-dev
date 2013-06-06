-module(strat_game_drawing_controller, [Req]).
-compile(export_all).

draw('GET', []) ->
	ok.	

clear('POST', []) ->
        Fn = fun(X) -> boss_db:delete(X:id()) end,
        Res = lists:map(Fn, boss_db:find(point, [])),
%        {redirect, "/drawing/draw"}.
	{json, [{clear, 'true'}]};

clear('GET', []) ->
       LastTimestamp = boss_mq:now("clear"),
       {ok, Timestamp, Del} = boss_mq:pull("clear", LastTimestamp),
       {json, [{timestamp, Timestamp}, {clear, 'true'}]}.
