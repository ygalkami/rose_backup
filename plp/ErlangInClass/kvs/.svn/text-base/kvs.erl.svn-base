% ----------------------------------------------------------------
% Basic key-value server, based on Ch. 10, Programming Erlang.
% ----------------------------------------------------------------
-module(kvs).
-export([start/0, store/2, lookup/1]).

% Starts a key-value server on the local node:
start() -> register(kvs, spawn(fun() -> loop() end)).

% Asks the global key-value server to associate the given key with the 
% given value:
store(Key, Value) -> message_to_kvs({store, Key, Value}).

% Asks the global key-value server to look up the value associated with
% the given key:
lookup(Key) -> message_to_kvs({lookup, Key}).

% Sends the given message to the global key-value server:
message_to_kvs(Msg) ->
	kvs ! {self(), Msg},
	receive
		{kvs, Reply} -> Reply
	end.

% Main loop for the key-value server.  Uses the process dictionary,
% despite Armstrongs exhortations to the contrary:
loop() ->
	receive
		{From, {store, Key, Value}} ->
			put(Key, {ok, Value}),
			From ! {kvs, true},
			loop();
		{From, {lookup, Key}} ->
			Value = get(Key),
			From ! {kvs, Value},
			loop()
	end.
