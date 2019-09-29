
params ["_roleToSet"];

_currentRole = player call ht_fnc_getRole;

_validRoles = ["Rifle", "Medic", "Specialist", "AT", "MG", "Leader"];

if(_currentRole == "") then {
	if(_roleToSet in _validRoles) then {
		player setVariable["selectedRole", _roleToSet, true];
		diag_log format ["Selected role %1", _roleToSet];

	} else {
		diag_log format ["Selected role %1 not a valid role", _roleToSet];
	}

} else {
	if(_currentRole == _roleToSet) then {
		if(_roleToSet in _validRoles) then {
			player setVariable["selectedRole", _roleToSet, true];
			diag_log format ["Selected role %1", _roleToSet];

		} else {
			diag_log format ["Selected role %1 not a valid role", _roleToSet];
		}
	}
};

