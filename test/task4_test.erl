-module(task4_test).
-include_lib("eunit/include/eunit.hrl").

task4_test_() ->
    Json = <<"{'squadName': 'Super hero squad','formed': 2016,'active': true,'members': [{'name': 'Molecule Man','age': 29,'powers': ['Radiation resistance','Turning tiny']}]}">>,
    
    [
    
        ?_assert(
            lesson3_task4:decode(Json, proplist) =:= 
            [{<<"squadName">>,<<"Super hero squad">>},
 {<<"members">>,
  [[{<<"powers">>,
     [<<"Radiation resistance">>,<<"Turning tiny">>]},
    {<<"name">>,<<"Molecule Man">>},
    {<<"age">>,29}]]},
 {<<"formed">>,2016},
 {<<"active">>,true}]
        ),

    
        ?_assert(
            lesson3_task4:decode(Json, map) =:= 
            #{
                <<"squadName">> => <<"Super hero squad">>,
                <<"formed">> => 2016,
                <<"active">> => true,
                <<"members">> => [
                    #{
                        <<"name">> => <<"Molecule Man">>,
                        <<"age">> => 29,
                        <<"powers">> => [<<"Radiation resistance">>, <<"Turning tiny">>]
                    }
                ]
            }
        )
    ].
