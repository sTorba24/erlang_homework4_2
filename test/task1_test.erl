-module(task1_test).
-include_lib("eunit/include/eunit.hrl").
task1_test_() -> [
    ?_assert(lesson3_task1:first_word(<<"Some text">>) =:= <<"Some">>),
    ?_assert(lesson3_task1:first_word(<<"Hello world!">>) =:= <<"Hello">>),
    ?_assert(lesson3_task1:first_word(<<"SingleWord">>) =:= <<"SingleWord">>),
    ?_assert(lesson3_task1:first_word(<<" Leading space">>) =:= <<"Leading">>),
    ?_assert(lesson3_task1:first_word(<<"">>) =:= <<"">>)
].
