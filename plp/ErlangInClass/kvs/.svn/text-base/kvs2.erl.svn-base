% ----------------------------------------------------------------
% Key-value server for distributed system, based on Ch. 10, Programming Erlang.
% ----------------------------------------------------------------
-module(kvs2).
%-export([start/1, store/2, lookup/1]).
-compile(export_all).

% Starts a key-value server on the given node:
start(Node) -> 
	put(kvsNode, Node),
	case is_running(Node) of
		true -> ok;
		false -> 
			spawn(Node, kvs, start, []),
			ok
	end.

% Checks for a key-value server on the given node:
is_running(Node) ->
	P = rpc:call(Node, erlang, whereis, [kvs]),
	P =/= undefined.

% Starts a key-value server on the local node:
start() ->
	put(kvsNode, node()),
	case whereis(kvs) of
		undefined -> 
			register(kvs, spawn(fun() -> loop() end));
		_ -> ok
	end.

% Asks the global key-value server to associate the given key with the 
% given value:
store(Key, Value) -> message_to_kvs({store, Key, Value}).

% Asks the global key-value server to look up the value associated with
% the given key:
lookup(Key) -> message_to_kvs({lookup, Key}).

% Sends the given message to the global key-value server:
message_to_kvs(Msg) ->
	% FIXME: make sure kvsNode is defined	
	{kvs, get(kvsNode)} ! {self(), Msg},
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
			loop();
		{die} ->
			ok;
		_Unexpected ->
			io:format("loop received unexpected message ~p~n", [_Unexpected]),
			loop()		
	end.
