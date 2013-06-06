-module(strat_game_player_controller, [Req]).
-compile(export_all).


before_(_) ->
	user_lib:require_login(Req).


login('GET', []) ->
	{ok, [{redirect, Req:header(referer)}]};


login('POST', []) ->
	Name = Req:post_param("name"),
	case boss_db:find(player, [{name, Name}], 1) of
		[Player] ->
			case Player:check_password(Req:post_param("password")) of
				true ->
					{redirect, proplists:get_value("redirect", Req:post_params(), "/"), Player:login_cookies()};
				false ->
					{ok, [{error, "Bad name/password combination"}]}
			end;
		[] ->
			{ok, [{error, "No Player named " ++ Name}]}
	end.


logout('GET', []) ->
	{redirect, [{action, "home"}], [ mochiweb_cookies:cookie("user_id", "", [{path, "/"}]), mochiweb_cookies:cookie("session_id", "", [{path, "/"}]) ]}.


home('GET', [], Player) ->
	{ok, [{player, Player}]}.


list('GET', []) ->
	Players = boss_db:find(player, []),
	{ok, [{players, Players}]}.

create('GET', [], Player) ->
	case Player:is_admin() of
		true ->
			ok;
		false ->
			{ok, [{error, "Invalid Permissions"}]}
	end;
create('POST', [], Player) ->
	PlayerName = Req:post_param("player_name"),
	Email = Req:post_param("email"),
	PasswordHash = user_lib:hash_for(PlayerName, Req:post_param("password")),
	P1 = player:new(id, PlayerName, PasswordHash, Email, user),
	P1:save(),
	{redirect, [{action, "list"}]}.	

delete('POST', []) ->
	boss_db:delete(Req:post_param("player_id")),
	{redirect, [{action, "list"}]}.

edit('POST', []) ->
	Player = boss_db:find(Req:post_param("player_id")),
	{ok, [{player, Player}]}.

save_edit('POST', []) ->
	PlayerName = Req:post_param("player_name"),
	Email = Req:post_param("email"),
	ID = Req:post_param("id"),
	PasswordHash = user_lib:hash_for(PlayerName, Req:post_param("password")),
	Player = player:new(ID, PlayerName, PasswordHash, Email),
	Player:save(),
	{redirect, [{action, "list"}]}.
