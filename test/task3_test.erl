-module(task3_test).
-include_lib("eunit/include/eunit.hrl").

task3_test_() -> [
    fun() -> ?_assert(lesson3_task3:split(<<"">>, <<" ">>) =:= []) end,
    fun() -> ?_assert(lesson3_task3:split(<<"hello">>, <<" ">>) =:= [<<"hello">>]) end,
    fun() -> ?_assert(lesson3_task3:split(<<"hello world">>, <<" ">>) =:= [<<"hello">>, <<"world">>]) end,
    fun() -> ?_assert(lesson3_task3:split(<<"hello   world">>, <<" ">>) =:= [<<"hello">>, <<"">>, <<"">>, <<"world">>]) end,
    fun() -> ?_assert(lesson3_task3:split(<<"a,b,c">>, <<",">>) =:= [<<"a">>, <<"b">>, <<"c">>]) end,
    fun() -> ?_assert(lesson3_task3:split(<<",a,b,c,">>, <<",">>) =:= [<<"">>, <<"a">>, <<"b">>, <<"c">>, <<"">>]) end,
    fun() -> ?_assert(lesson3_task3:split(<<"hello<<>>world">>, <<"<<>>">>) =:= [<<"hello">>, <<"world">>]) end,
    fun() -> ?_assert(lesson3_task3:split(<<"hello<<>>><<>>world">>, <<"<<>>">>) =:= [<<"hello">>, <<"">>, <<"world">>]) end
].
