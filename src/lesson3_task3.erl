-module(lesson3_task3).
-export([split/2]).

split(BinText, Delimiter) when is_binary(BinText), is_binary(Delimiter) ->
    split(BinText, Delimiter, <<>>, []).

split(<<>>, _Delimiter, PartAcc, Parts) ->
    FinalParts = if
        PartAcc == <<>> -> Parts;
        true -> [PartAcc | Parts]
    end,
    lists:reverse(FinalParts);

split(BinText, Delimiter, PartAcc, Parts) ->
    DelimSize = erlang:byte_size(Delimiter),
    case BinText of
        <<Delimiter:DelimSize/binary, Rest/binary>> ->
            split(Rest, Delimiter, <<>>, [PartAcc | Parts]);
        <<Char, Rest/binary>> ->
            split(Rest, Delimiter, <<PartAcc/binary, Char>>, Parts)
    end.
