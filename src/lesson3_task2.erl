-module(lesson3_task2).
-export([words/1]).

words(BinText) when is_binary(BinText) ->
    words(BinText, [], []).

words(<<>>, WordAcc, Words) ->
    FinalWords = if
        WordAcc == [] -> Words;
        true -> [binary:list_to_bin(lists:reverse(WordAcc)) | Words]
    end,
    lists:reverse(FinalWords);
words(<<Char, Rest/binary>>, WordAcc, Words) ->
    if
        Char =< 32 orelse Char == 160 orelse Char == $\t orelse Char == $\n orelse Char == $\r ->
            case WordAcc of
                [] -> words(Rest, [], Words);
                _ -> words(Rest, [], [binary:list_to_bin(lists:reverse(WordAcc)) | Words])
            end;
        true ->
            words(Rest, [Char | WordAcc], Words)
    end.
