-module(strat_game_auth_controller, [Req]).
-compile(export_all).



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
        {redirect, "/", [ mochiweb_cookies:cookie("user_id", "", [{path, "/"}]), mochiweb_cookies:cookie("session_id", "", [{path, "/"}]) ]}.
