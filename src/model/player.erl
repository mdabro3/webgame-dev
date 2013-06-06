-module(player, [Id, Name, PasswordHash, Email, Group]).
-compile(export_all).
-define(SECRET_STRING, "Ohhh no you didn't!").

session_identifier() ->
	mochihex:to_hex(erlang:md5(?SECRET_STRING ++ Id)).

check_password(Password) ->
	Salt = mochihex:to_hex(erlang:md5(Name)),
	bson:utf8(user_lib:hash_password(Password, Salt)) =:= PasswordHash.

login_cookies() ->
	[ mochiweb_cookies:cookie("user_id", Id, [{path, "/"}]),
		 mochiweb_cookies:cookie("session_id", session_identifier(), [{path, "/"}]) ].

is_admin() ->
	case Group of
		admin ->
			true;
		_ ->
			false
	end.	 	
