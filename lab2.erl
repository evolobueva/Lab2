-module(lab2).
-export([reduce/3, filter/2, new/0, put/3, delete/2, get/2, find/2, put_lists/3, delete_lists/2, get_lists/2, find_lists/2]).

reduce(_, Start, []) -> Start;
reduce(F, Start, [H|T]) -> reduce(F, F(Start, H), T).

filter(P, L) -> [X || X <- L, P(X)].

exists([], _) -> false;
exists([{K, _}|_], K) -> true;
exists([{K, _}|T], M) -> exists(T, M).

new() -> [].

put(K, V, []) -> [{K, V}];
put(K, V, [{K, _} | T]) -> [{K, V} | T];
put(K, V, [H | T]) -> [H | put(K, V, T)].

delete(K, Db) -> filter(fun(X) -> X =/= K end, Db).

get(_, []) -> {error, "Key not exists!"};
get(K, [{K, V}|_]) -> V;
get(M, [{K, _}|T]) -> get(M, T).

find(V, Db) -> [K || {K, Value} <- Db, V =:= Value].

put_lists(K, V, Db) -> lists:append(Db, [{K, V}]).

delete_lists(K, Db) -> lists:filter(fun({Key, Value}) -> Key =/= K end, Db).

get_lists(K, Db) -> [X || {_, X} <- lists:filter(fun({Key, Value}) -> Key =:= K end, Db)).

find_lists(V, Db) -> [X || {X, _} <- lists:filter(fun({Key, Value}) -> Value =:= V end, Db)].