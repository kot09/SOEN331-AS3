%% PART 1

state(dormant).
state(init).
state(idle).
state(monitoring).
state(error_diagnosis).
state(safe_shutdown).

%%PART 2

state(boot_hw).
state(senchk).
state(tchk).
state(psichk).
state(ready).

%%PART 3

state(monidle).
state(regulate_environment).
state(lockdown).

%%PART 4

state(prep_vpurge).
state(alt_psi).
state(alt_temp).
state(risk_assess).
state(safe_status).

%PART 5
state(error_rcv).
state(reset_module_data).
state(applicable_rescue).

%% superstate(S1, S2) implies that S1 is the superstate of S2

superstate(init,boot_hw).
superstate(init,senchk).
superstate(init,tchk).
superstate(init,psichk).
superstate(init,ready).

superstate(monitoring,monidle).
superstate(monitoring,regulate_environment).
superstate(monitoring,lockdown).

superstate(lockdown,prep_vpurge).
superstate(lockdown,alt_psi).
superstate(lockdown,alt_temp).
superstate(lockdown,risk_assess).
superstate(lockdown,safe_status).

superstate(error_diagnosis,error_rcv).
superstate(error_diagnosis,reset_module_data).
superstate(error_diagnosis,applicable_rescue).

%%

initial_state()


