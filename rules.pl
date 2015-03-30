%%Rules

is_loop(Event, Guard):- transition(Source, Source, Event, Guard, _), (Event \= null, Guard \= null).
all_loop(Set):- findall([Event, Guard], is_loop(Event, Guard), L), list_to_set(L, Set).
is_edge(Event, Guard):- transition(_, _, Event, Guard, _), (Event \= null ; Guard \= null).
size(Length):- findall([Event, Guard], is_edge(Event,Guard), L), length(L, Length).
is_link(Event, Guard):- transition(Source, Destination, Event, Guard, _), is_edge(Event, Guard), Source \= Destination.
all_superstates(Set):- findall([S1, S2], superstate(S1, S2), SuperstateList), list_to_set(SuperstateList, Set).
ancestor(Ancestor, Descendant):- superstate(Ancestor,Descendant).
ancestor(Ancestor, Descendant):- ancestor(superstate(Ancestor), Descendant).
all_states(L):- findall(State, state(State), L).
all_init_states(L):- findall(State, initial_state(State), L).
get_starting_state(State):- findall([Source, Destination], (initial_state(Source, Destination), Destination = null), State).
state_is_reflexive(State):- transition(State, State, _, _, _).
graph_is_reflexive(State):- findall(State, state_is_reflexive(State), L), length(L, Length), all_states(Lst), length(Lst, Length1), Length == Length1.
get_guards(Ret):- findall(Guard, transition(_, _, _, Guard, _), L), list_to_set(L, Ret).
get_events(Ret):- findall(Event, transition(_, _, Event, _, _), L), list_to_set(L, Ret).
get_actions(Ret):- findall(Action, transition(_, _, _, _, Action), L), list_to_set(L, Ret).
get_only_guarded(Ret):- findall([Source, Destination], (transition(Source, Destination, Guard, _, _), Guard \= null), Ret).
legal_events_of(State, L):- findall(State, (transition(State, _, Event, Guard, _), Event \= null, Guard \= null), L).