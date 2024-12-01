-module(task2_test).
-include_lib("eunit/include/eunit.hrl").
task2_test_() ->
[
    ?_assert(lesson3_task2:words(<<"">>) =:= []),

    ?_assert(lesson3_task2:words(<<"word">>) =:= [<<"word">>]),

    ?_assert(lesson3_task2:words(<<"hello world">>) =:= [<<"hello">>, <<"world">>]),

    ?_assert(lesson3_task2:words(<<"hello   world">>) =:= [<<"hello">>, <<"world">>]),

    ?_assert(lesson3_task2:words(<<"hello\tworld\nnext">>) =:= [<<"hello">>, <<"world">>, <<"next">>]),

    ?_assert(lesson3_task2:words(<<"hello\rworld">>) =:= [<<"hello">>, <<"world">>]),

    ?_assert(lesson3_task2:words(<<"   leading and trailing   ">>) =:= [<<"leading">>, <<"and">>, <<"trailing">>])
].