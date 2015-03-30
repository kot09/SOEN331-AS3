%% PART 1

state(dormant).
state(kill).
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
state(exit).

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

%% initial_state(S1, S2) implies that S1 is the initial state of S2

initial_state(dormant, null).
initial_state(boot_hw, init).
initial_state(monidle, monitoring).
initial_state(prep_vpurge, lockdown).
initial_state(error_rcv, error_diagnosis).

%%transition(Source, Destination, Event, Guard, Action)
%% how do we do begin dormant

%%Top level transitions
transition(dormant, init, start, null, load_driver).
transition(dormant, exit, kill, null, null).
transition(init, idle, init_ok, null, null).
transition(init, error_diagnosis, init_crash, null, 'init_err_msg ; err_save_protocol').
transition(error_diagnosis, init, retry_init, 'retry < 3', 'retry++').
transition(idle, error_diagnosis, idle_crash, null, 'idle_err_msg ; err_save_protocol').
transition(error_diagnosis, idle, idle_rescue, null, null).
transition(error_diagnosis, safe_shutdown, shutdown, 'retry => 3', clean_previous_state).
transition(safe_shutdown, dormant, sleep, 'null', null).
transition(idle, monitoring, begin_monitoring, null, null).
transition(monitoring, error_diagnosis, monitor_crash, null, 'monitor_err_msg ; err_save_protocol').
transition(error_diagnosis, monitoring, moni_resue, null, null).
transition(boot_hw, senchk, hw_ok, null, null).
transition(senchk, tchk, senok, null, null).
transition(tchk, psichk, t_ok, null, null).
transition(psichk, ready, psi_ok, null, null).
transition(monidle, lockdown, contagion_alert, null, 'FACILITY_CRIT_MESG ; inlockdown = true').
transition(lockdown, monidle, purge_succ, null, 'inlockdown = false').
transition(monidle, regulate_environment, no_contagion, null, null).
transition(regulate_environment, monidle, after_100ms, null, null).
transition(prep_vpurge, alt_psi, null, null, lock_doors).
transition(prep_vpurge, alt_temp, null, null, lock_doors).
transition(alt_psi, risk_assess, tcyc_comp, null, null).
transition(alt_temp, risk_assess, psichyc_comp, null, null).
transition(risk_assess, safe_status, null, 'risk < 1', null).
transition(risk_assess, prep_vpurge, null, 'risk => 1', null).
transition(error_rcv, reset_module_data, null, 'err_protocol_def == false', null).
transition(error_rcv, applicable_rescue, null, 'err_protocol_def == true', null).
transition(reset_module_data, exit, 'reset_to_data', null, null).
transition(applicable_rescue, exit, 'apply_protocol_rescues', null, null).