-module(lesson3_task4).
-export([decode/2]).

decode(JsonBin, Format) when is_binary(JsonBin), is_atom(Format) ->
    JsonStr = prepare_json(JsonBin),
    {Parsed, _Rest} = parse_value(JsonStr),
    case Format of
        map -> Parsed;
        proplist -> map_to_proplist(Parsed)
    end.

prepare_json(Bin) when is_binary(Bin) ->
    prepare_json(binary_to_list(Bin), []).

prepare_json([], Acc) ->
    lists:reverse(Acc);
prepare_json([Char | Rest], Acc) when Char == $' ->
    prepare_json(Rest, [$" | Acc]);
prepare_json([Char | Rest], Acc) ->
    prepare_json(Rest, [Char | Acc]).

% Парсинг значення
parse_value([C | Rest]) when C == $" ->
    parse_string(Rest, []);
parse_value([C | Rest]) when C == ${ ->
    parse_object(Rest, #{});
parse_value([C | Rest]) when C == $[ ->
    parse_array(Rest, []);
parse_value([C | Rest]) when C >= $0, C =< $9; C == $- ->
    parse_number([C | Rest], []);
parse_value([$t, $r, $u, $e | Rest]) -> {true, Rest};
parse_value([$f, $a, $l, $s, $e | Rest]) -> {false, Rest};
parse_value([$n, $u, $l, $l | Rest]) -> {null, Rest};
parse_value([$, | Rest]) -> parse_value(Rest);
parse_value([C | Rest]) when C == $\s; C == $\n; C == $\t -> parse_value(Rest);
parse_value(Rest) -> {undefined, Rest}.

parse_string([$" | Rest], Acc) ->
    {list_to_binary(lists:reverse(Acc)), Rest};
parse_string([Char | Rest], Acc) ->
    parse_string(Rest, [Char | Acc]).


parse_object([$} | Rest], Acc) ->
    {Acc, Rest};
parse_object(List, Acc) ->
    {Key, Rest1} = parse_value(skip_whitespace(List)),
    {Value, Rest2} = parse_value(skip_whitespace(skip_colon(Rest1))),
    NewAcc = maps:merge(#{Key => Value}, Acc),
    parse_object(skip_whitespace(skip_comma(Rest2)), NewAcc).

parse_array([$] | Rest], Acc) ->
    {lists:reverse(Acc), Rest};
parse_array(List, Acc) ->
    {Value, Rest1} = parse_value(skip_whitespace(List)),
    parse_array(skip_whitespace(skip_comma(Rest1)), [Value | Acc]).

parse_number([C | Rest], Acc) when C >= $0, C =< $9; C == $-; C == $. ->
    parse_number(Rest, [C | Acc]);
parse_number(Rest, Acc) ->
    {list_to_integer(lists:reverse(Acc)), Rest}.

skip_whitespace([C | Rest]) when C == $\s; C == $\n; C == $\t ->
    skip_whitespace(Rest);
skip_whitespace(List) ->
    List.

skip_colon([$: | Rest]) -> Rest;
skip_colon(List) -> List.

skip_comma([$, | Rest]) -> Rest;
skip_comma(List) -> List.

map_to_proplist(Map) ->
    maps:fold(fun(Key, Value, Acc) ->
        case Value of
            V when is_map(V) -> [{Key, map_to_proplist(V)} | Acc];
            V when is_list(V) -> [{Key, list_to_proplist(V)} | Acc];
            _ -> [{Key, Value} | Acc]
        end
    end, [], Map).

list_to_proplist(List) ->
    lists:map(fun(Item) ->
        case Item of
            V when is_map(V) -> map_to_proplist(V);
            _ -> Item
        end
    end, List).
